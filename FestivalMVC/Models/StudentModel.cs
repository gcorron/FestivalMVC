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

    public struct Enroll //for retrieval from SQL, rendering page on server
    {
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public char Status { get; set; }

        public string LastClassAbbr { get; set; }
        public char LastAwardRating { get; set; }
        public int ConsecutiveSuperior { get; set; }
        public int AccumulatedPoints { get; set; }
    }

    public struct Registered //for client 
    {
        public int Event { get; set; }
        public int Teacher { get; set; }
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public char Status { get; set; }
        public char ClassType2 { get; set; }
        public string ClassAbbr2 { get; set; }
        public char Status2 { get; set; }
    }
    public struct Registration //for client to submit changes 
    {
        public int Event { get; set; }
        public int Teacher { get; set; }
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
    }

    public struct PayReg
    {
        public int Entries { get; set; }
        public decimal AmountDue { get; set; }
        public string Message { get; set; }
    }
}