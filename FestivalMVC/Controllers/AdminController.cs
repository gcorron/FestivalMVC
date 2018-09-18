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
                if ("ABCDE".Any(p => p== theUser.RoleType))
                    return View("Index", theUser);
                else
                {
                    return View("NoRole");
                }
                
            }
            catch (Exception)
            {
                return RedirectToAction("/Account/Login");
            }

        }
        [HttpPost]
        public ActionResult UpdateLocation(Location location)
        {
            SQLData.UpdateLocation(location);
            return Json(0);
        }

        [HttpPost]
        public ActionResult GetPeople()
        {
            int locationId = Admin.LocationIdSecured;

            SQLData.SelectDataForLocation(locationId, out var Contacts, out var Locations);
            Contact empty = new Contact { Instrument = "-" };
            Contacts.Add(empty);

            object[] returnArray = new object[2];

            returnArray[0] = Contacts.ToArray();
            returnArray[1] = Locations;

            return Json(returnArray);
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