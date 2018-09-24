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
        public string Venue { get; set; }
        public string Notes { get; set; }
    }

    public struct EventPostId
    {
        public int Id { get; set; }
    }
   
    public struct TeacherEvent
    {
        public int Event { get; set; }
        public int Teacher { get; set; }
    }

}