using FestivalMVC.Models;
using FestivalMVC.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace FestivalMVC.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        [Authorize]
        public ActionResult Index()
        {
            LoginPerson theUser;
            try
            {
                theUser = (LoginPerson)Session["TheUser"];
                var ViewData = new AdminPageData(theUser);
                return View("Index", ViewData);
            }
            catch (Exception e)
            {
                return Content(e.Message); //TODO better reporting of error, session expired
            }

        }
        [HttpPost]
        [Authorize]
        public ActionResult UpdateLocation(Location location)
        {
            SQLData.UpdateLocation(location);
            return Json(0);
        }

        [HttpPost]
        [Authorize]
        public ActionResult DeletePerson(Contact person)
        {
            SQLData.DeleteContact(person.Id);
            return Content(person.Id.ToString());
        }

        [HttpPost]
        [Authorize]
        public ActionResult UpdatePerson(Contact person, int assignedToLocation)
        {

            try
            {
                person.ParentLocation = Admin.LocationIdSecured;
                if (person.Id == 0)
                {
                    person.UserName = Admin.CreateUser(person);
                    person.Available = true;
                }

                int ret = SQLData.UpdateContact(person);

                if (person.Id == 0)
                    person.Id = ret;

                var personOut = new ContactForView(person);
                personOut.AssignedToLocation = assignedToLocation;

                return PartialView("_Person", personOut);
            }
            catch (Exception ex)
            {
                HttpContext.Response.StatusCode = (Int32)HttpStatusCode.BadRequest;
                var message = ex.Message;
                return Json(message);
            }
        }

    }
}