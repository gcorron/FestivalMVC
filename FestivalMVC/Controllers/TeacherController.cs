﻿using System;
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
            if (Session["SelectedEvent"] is null && eventsVM.EventsOpenForRegistrationCount == 1)
            {
                Session["SelectedEvent"] = (EventViewModel)eventsVM.Events.First();
                return RedirectToAction("Register");
            }
            return View(eventsVM);
        }


        public ActionResult Register(int? id)
        {
            EventViewModel theEvent;

            if (id is null)
            {
                theEvent = (EventViewModel)Session["SelectedEvent"];
            }
            else
            {
                var dataEvent = SQLData.SelectEvent((int)id, out string instrumentName);
                theEvent = new EventViewModel(dataEvent, instrumentName, false);
                Session["SelectedEvent"] = theEvent;
            }

            ViewBag.Title = "Register";
            var theUser = (LoginPerson)Session["TheUser"];

            //verify that the teacher's location is the same as for the event
            //so one teacher cannot use this link for another teachers event
            if (theUser.ParentLocationId != theEvent.Event.Location)
            {
                throw new Exception("This event does not belong to your location.");
            }

            return View(new TeacherRegisterViewModel(theEvent.Event.Id,theUser.Id));
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateStudent(Student student )
        {
            var theEvent = (EventViewModel)Session["SelectedEvent"];
            if (!theEvent.ComputeIfOpen())
                throw new Exception("Event is not open for registration.");

            var theUser = (LoginPerson)Session["TheUser"];
            if (theUser.ParentLocationId != theEvent.Event.Location)
            {
                throw new Exception("This event does not belong to your location.");
            }


            student.Teacher = theUser.Id;
            student.Instrument = theEvent.Event.Instrument;
            int id = SQLData.UpdateStudent(student);
            if (student.Id == 0)
                student.Id = id;
            return View("_Student", new StudentViewModel { Student = student });
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