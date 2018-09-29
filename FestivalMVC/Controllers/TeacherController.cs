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
    [Authorize(Roles = "Teacher")]
    public class TeacherController : Controller
    {
        // GET: Teacher
        public ActionResult Index()
        {
            var eventsVM = new EventsViewModel(true);
            if (eventsVM.EventCount==1)
            {
                Session["SelectedEvent"] = (EventViewModel)eventsVM.Events.First();
                return RedirectToAction("Register");
            }

            return View();
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Index(int id)
        {

            ViewBag.Title = "Events";

            var dataEvent = SQLData.SelectEvent(id, out string instrumentName);

            var theEvent = new EventViewModel(dataEvent, instrumentName,false);

            Session["SelectedEvent"] = theEvent;

            return RedirectToAction("TeacherEvent");
        }

        public ActionResult Register()
        {
            ViewBag.Title = "Register";
            var theEvent = (EventViewModel)Session["SelectedEvent"];
            var theUser = (LoginPerson)Session["TheUser"];
            return View(new TeacherRegisterViewModel(theEvent.Event.Id,theUser.Id));
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