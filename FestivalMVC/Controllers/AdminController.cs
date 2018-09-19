using FestivalMVC.Models;
using FestivalMVC.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace FestivalMVC.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
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
        public ActionResult UpdateLocation(Location location)
        {
            SQLData.UpdateLocation(location);
            return Json(0);
        }

        [HttpPost]
        public ActionResult DeletePerson(Contact person)
        {
            SQLData.DeleteContact(person.Id);
            return Json(person);
        }

        [HttpPost]
        public ActionResult UpdatePerson(Contact person)
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

            return Json(person);
        }

    }
}