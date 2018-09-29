using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{

    public class EventsViewModel
    {
        private readonly IEnumerable<Event> _events;
        private readonly IEnumerable<Instrum> _instruments;
        private readonly Location _location;
        private readonly bool _forTeacher;

        public EventsViewModel(bool forTeacher)
        {
            var location = Admin.LocationIdSecured;
            _forTeacher = forTeacher;

            if (forTeacher)
            {
                SQLData.SelectEventsForTeacher(location, DateTime.Now, out _events, out _instruments, out _location);
            }
            else
            { 
                SQLData.SelectEventsForDistrict(location, out _events, out _instruments, out _location);
            }

        }

        public string InstrumentName(char id)
        {
            return (from p in _instruments
                    where p.Id == id
                    select p.Instrument).Single().ToString();
        }


        public IEnumerable<EventViewModel> Events
        {
            get
            {
                return from p in _events
                select new EventViewModel(p, InstrumentName(p.Instrument),!_forTeacher);
            }
        }


        public int EventCount { get => _events.Count(); }
        public Location Location { get => _location; }

    }


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

}
