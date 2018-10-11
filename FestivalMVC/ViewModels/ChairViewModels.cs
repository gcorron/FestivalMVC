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
        private IEnumerable<ScheduleModel> _schedule;
        private IEnumerable<UnscheduledSummaryModel> _summary;
        private Event _event;

        public SchedulePageViewModel(Event ev)
        {
            SQLData.SelectScheduleSetupData(ev.Id, out _summary, out _schedule);
            _event = ev;
        }

        public IEnumerable<ScheduleModel> Schedule { get => _schedule; }
        public IEnumerable<UnscheduledSummaryModel> Summary { get => _summary; }
        public string EventTime(DateTime startTime)
        {
            return $"Day { (startTime - _event.EventDate).Days + 1 } { startTime:H:mm}";
        }

    }

}
