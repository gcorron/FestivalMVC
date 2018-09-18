using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public struct Event
    {
        public int Id { get; set; }
        public int Location { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime CloseDate { get; set; }
        public DateTime EventDate { get; set; }
        public char Instrument { get; set; }
        public char Status { get; set; }
    }

    public struct SelectedEvent
    {
        private const char automatic = 'A';
        private const char open = 'B';
        private const char closed = 'C';
        private const char complete = 'D';



        public Event Event { private get; set; }
        public int Id { get; }
        public string Desc
        {
            get
            {
                return $"{Event.EventDate.ToLongDateString()} {InstrumentName()} Status: {StatusDesc()}";
            }
        }

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
                return (CurrentTime.CompareTo(Event.CloseDate)>0);
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
                return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now, "UTC", "Pacific Daylight Time");
            }
        }

        private string InstrumentName()
        {
            switch (Event.Instrument)
            {
                case 'P': return "Piano";
                case 'V': return "Voice";
                case 'W': return "Winds";
                case 'S': return "Strings";
                default: return "?";
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
    }


    public struct TeacherEvent
    {
        public int Event { get; set; }
        public int Teacher { get; set; }
    }
}