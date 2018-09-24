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
        public ActionResult NextPhase(SelectedEvent theEvent)
        {
            Session["TheEvent"] = theEvent;

            if (theEvent.CanRate)
            {
                return RedirectToAction("Ratings");
            }
            if (theEvent.CanSchedule)
            {
                return RedirectToAction("Schedule");
            }
            if (theEvent.CanEnroll)
            {
                return RedirectToAction("Entries");
            }
            return RedirectToAction("Prepare");
        }

        public ActionResult Prepare()
        {
            return View();
        }

        public ActionResult Entries()
        {
            return View();
        }

        public ActionResult Schedule()
        {
            return View();
        }

        public ActionResult Ratings()
        {
            return View();
        }



        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult UpdateEvent(Event theEvent)
        {
            LoginPerson theUser = (LoginPerson)Session["TheUser"];
            theEvent.Location = theUser.LocationId;
            var id = SQLData.UpdateEvent(theEvent);
            if (theEvent.Id == 0)
                theEvent.Id = id;
            return Json(theEvent);
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

        //    [System.Web.Services.WebMethod]
        //    public static string DeletePerson(Contact person)
        //    {
        //        SQLData.DeleteContact(person.Id);
        //        JavaScriptSerializer json_serializer = new JavaScriptSerializer();
        //        return json_serializer.Serialize(person);
        //    }

        //    [System.Web.Services.WebMethod]
        //    public static string UpdatePerson(Contact person)
        //    {
        //        JavaScriptSerializer json_serializer = new JavaScriptSerializer();
        //        //Contact person = (Contact)json_serializer.DeserializeObject(personJSON);
        //        person.ParentLocation = LocationIdSecured;
        //        if (person.Id == 0)
        //        {
        //            person.UserName = CreateUser(person);
        //            person.Available = true;
        //        }

        //        int ret = SQLData.UpdateContact(person);
        //        if (person.Id == 0)
        //            person.Id = ret;
        //        return json_serializer.Serialize(person);
        //    }

        //    protected static string Left(string s, int i)
        //    {
        //        return s.Length <= i ? s : s.Substring(0, i);
        //    }

        //    protected static string CreateUser(Contact person)
        //    {
        //        string seed = Left(person.FirstName, 1) + Left(person.LastName, 4);
        //        string userName = SQLData.GenerateUserName(seed);

        //        var manager = HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
        //        var user = new ApplicationUser() { UserName = userName, Email = person.Email };
        //        string password = WebConfigurationManager.AppSettings["NewUserPassword"];
        //        IdentityResult result = manager.Create(user, password); //initial password, they can change it later
        //        if (result.Succeeded)
        //        {
        //            return userName;
        //        }
        //        else
        //        {
        //            throw new Exception(result.Errors.FirstOrDefault());
        //        }
        //    }

        //    public static int LocationIdSecured // call only from web methods
        //    {
        //        get
        //        {
        //            string userData;
        //            try
        //            {
        //                userData = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        //            }
        //            catch (Exception e)
        //            {
        //                throw new Exception("Session expired. Please log in again to continue.");
        //            }
        //            string role = userData.Substring(0, 1);
        //            if (!("ABCDE".Contains(role)))
        //                throw new Exception("Security Role Violation!");
        //            string id = userData.Substring(1);
        //            return int.Parse(id);
        //        }
        //    }
    }
}


