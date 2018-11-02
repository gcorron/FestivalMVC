using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{

    public struct Student //db updates
    {
        public int Id { get; set; }
        public DateTime BirthDate { get; set; }
        public string Phone { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
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

    public struct Registered
    {
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public char Status { get; set; }
    }

    public struct RegisteredDB //for db updates 
    {
        public int Event { get; set; }
        public int Teacher { get; set; }
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
    }

    public struct StudentDB //db updates
    {
        public StudentDB(Student student, char instrument, int teacher) {
            Id = student.Id;
            Instrument = instrument;
            Teacher = teacher;
            BirthDate = student.BirthDate;
            Phone = student.Phone;
            FirstName = student.FirstName;
            LastName = student.LastName;
        }

        public int Id { get; set; }
        public char Instrument { get; set; }
        public int Teacher { get; set; }
        public DateTime BirthDate { get; set; }
        public string Phone { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public struct PayReg
    {
        public int Entries { get; set; }
        public decimal AmountDue { get; set; }
        public string Message { get; set; }
    }
}