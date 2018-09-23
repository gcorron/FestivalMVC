using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{

    public struct EventViewModel
    {

        public EventViewModel(Event ev, string instrumentName)
        {
            Event = ev;
            InstrumentName = instrumentName;
        }

        public Event Event { get; }
        public string InstrumentName { get; }
    }

    public class EventsViewModel
    {
        private readonly IEnumerable<Event> _events;
        private readonly IEnumerable<Instrum> _instruments;
        private readonly Location _location;

        public EventsViewModel()
        {
            var location = Admin.LocationIdSecured;
            SQLData.SelectEventsForDistrict(location, out _events, out _instruments, out _location);


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
                select new EventViewModel(p, InstrumentName(p.Instrument));
            }
        }


        public bool HasEvents
        {
            get
            {
                return (_events.Count() > 0);
            }

        }
        public Location Location
        {
            get
            {
                return _location;
            }
        }
    }
}
