using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public class StudentModel
    {
        int Id { get; set; }
        int Teacher { get; set; }
        DateTime BirthDate { get; set; }
        string Phone { get; set; }
        string FirstName { get; set; }
        string LastName { get; set; }
    }
}