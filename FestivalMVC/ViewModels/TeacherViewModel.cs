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
        private readonly IEnumerable<ClassAbbreviation> _abbrs;

        //constructor
        public TeacherRegisterViewModel(int ev, int teacher)
        {
            SQLData.SelectDataForTeacherEvent(ev, teacher,
                out IEnumerable<Student> students,
                out IEnumerable<History> history,
                out IEnumerable<Registered> registered,
                out Event eventModel,
                out string instrumentName,
                out _abbrs);

            EventVM = new EventViewModel(eventModel, instrumentName, false);
            var eventOpen = EventVM.ComputeIfOpen();
            var possibleEnrolls = EventVM.Event.ClassTypes.Length;

            AllStudents = from p in students
                          orderby p.LastName, p.FirstName
                          select new FullStudentViewModel
                          {
                              StudentVM = new StudentViewModel { Student = p },
                              History = from h in history
                                        where h.Student==p.Id
                                        select h,
                              Registered = from r in registered
                                           where r.Student==p.Id
                                           select r,
                              ClassTypes = EventVM.Event.ClassTypes
                          };

        }


        public EventViewModel EventVM { get; }
        public IEnumerable<FullStudentViewModel> AllStudents { get; set; }
        public IEnumerable<ClassAbbreviation> ClassAbbrsForClassType(char classType)
        {
            return from p in _abbrs
                   where p.ClassType == classType
                   select p;
        }
    }

    public struct StudentViewModel
    {
        public Student Student { get; set; }
        public string FullName { get => $"{Student.FirstName} {Student.LastName}"; }
        public string Age { get => (Math.Truncate(DateTime.Now.Subtract(Student.BirthDate).Days / 365.25d)).ToString(); }
    }

    public struct EnrollVM
    {
        public History History { get; set; }
        public Registered Registered { get; set; }
    }

    public class FullStudentViewModel
    {
        public StudentViewModel StudentVM { get; set; }
        public string ClassTypes { get; set; }

        public IEnumerable<History> History { get; set; }
        public IEnumerable<Registered> Registered { get; set; }


        public EnrollVM GetEnroll(char classType)
        {

            History history = (from h in History
                   where h.ClassType == classType
                   select h).SingleOrDefault<History>();

            Registered registered = (from r in Registered
                   where r.ClassType == classType
                   select r).SingleOrDefault<Registered>();

            if (registered.Student == 0) //view uses empty registration
            {
                registered.Student = StudentVM.Student.Id;
                registered.ClassType = classType;
                registered.Status = EntryStatusTypes.None;
            }

            return new EnrollVM
            {
                History = history,
                Registered = registered
            };

        }

        public Registered[] AllRegistered
        {
            get
            {
                return (from r in Registered
                        select r).ToArray();
            }
        }
    }
}