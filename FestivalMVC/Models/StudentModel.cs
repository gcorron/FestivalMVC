using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public struct Student
    {
        public int Id { get; set; }
        public char Instrument { get; set; }
        public int Teacher { get; set; }
        public DateTime BirthDate { get; set; }
        public string Phone { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public struct Enroll
    {
        public int Student { get; set; }
        public int Teacher { get; set; }
        public int Event { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
    }

    public struct History
    {
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public char AwardRating { get; set; }
        public int ConsecutiveSuperior { get; set; }
        public int AccumulatedPoints { get; set; }
    }

}