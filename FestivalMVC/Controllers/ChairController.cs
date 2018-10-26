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
    [Authorize(Roles = "Chair")]
    public class ChairController : Controller
    {
        // GET: Chair
        public ActionResult Index()
        {
            return View(new EventsViewModel(false));
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Index(int id)
        {

            ViewBag.Title = "Events";

            RefreshSelectedEventSessionData(id);
            return Json(new { redirect = "/Chair/Prepare" });

        }

        public ActionResult Prepare()
        {
            ViewBag.Title = "Prepare";
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            return View(new PreparePageViewModel(theEvent.Event.Id));
        }

        public ActionResult Entries()
        {
            ViewBag.Title = "Entries";
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            return View(new EntryViewModel(theEvent,0));
        }

        public ActionResult Schedule()
        {
            ViewBag.Title = "Schedule";
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            return View(new SchedulePageViewModel(theEvent));
        }

        public ActionResult Ratings()
        {
            ViewBag.Title = "Ratings";
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            return View(new RatingsPageViewModel(theEvent));
        }

        public ActionResult Reports(int? Id)
        {
            IEnumerable<ReportModel> reports = SQLData.SelectReports(role: 'C');
            if ((Id ?? 0) == 0)
            {
                return View(reports);
            }

            ReportModel report = reports.Where(p => p.Id == Id).Single();

            var reportViewer = new ReportViewer()
            {
                ProcessingMode = ProcessingMode.Remote,
                SizeToReportContent = true,
                Width = Unit.Percentage(100),
                Height = Unit.Percentage(100)
            };

            LoginPerson theUser;
            theUser = (LoginPerson)Session["TheUser"];
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            StringBuilder parms = new StringBuilder(100);

            if (report.Params.IndexOf('L') >= 0)
                parms.Append($",@location={theUser.LocationId}");

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

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEventCompleted()
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            SQLData.UpdateEventCompleted(theEvent.Event.Id);
            return Json(Url.Action("Index"));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateAwardRating(EntryRatingUpdate rating)
        {
            SQLData.UpdateAwardRating(rating);
            return Json(rating);
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult GenerateNewSchedule()
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            var generator = new AuditionGenerator();
            bool result=generator.BeginProcess(theEvent.Event.Id);
            return Json(result);
            
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateSchedule(ScheduleModel schedule)
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            return PartialView("_Schedule",new SchedulePageViewModel(theEvent,schedule));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult DeleteSchedule(int id)
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");
            return PartialView("_Schedule", new SchedulePageViewModel(theEvent, id));
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Entries(int SelectedTeacher)
        {
            ViewBag.Title = "Entries";
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            return View(new EntryViewModel(theEvent, SelectedTeacher));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult ApproveEntries(int teacher)
        {
            var theEvent = GetSessionItem<EventViewModel>("SelectedEvent");

            SQLData.UpdateAllEntryStatus(theEvent.Event.Id, teacher, EntryStatusTypes.Approved);
            return Json(0);

        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEvent(Event theEvent)
        {

            LoginPerson theUser = (LoginPerson)Session["TheUser"];


            if (theEvent.Location != theUser.LocationId)
            {
                if (theEvent.Location == 0)
                    theEvent.Location = theUser.LocationId;
                else
                    throw new ArgumentException("Invalid location data.");
            }

            var id = SQLData.UpdateEvent(theEvent);

            if (theEvent.Id == 0) //Added events are instantly "selected"
                return Index(id);
            else
            {
                RefreshSelectedEventSessionData(theEvent.Id);
                return Json(new { redirect = "/Chair/Prepare" }); //edited events came from Prepare, so refresh the page
            }
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult DeleteEvent(int id)
        {
            SQLData.DeleteEvent(id);
            Session["SelectedEvent"] = null;
            return Json(new { redirect = "/Chair/Index" }); // back to events page
        }


        private void RefreshSelectedEventSessionData(int id)
        {
            var dataEvent = SQLData.SelectEvent(id, out string instrumentName);

            var theEvent = new EventViewModel(dataEvent, instrumentName,true);

            Session["SelectedEvent"] = theEvent;

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateTeacherEventAssignment(int id, bool participate)
        {
            var theEvent = (EventViewModel)Session["SelectedEvent"];
            var eventId = theEvent.Event.Id;
            SQLData.UpdateTeacherEvent(id, eventId, participate);
            if (!participate)
                eventId = 0;

            return Json(new { id, eventId });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdatePerson(Contact person, int assignedToLocation)
        {

            person.ParentLocation = Admin.LocationIdSecured();

            var theEvent = (EventViewModel)Session["SelectedEvent"];
            person.Instrument = theEvent.Event.Instrument;
            person.Available = true; //always true for events

            if (person.Id == 0)
            {
                person.UserName = Admin.CreateUser(person);
                assignedToLocation = theEvent.Event.Id;
            }


            int ret = SQLData.UpdateContact(person);

            if (person.Id == 0)
            {
                person.Id = ret;
                SQLData.UpdateTeacherEvent(person.Id, assignedToLocation, true);
            }

            var personOut = new ContactForView(person)
            {
                AssignedToLocation = assignedToLocation
            };

            return PartialView("_Person", personOut);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeletePerson(Contact person)
        {
            SQLData.DeleteContact(person.Id);
            return Json(0);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateJudge(Judge judge)
        {
            EventViewModel theEvent = (EventViewModel)Session["SelectedEvent"];
            judge.Event = theEvent.Event.Id;
            return PartialView("_Judges", SQLData.UpdateJudge(judge));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateEntryStatus(Approve approve)
        {
            SQLData.UpdateEntryStatus(approve.Id, approve.Status, approve.Notes);
            return Json(approve);
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


