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
        readonly IEnumerable<ClassAbbreviation> _abbrs;

        //constructor
        public TeacherRegisterViewModel(int ev, int teacher)
        {
            SQLData.SelectDataForTeacherEvent(ev, teacher,
                out IEnumerable<Student> students,
                out IEnumerable<Enroll> enrolls,
                out Event eventModel,
                out string instrumentName,
                out _abbrs);

            EventVM = new EventViewModel(eventModel, instrumentName, false);

            AllStudents = from p in students
                          let ens = from e in enrolls
                                    where e.Student == p.Id
                                    select e
                          let canDelete = !(from e in ens
                                            where "R-".IndexOf(e.Status) != 0 //must have already paid
                                            select e).Any()
                          orderby p.LastName, p.FirstName
                          select new FullStudentViewModel
                          {
                              StudentVM =
                            new StudentViewModel { Student = p, CanDelete = canDelete, PossibleClassTypes = eventModel.ClassTypes },
                              Enrolls = ens.ToArray()
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
        public bool CanDelete { get; set; }
        public string PossibleClassTypes { get; set; }
    }

    public struct FullStudentViewModel
    {
        public StudentViewModel StudentVM { get; set; }
        public Enroll[] Enrolls { get; set; }

        // returns true if valid enroll record in out variable
        public bool GetEnroll(char classType, out Enroll enroll)
        {
            enroll = (from en in Enrolls
                      where en.ClassType == classType
                      select en).SingleOrDefault<Enroll>();

            return (enroll.ClassType == classType);
        }

        public Registered GetRegistered()
        {
            var registered = new Registered
            {
                Student = StudentVM.Student.Id,
                ClassType = this.StudentVM.PossibleClassTypes[0]
            };

            if (GetEnroll(registered.ClassType, out var enroll))
            {
                registered.ClassAbbr = enroll.ClassAbbr;
                registered.Status = enroll.Status;
            }
            if (this.StudentVM.PossibleClassTypes.Length > 1)
            {
                registered.ClassType2 = this.StudentVM.PossibleClassTypes[1];
                if (GetEnroll(registered.ClassType2, out enroll))
                {
                    registered.ClassAbbr2 = enroll.ClassAbbr;
                    registered.Status2 = enroll.Status;
                }
            }
            return registered;
        }
    }
}