using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC.Models;
using FestivalMVC.ViewModels;

namespace FestivalMVC.ViewModels
{
    public class TeacherRegisterViewModel
    {
        private readonly IEnumerable<Student> _students;
        private readonly IEnumerable<Enroll> _enrolls;
        private readonly IEnumerable<History> _history;

        //constructor
        public TeacherRegisterViewModel(int ev, int teacher)
        {
            SQLData.SelectDataForTeacherEvent(ev, teacher, out _students, out _history, out _enrolls,
                out Event eventModel, out string instrumentName);
            EventVM = new EventViewModel(eventModel, instrumentName,false);
        }

        public EventViewModel EventVM { get; }

        public IEnumerable<StudentViewModel> Students {
            get
            {
                return from p in _students
                       orderby p.LastName, p.FirstName
                    select new StudentViewModel { Student = p };
            }
        }

        public IEnumerable<Enroll>GetStudentEnrolls(int Id)
        {
            return from p in _enrolls
                   where p.Student == Id
                   select p;
        }
        public History GetStudentHistory(int Id)
        {
            return (from p in _history
                   where p.Student == Id
                   select p).Single<History>();
        }
    }

    public class StudentViewModel
    {
        public Student Student { get; set; }
        public string FullName { get => $"{Student.FirstName} {Student.LastName}"; }
        public string Age { get => (DateTime.Now.Subtract(Student.BirthDate).Days / 365.25d).ToString(); }
    }
}