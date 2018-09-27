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

        private DateTime CurrentTime
        {
            get
            {
                return DateTime.Now; // can make it specific to a time zone
            }
        }

        public string StatusDesc
        {
            get
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
                if (CurrentTime.CompareTo(Event.CloseDate) > 0 || Event.Status == closed)
                    return "IPESR";
                else if (CurrentTime.CompareTo(Event.OpenDate) > 0 || Event.Status == open)
                    return "IPE";
                else
                    return "IP";

            }

               // return  (CanPrepare ? "P" : "") + (CanRate ? "R" : "") + (CanSchedule ? "S" : "") + (CanEnroll ? "E" : "");
            //}
        }

        public string NextPage
        {
            get
            {
                var menuKey = MenuKey;
                if (CurrentTime.CompareTo(Event.EventDate)>0)
                    return "Ratings";

                if (CurrentTime.CompareTo(Event.CloseDate) > 0)
                    return "Schedule";

                if (CurrentTime.CompareTo(Event.OpenDate) > 0)
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

        public EventsViewModel(bool forTeacher)
        {
            var location = Admin.LocationIdSecured;
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
                       select new EventViewModel(p, InstrumentName(p.Instrument));
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
