using System;
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
using System.Threading.Tasks;

namespace FestivalMVC.Controllers
{
    [Authorize(Roles = "Chair")]
    public class ChairController : Controller
    {

        private static IEnumerable<Instrum> _instruments = SQLData.SelectInstruments();

        // GET: Chair
        public ActionResult Index()
        {
            return View(new EventsViewModel(false));
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Index(int id)
        {

            var dataEvent = SQLData.SelectEvent(id, out string instrumentName);
            Session["SelectedEvent"] = dataEvent;
            Session["SelectedEventDesc"] = new EventViewModel(dataEvent, instrumentName,false).EventDescription;

            ViewBag.Title = "Events";

            return Json(new { redirect = "/Chair/Prepare" });
        }

        public ActionResult Prepare()
        {
            ViewBag.Title = "Prepare";
            return View(new PreparePageViewModel(CreateEventViewModel()));
        }

        public ActionResult Entries()
        {
            ViewBag.Title = "Entries";
            return View(new EntryViewModel(CreateEventViewModel(), 0));
        }

        public ActionResult Schedule()
        {
            ViewBag.Title = "Schedule";
            return View(new SchedulePageViewModel(CreateEventViewModel()));
        }

        public ActionResult Ratings()
        {
            ViewBag.Title = "Ratings";
            return View(new RatingsPageViewModel(CreateEventViewModel()));
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
            var theEvent = GetSessionItem<Event>("SelectedEvent");
            SQLData.UpdateEventCompleted(theEvent.Id);
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
        public async Task<ActionResult> GenerateNewSchedule(bool generate)
        {
            var theEvent = CreateEventViewModel();
            if (!theEvent.ComputeIfScheduling())
                throw new Exception("Scheduling is not allowed for this event!");

            var generator = new AuditionGenerator();
            Task<bool> theTask = generator.Process(theEvent.Event.Id, generate);
            bool result = await theTask;
            return Json(result);
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateSchedule(ScheduleModel schedule)
        {
            return PartialView("_Schedule", new SchedulePageViewModel(CreateEventViewModel(), schedule));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult DeleteSchedule(int id)
        {
            return PartialView("_Schedule", new SchedulePageViewModel(CreateEventViewModel(), id));
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Entries(int SelectedTeacher)
        {
            ViewBag.Title = "Entries";
            return View(new EntryViewModel(CreateEventViewModel(), SelectedTeacher));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult ApproveEntries(int teacher)
        {
            var theEvent = GetSessionItem<Event>("SelectedEvent");

            SQLData.UpdateAllEntryStatus(theEvent.Id, teacher, EntryStatusTypes.Approved);
            return Json(0);

        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEvent(Event theEvent)
        {

            LoginPerson theUser = GetSessionItem<LoginPerson>("TheUser");
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
                var dataEvent = SQLData.SelectEvent(theEvent.Id, out string instrumentName);
                Session["SelectedEvent"] = dataEvent;
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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateTeacherEventAssignment(int id, bool participate)
        {
            var theEvent = GetSessionItem<Event>("SelectedEvent");
            SQLData.UpdateTeacherEvent(id, theEvent.Id, participate);
            if (!participate)
                theEvent.Id = 0;

            return Json(new { id, theEvent.Id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdatePerson(Contact person, int assignedToLocation)
        {

            person.ParentLocation = Admin.LocationIdSecured();

            var theEvent = GetSessionItem<Event>("SelectedEvent");
            person.Instrument = theEvent.Instrument;
            person.Available = true; //always true for events

            if (person.Id == 0)
            {
                person.UserName = Admin.CreateUser(person);
                assignedToLocation = theEvent.Id;
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
            var theEvent = GetSessionItem<Event>("SelectedEvent");
            judge.Event = theEvent.Id;
            return PartialView("_Judges", SQLData.UpdateJudge(judge));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateEntryStatus(Approve approve)
        {
            SQLData.UpdateEntryStatus(approve.Id, approve.Status, approve.Notes);
            return Json(approve);
        }

        private EventViewModel CreateEventViewModel()
        {
            Event ev = (Event)Session["SelectedEvent"];
            string instrumentName = (from i in _instruments
                                    where i.Id == ev.Instrument
                                    select i.Instrument).Single();

            return new EventViewModel(ev, instrumentName,true);
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


