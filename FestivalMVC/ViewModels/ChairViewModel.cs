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

        private const char automatic = 'A';
        private const char open = 'B';
        private const char closed = 'C';
        private const char complete = 'D';

        public EventViewModel(Event ev, string instrumentName)
        {
            Event = ev;
            InstrumentName = instrumentName;
        }

        public Event Event { get; }
        public string InstrumentName { get; }
        public string EventDescription { get => string.Format("{0:MMM d}", Event.EventDate) + " " + InstrumentName; }

        public bool CanRate
        {
            get
            {
                return (CurrentTime.CompareTo(Event.EventDate) > 0);
            }
        }

        public bool CanSchedule
        {
            get
            {
                return (CurrentTime.CompareTo(Event.CloseDate) > 0);
            }
        }
        public bool CanEnroll
        {
            get
            {
                if (CanRate)
                    return false;
                if (Event.Status == open)
                    return true;
                if (Event.Status == automatic)
                    return ComputeIfOpen();
                return false;
            }
        }

        private DateTime CurrentTime
        {
            get
            {
                return DateTime.Now; // can make it specific to a time zone
            }
        }

        private string StatusDesc()
        {
            switch (Event.Status)
            {
                case automatic: return $"Automatic ({ComputeStatus()}) ";
                case open: return "Open";
                case closed: return "Closed";
                case complete: return "Complete";
                default: return "Invalid Data";
            }
        }

        private string ComputeStatus()
        {
            return ComputeIfOpen() ? "Open" : "Closed";
        }

        private bool ComputeIfOpen()
        {
            return (CurrentTime.CompareTo(Event.OpenDate) > 0 && CurrentTime.CompareTo(Event.CloseDate) < 0);
        }

        public string MenuKey
        {
            get
            {
                return (CanRate ? "R" : "") + (CanSchedule ? "S" : "") + (CanEnroll ? "E" : "");
            }
        }

        public string NextPage
        {
            get
            {
                if (CanRate)
                    return "Ratings";

                if (CanSchedule)
                    return "Schedule";

                if (CanEnroll)
                    return "Entries";

                return "Prepare";

            }
        }


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


        public bool HasEvents { get => (_events.Count() > 0); }

        public Location Location { get => _location; }

    }
}
