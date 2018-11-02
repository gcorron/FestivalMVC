using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace FestivalMVC.Models
{
    public struct UnscheduledSummaryModel
    {
        public string ClassTypeDesc { get; }
        public Int16 TotalMinutes { get; }
        public Int16 Number { get; }
    }

    public struct ScheduledSummaryModel
    {
        public string FirstName { get; }
        public string LastName { get; }
        public string Phone { get; }
        public char ClassType { get; }
        public string ClassAbbr { get; }
        public string JudgeName { get; }
        public DateTime AuditionTime { get; }

        public string AuditionTimeString
        {
            get
            {
                if (AuditionTime.Ticks == 0)
                    return "- - -";
                else
                    return $"{AuditionTime:h:mm tt}";
            }
        }

        public string StudentName { get => $"{FirstName} {LastName}"; }
    }

    public struct ScheduleModel
    {
        public int Id { get; set; }
        public int Judge { get; set; }
        public DateTime StartTime { get; set; }
        public Int16 Minutes { get; set; }
        public char PrefHighLow { get; set; }
        public char ClassType { get; set; }
    }

    public class ProcessScheduleModel
    {
        public int Id { get; }
        public char ClassType { get; }
        public char PrefHighLow { get; }
        public DateTime StartTime { get; }

        public DateTime AuditionTime { get; set; }
        public Int16 MinutesRemain { get; set; }
    }

    public class ProcessAuditionModel
    {
        public int Id { get; }
        public int Student { get; }
        public char ClassType { get; }
        public Int16 AuditionMinutes { get; }

        public int Schedule { get; set; }
        public DateTime? AuditionTime { get; set; }
    }

    public class AuditionGenerator
    {
        private List<ProcessScheduleModel> _schedules;
        private List<ProcessAuditionModel> _entries;
        private List<ProcessAuditionModel> _auditions;
        private const char _ANY = '*';
        private const char _HIGH = 'H';
        private const char _LOW = 'L';

        public async Task<bool> Process(int ev, bool generate)
        {
            SQLData.SelectDataForGeneratingSchedule(ev, out _schedules, out _entries);
            if (!generate)
                return true;

            return await Task.Factory.StartNew(() =>
            {
            bool conflict;
            bool processedOne;
            bool foundInConflictList;

            ProcessAuditionModel foundEntry;
            ProcessAuditionModel compareEntry;
            var conflictList = new List<ProcessAuditionModel>();
            IEnumerable<ProcessAuditionModel> query;

            _auditions = new List<ProcessAuditionModel>();

            while ((_entries.Count > 0 || conflictList.Count > 0) && _schedules.Count > 0) //finished when either entries or schedules are empty
            {
                processedOne = false;
                for (var i = 0; i < _schedules.Count; i++) //go through all the schedules in sequence, and try to find an entry for each (loop over and over until done)
                {
                    var schedule = _schedules[i];

                    foundInConflictList = false;
                    query = BuildQuery(schedule, _entries);
                    foundEntry = query.Select(p => p).FirstOrDefault();

                    if (foundEntry is null && conflictList.Count > 0)
                    {
                        query = BuildQuery(schedule, conflictList);
                        foundEntry = query.Select(p => p).FirstOrDefault();
                        foundInConflictList = !(foundEntry is null);
                    }

                    if (foundEntry is null)
                        continue;

                    //check if this student is already scheduled with a different classification within 30 minutes of this audition
                    compareEntry = _auditions.Where(p => p.Student == foundEntry.Student).FirstOrDefault();
                    conflict = false;
                    if (!(compareEntry is null))
                        if (compareEntry.Schedule != foundEntry.Schedule) //different judge (possibly), possible conflict of times
                            if (Math.Abs((compareEntry.AuditionTime - schedule.AuditionTime).Value.Minutes) < 30)
                                conflict = true;

                    if (foundInConflictList)
                        conflictList.Remove(foundEntry);
                    else
                        _entries.Remove(foundEntry);

                    if (conflict)
                    {
                        conflictList.Add(foundEntry);
                    }
                    else
                    {
                        foundEntry.AuditionTime = schedule.AuditionTime;
                        foundEntry.Schedule = schedule.Id;
                        _auditions.Add(foundEntry);
                        schedule.MinutesRemain -= foundEntry.AuditionMinutes;
                        schedule.AuditionTime = schedule.AuditionTime.AddMinutes(foundEntry.AuditionMinutes);
                        processedOne = true;
                    }
                } //next schedule
                if (!processedOne)
                {
                    for (var i = 0; i < _schedules.Count;)
                    {
                        _schedules[i].AuditionTime = _schedules[i].AuditionTime.AddMinutes(5);
                        _schedules[i].MinutesRemain -= 5;
                        if (_schedules[i].MinutesRemain <= 0)
                            _schedules.Remove(_schedules[i]);
                        else
                            i++;
                    }
                }

            } // end while

            //now save the audtion results
            foreach (var audition in _auditions)
            {
                SQLData.InsertAudition(audition);
            }
            return _entries.Count == 0 && conflictList.Count == 0; //if successfully scheduled all entries
            });
        }

        IEnumerable<ProcessAuditionModel> BuildQuery(ProcessScheduleModel schedule, IEnumerable<ProcessAuditionModel> entries)
        {
            IEnumerable<ProcessAuditionModel> query;
            if (schedule.ClassType != _ANY)
                query = entries.Where(p => p.ClassType == schedule.ClassType && p.AuditionMinutes < schedule.MinutesRemain);
            else
                query = entries.Where(p => p.AuditionMinutes < schedule.MinutesRemain);
            switch (schedule.PrefHighLow)
            {
                case _ANY:
                    break;
                case _HIGH:
                    query = query.OrderByDescending(p => p.AuditionMinutes);
                    break;
                case _LOW:
                    query = query.OrderBy(p => p.AuditionMinutes);
                    break;
                default: throw new Exception("Invalid High-Low Preference in Schedule!");
            }
            return query;
        }
    }
}