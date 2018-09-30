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
        private Dictionary<string, Enroll> enrollment = new Dictionary<string, Enroll>();

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
                       orderby p.LastName, p.FirstName
                       select new StudentViewModel { Student = p, Enrolled=enrolls.Any(q => q.Student == p.Id) };

            foreach (var e in enrolls)
            {
                enrollment.Add(e.ClassType + e.Student.ToString(), e);
            }



        }
        public EventViewModel EventVM { get; }
        public IEnumerable<StudentViewModel> AllStudents { get; set; }
        public IEnumerable<EnrollViewModel> Enrolls { get; set; }

        public IEnumerable<EnrollViewModel> GetEnrolls(char classType)
        {
            return from p in AllStudents
                   let key = classType + p.Student.Id.ToString()
                   let enroll = getEnroll(key)
                   where !(enroll is null)
                   select new EnrollViewModel { Id = p.Student.Id, FullName = p.FullName, Enroll = (Enroll)enroll };


            Enroll ? getEnroll(string key)
            {
                if (enrollment.TryGetValue(key, out var enroll))
                    return enroll;
                else
                    return null;
            }
        }   


    }


    public struct EnrollViewModel
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public Enroll Enroll { get; set; }
    }

    public struct StudentViewModel
    {
        public Student Student { get; set; }
        public string FullName { get => $"{Student.FirstName} {Student.LastName}"; }
        public string Age { get => (DateTime.Now.Subtract(Student.BirthDate).Days / 365.25d).ToString(); }
        public bool Enrolled { get; set; }

    }

 }