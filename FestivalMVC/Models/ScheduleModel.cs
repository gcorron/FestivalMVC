using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public struct UnscheduledSummaryModel
    {
        public string ClassTypeDesc { get; set; }
        public string AuditionMinutes { get; set; }
        public Int16 TotalMinutes { get; set; }
        public Int16 Number { get; set; }
    }
    public struct ScheduleModel
    {
        public int Id { get; set; }
        public int Judge { get; set; }
        public DateTime StartTime { get; set; }
        public Int16 Minutes { get; set; }
    }

}