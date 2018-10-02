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

        //constructor
        public TeacherRegisterViewModel(int ev, int teacher)
        {
            SQLData.SelectDataForTeacherEvent(ev, teacher,
                out IEnumerable<Student> students,
                out IEnumerable<Enroll> enrolls,
                out Event eventModel,
                out string instrumentName);

            EventVM = new EventViewModel(eventModel, instrumentName, false);

            AllStudents = from p in students
                          let ens = from e in enrolls
                                    where e.Student == p.Id
                                    select e
                          orderby p.LastName, p.FirstName
                          select new FullStudentViewModel { StudentVM = new StudentViewModel { Student = p }, Enrolls = ens.ToArray() };
        }

        public EventViewModel EventVM { get; }
        public IEnumerable<FullStudentViewModel> AllStudents { get; set; }

    }

    public struct StudentViewModel
    {
        public Student Student { get; set; }
        public string FullName { get => $"{Student.FirstName} {Student.LastName}"; }
        public string Age { get => (Math.Truncate(DateTime.Now.Subtract(Student.BirthDate).Days / 365.25d)).ToString(); }
    }

    public struct FullStudentViewModel
    {
        public StudentViewModel StudentVM { get; set; }
        public Enroll[] Enrolls { get; set; }

        public bool GetEnroll(char classType, out Enroll enroll)
        {
            enroll = (from en in Enrolls
                    where en.ClassType == classType
                    select en).SingleOrDefault<Enroll>();
            return enroll.ClassType == classType;
        }

        public bool IsRegistered()
        {
            return (from en in Enrolls
                    where en.ClassAbbr.Length > 0
                    select en).Any();
        }

    }
}