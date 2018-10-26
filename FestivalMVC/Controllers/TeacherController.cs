﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FestivalMVC.ViewModels;
using FestivalMVC.Models;
using System.Net;
using Microsoft.Reporting.WebForms;
using System.Web.UI.WebControls;
using System.Text;

namespace FestivalMVC.Controllers
{
    [Authorize(Roles = "Teacher")]
    public class TeacherController : Controller
    {
        // GET: Teacher
        public ActionResult Index()
        {
            var eventsVM = new EventsViewModel(true);
            if (Session["SelectedEvent"] is null && !((Session["SelectedEvent"] = eventsVM.GetOnlyEventOpen()) is null))
            {
                return RedirectToAction("Register");
            }
            return View(eventsVM);
        }

        public ActionResult Register(int? id)
        {
            EventViewModel theEvent;

            if (id is null)
            {
                theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            }
            else
            {
                var dataEvent = SQLData.SelectEvent((int)id, out string instrumentName);
                theEvent = new EventViewModel(dataEvent, instrumentName, false);
                Session["SelectedEvent"] = theEvent;
            }

            ViewBag.Title = "Register";
            var theUser = GetSessionItem<LoginPerson>("TheUser");

            //verify that the teacher's location is the same as for the event
            //so one teacher cannot use this link for another teachers event
            if (theUser.ParentLocationId != theEvent.Event.Location)
            {
                throw new Exception("This event does not belong to your location.");
            }

            return View(new TeacherRegisterViewModel(theEvent.Event.Id, theUser.Id));
        }

        public ActionResult Entries()
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            var theUser = GetSessionItem<LoginPerson>("TheUser");

            var EntryViewModel = new EntryViewModel(theEvent, theUser.Id);

            return View(EntryViewModel);
        }

        public ActionResult Reports(int? Id)
        {
            IEnumerable<ReportModel> reports = SQLData.SelectReports(role: 'T');
            if ((Id ?? 0) == 0)
            {
                return View(reports);
            }

            ReportModel report = reports.Where(p => p.Id == Id).Single();

            var reportViewer = new ReportViewer()
            {
                ProcessingMode = ProcessingMode.Local,
                SizeToReportContent = true,
                Width = Unit.Percentage(100),
                Height = Unit.Percentage(100),
                AsyncRendering = false
            };

            LoginPerson theUser;
            theUser = (LoginPerson)Session["TheUser"];
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            StringBuilder parms = new StringBuilder(100);

            if (report.Params.IndexOf('T') >= 0)
                parms.Append($",@teacher={theUser.Id}");

            if (report.Params.IndexOf('E') >= 0)
                parms.Append($",@ev={theEvent.Event.Id}");

            if (parms.Length > 0)
                parms.Remove(0, 1); //extra comma


            SQLData.PrepareReport(reportViewer, report.Name, parms.ToString());

            ViewBag.ReportViewer = reportViewer;
            return View(reports);
        }

        public ActionResult Composers()
        {
            return Json(SQLData.SelectComposers(),JsonRequestBehavior.AllowGet);
        }

        public ActionResult Pieces(string classAbbr)
        {
            var pieces = SQLData.SelectPiecesForClassAbbr(classAbbr);
            return Json(new {classAbbr, pieces}, JsonRequestBehavior.AllowGet);
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEntryDetails(EntryDetails details)
        {
            var theUser = GetSessionItem<LoginPerson>("TheUser");
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            if (theEvent.ComputeIfOpen() == false)
                throw new Exception("This event is closed - no changes to registrations allowed.");

            SQLData.UpdateEntryDetails(details);
            return Json(details);
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult SubmitEntries()
        {
            var theUser = GetSessionItem<LoginPerson>("TheUser");
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            if (theEvent.ComputeIfOpen() == false)
                throw new Exception("This event is closed - no changes to registrations allowed.");

            SQLData.UpdateAllEntryStatus(theEvent.Event.Id,theUser.Id,EntryStatusTypes.Submitted);
            return Json(0);

        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult PayRegistration(decimal amountDue)
        {
            var theUser = GetSessionItem<LoginPerson>("TheUser");
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            if (theEvent.ComputeIfOpen() == false)
                throw new Exception("This event is closed - no payment allowed.");

            var payreg = SQLData.UpdateEntryPaid(theEvent.Event.Id, theUser.Id, amountDue);
            return Json(payreg);
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEntry(RegisteredDB entry)
        {
            var theUser = GetSessionItem<LoginPerson>("TheUser");
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            if (theEvent.ComputeIfOpen() == false)
                throw new Exception("This event is closed - no changes to registrations allowed.");

            entry.Teacher = theUser.Id;
            entry.Event = theEvent.Event.Id;
            RegisteredDB result = SQLData.UpdateEntry(entry);
            return Json(result);
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult RemoveStudent(Student student)
        {
            var theUser = GetSessionItem<LoginPerson>("TheUser");
            SQLData.RemoveStudentFromTeacher(student.Id, theUser.Id);
            return Json(0);
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateStudent(Student student)
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            if (!theEvent.ComputeIfOpen())
                throw new Exception("Event is not open for registration.");

            var theUser = GetSessionItem<LoginPerson>("TheUser");
            if (theUser.ParentLocationId != theEvent.Event.Location)
            {
                throw new Exception("This event does not belong to your location.");
            }

            var studentDb = new StudentDB(student, theEvent.Event.Instrument, theUser.Id);
            int id = SQLData.UpdateStudent(studentDb);
            if (student.Id == 0)
            {
                student.Id = id;
                return PartialView("_FullStudent", new FullStudentViewModel
                {
                    StudentVM = new StudentViewModel { Student = student },
                    History = new History[0],
                    Registered = new Registered[0],
                    ClassTypes = theEvent.Event.ClassTypes
                });
            }
            return PartialView("_Student", new StudentViewModel { Student = student });
        }

        //catch all unhandled exceptions that are thrown within scope of this controller
        protected override void OnException(ExceptionContext filterContext)
        {

            if (filterContext.ExceptionHandled)
                return;

            if (filterContext.HttpContext.Request.IsAjaxRequest())
            {
                if (filterContext.Exception == null)
                {
                    base.OnException(filterContext);
                }
                else
                {
                    filterContext.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    filterContext.Result = new JsonResult
                    {
                        JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                        Data = new
                        {
                            filterContext.Exception.Message
                        }
                    };
                    filterContext.ExceptionHandled = true;
                }
            }
            else
            {
                filterContext.ExceptionHandled = true;

                // Redirect on error:
                //filterContext.Result = RedirectToAction("Index", "Error");

                // OR set the result without redirection:
                filterContext.Result = new ViewResult
                {
                    ViewName = "~/Views/Shared/Error.cshtml",
                    ViewData = new ViewDataDictionary(filterContext.Controller.ViewData) //this view will use the exception as its model
                    {
                        Model = filterContext.Exception
                    }
                };
            }
        }
        private T GetSessionItem<T>(string name) ///TODO implement in other controllers
        {
            try
            {
                return (T)Session[name];
            }
            catch (Exception)
            {

                throw new Exception("Session timed out. Please log in again to continue.");
            }
        }

    }
}