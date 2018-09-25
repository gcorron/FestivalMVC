using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FestivalMVC.ViewModels;
using FestivalMVC.Models;
using System.Net;

namespace FestivalMVC.Controllers
{
    [Authorize(Roles = "Chair")]
    public class ChairController : Controller
    {
        // GET: Chair
        public ActionResult Index()
        {
            return View(new EventsViewModel());
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Index(int id)
        {

            ViewBag.Title = "Events";

            string nextPage = RefreshSelectedEventSessionData(id);

            return Json(new { redirect = "/Chair/" + nextPage });

        }

        public ActionResult Prepare()
        {
            ViewBag.Title = "Prepare";
            var theEvent = (EventViewModel)Session["SelectedEvent"];
            return View(new PreparePageViewModel(theEvent.Event.Id));
        }

        public ActionResult Entries()
        {
            ViewBag.Title = "Entries";

            return View();
        }

        public ActionResult Schedule()
        {
            ViewBag.Title = "Schedule";

            return View();
        }

        public ActionResult Ratings()
        {
            ViewBag.Title = "Ratings";
            return View();
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


            private string RefreshSelectedEventSessionData(int id)
        {
            var dataEvent = SQLData.SelectEvent(id, out string instrumentName);

            var theEvent = new EventViewModel(dataEvent, instrumentName);

            Session["SelectedEvent"] = theEvent;

            return theEvent.NextPage;
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


    }
}


