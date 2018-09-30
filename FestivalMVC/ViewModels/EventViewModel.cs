using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{
    public struct EventViewModel
    {

        private const char automatic = 'A';
        private const char open = 'B';
        private const char closed = 'C';
        private const char complete = 'D';

        public EventViewModel(Event ev, string instrumentName, bool canEdit)
        {
            Event = ev;
            InstrumentName = instrumentName;
            CanEdit = canEdit;
        }

        public Event Event { get; }
        public string InstrumentName { get; }
        public string EventDescription { get => string.Format("{0:MMM d}", Event.EventDate) + " " + InstrumentName; }
        public bool CanEdit { get; set; }

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
                    case complete: return "Complete";
                    case automatic: return ComputeStatus();
                    case open: return "( Open )";
                    case closed: return "( Closed )";
                    default: return "Invalid Data";
                }
            }
        }

        public string EventTypesDesc
        {
            get
            {
                string ret = "";
                for (var i = 0; i < Event.ClassTypes.Length; i++)
                {
                    ret = ret + "," + eventTypeDesc(Event.ClassTypes[i]);
                }
                if (ret.Length > 0)
                    ret = ret.Substring(1);

                return ret;

                string eventTypeDesc(char c)
                {
                    switch (c)
                    {
                        case 'C': return "Concerto";
                        case 'S': return "Solo";
                        default: return "???";
                    }
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
                if (CanEdit) //Chair
                {
                    if (CurrentTime.CompareTo(Event.CloseDate) > 0 || Event.Status == closed)
                        return "IPESR";
                    else if (CurrentTime.CompareTo(Event.OpenDate) > 0 || Event.Status == open)
                        return "IPE";
                    else
                        return "IP";
                }
                else //Teacher
                {
                    if (CurrentTime.CompareTo(Event.OpenDate) < 0 || Event.Status == open)
                        return "IR";
                    if (CurrentTime.CompareTo(Event.CloseDate) < 0 || Event.Status == open)
                        return "IRE";
                    return "I";
                }

            }
        }

        public string NextPage
        {
            get
            {
                var menuKey = MenuKey;
                if (CurrentTime.CompareTo(Event.EventDate) > 0)
                    return "Ratings";

                if (CurrentTime.CompareTo(Event.CloseDate) > 0)
                    return "Schedule";

                if (CurrentTime.CompareTo(Event.OpenDate) > 0)
                    return "Entries";

                return "Prepare";

            }
        }

    }

}