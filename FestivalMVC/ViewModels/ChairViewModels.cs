using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{

    public struct PreparePageViewModel
    {
        // Constructor
        public PreparePageViewModel(int eventId)
        {

            SQLData.SelectTeachersForEvent(eventId, out IEnumerable<ContactForView> teachers, out IEnumerable<Judge> judges);

            PeopleViewModel = new PeopleViewModel(teachers, "Teachers");
            Judges = judges;
        }

        public PeopleViewModel PeopleViewModel { get; private set; }
        public IEnumerable<Judge> Judges { get; private set; }

    }

    public class SchedulePageViewModel
    {
        private readonly IEnumerable<ScheduleModel> _schedule;
        private readonly IEnumerable<UnscheduledSummaryModel> _summary;
        private readonly IEnumerable<ScheduledSummaryModel> _entrySchedule;
        private readonly IEnumerable<Judge> _judges;

        private EventViewModel _event;


#region constructors
        public SchedulePageViewModel(EventViewModel ev)
        {
            SQLData.SelectScheduleSetupData(ev.Event.Id, out _summary, out _entrySchedule, out _schedule, out _judges);
            _event = ev;
        }

        public SchedulePageViewModel(EventViewModel ev, ScheduleModel schedule)
        {
            SQLData.UpdateSchedule(schedule,out _schedule, out _judges);
            _event = ev;
        }

        public SchedulePageViewModel(EventViewModel ev, int id)
        {
            SQLData.DeleteSchedule(id, out _schedule, out _judges);
            _event = ev;
        }
#endregion

        public IEnumerable<ScheduleModel> Schedule { get => _schedule; }
        public IEnumerable<UnscheduledSummaryModel> Summary { get => _summary; }
        public IEnumerable<Judge> Judges { get => _judges; }
        public IEnumerable<ScheduledSummaryModel> EntrySchedule { get => _entrySchedule; }
        public DateTime EventDate { get => _event.Event.EventDate;}
        public bool CanSchedule { get => _event.ComputeIfScheduling(); }
        public string ClassTypes { get => _event.Event.ClassTypes; }

        public string JudgeName(int id)
        {
            return (from judge in _judges
                    where judge.Id == id
                    select judge.Name).Single<string>();
        }

        public string EventTime(ScheduleModel schedule)
        {
            var endtime = schedule.StartTime.AddMinutes(schedule.Minutes);
            return $"Day { (schedule.StartTime - _event.Event.EventDate).Days + 1 } { schedule.StartTime:h:mm tt} - { endtime:h:mm tt}";
        }
        public string LevelPreference(char prefHighLow)
        {
            switch (prefHighLow)
            {
                case 'H':return "High";
                case 'L':return "Low";
                case '*':return "Any";
                default:return "?";
            }
        }
        public string ClassPreference(char pref)
        {
            switch (pref)
            {
                case '*': return "Any";
                default: return pref.ToString();
            }
        }

    }

}
