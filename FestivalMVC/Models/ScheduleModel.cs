using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace FestivalMVC.Models
{
    public struct UnscheduledSummaryModel
    {
        public string ClassTypeDesc { get;}
        public string AuditionMinutes { get;}
        public Int16 TotalMinutes { get;}
        public Int16 Number { get;}
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

        public string AuditionTimeString { get => $"{AuditionTime:h:mm tt}"; }
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

        public bool BeginProcess(int ev)
        {
            SQLData.SelectDataForGeneratingSchedule(ev, out _schedules, out _entries);
            return Task.Run(() => Process()).Result;
        }

        private bool Process()
        {

            ProcessAuditionModel foundEntry;

            _auditions = new List<ProcessAuditionModel>();
            while (_entries.Count > 0 && _schedules.Count > 0) //finished when either one is exhausted
            {
                for (var i = 0; i < _schedules.Count;)
                {
                    var schedule = _schedules[i];
                    IEnumerable<ProcessAuditionModel> query;
                    if (schedule.ClassType != _ANY)
                        query = _entries.Where(p => p.ClassType == schedule.ClassType && p.AuditionMinutes < schedule.MinutesRemain);
                    else
                        query = _entries.Where(p => p.AuditionMinutes < schedule.MinutesRemain);
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
                    try
                    {
                        foundEntry = query.Select(p => p).First();
                    }
                    catch (Exception e) //none matching, toss the schedule
                    {
                        _schedules.Remove(schedule);
                        continue;
                    }
                    foundEntry.AuditionTime = schedule.AuditionTime;
                    foundEntry.Schedule = schedule.Id;
                    schedule.MinutesRemain -= foundEntry.AuditionMinutes;
                    schedule.AuditionTime = schedule.AuditionTime.AddMinutes(foundEntry.AuditionMinutes);
                    _entries.Remove(foundEntry);
                    _auditions.Add(foundEntry);
                    i++; // on to the next schedule
                }

            }
            //now save the audtion results
            foreach (var audition in _auditions)
            {
                SQLData.InsertAudition(audition);
            }

            return _entries.Count == 0; //if successfully scheduled all entries

        }


    }

}