using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public static class EventStatusTypes
    {
        public const char Auto = 'A';
        public const char Open = 'B';
        public const char Closed = 'C';
        public const char Completed = 'D';
    }

    [Serializable]
    public struct Event
    {
        private string _venue;
        private string _notes;

        public int Id { get; set; }
        public int Location { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime CloseDate { get; set; }
        public DateTime EventDate { get; set; }
        public char Instrument { get; set; }
        public char Status { get; set; }
        public string Venue { get => _venue; set => _venue= value?.Trim(); }
        public string Notes { get => _notes; set => _notes= value?.Trim(); }
        public string ClassTypes { get; set; }
    }

    public struct Judge
    {
        private string _name;

        public int Id { get; set; }
        public int Event { get; set; }
        public string Name { get => _name; set => _name = value?.Trim(); }
    }

    public struct ClassAbbreviation
    {
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public Int16 AuditionMinutes { get; set; }
    }
}