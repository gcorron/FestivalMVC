using FestivalMVC.Models;
using FestivalMVC.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Microsoft.Reporting.WebForms;
using System.Web.UI.WebControls;
using System.Text;

namespace FestivalMVC.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Index()
        {
            LoginPerson theUser;
            theUser = (LoginPerson)Session["TheUser"];
            var ViewData = new AdminPageData(theUser);
            return View("Index", ViewData);
        }

        public ActionResult Reports(int? Id)
        {
            IEnumerable<ReportModel> reports = SQLData.SelectReports(role: 'A');
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

            string parms = "";
            if (report.Params.IndexOf('L') >= 0)
                parms=$"@location={theUser.LocationId}";

            FestivalMVC.Reports.SQLReportData.PrepareReport(reportViewer, report.Name, parms);

            ViewBag.ReportViewer = reportViewer;
            return View(reports);
        }

        public ActionResult Locations ()
        {
            LoginPerson theUser;
            theUser = (LoginPerson)Session["TheUser"];

            return View(new LocationPageData(theUser.LocationId, false));
        }

        public ActionResult LocationsDown(int Id)
        {
            return View("Locations", new LocationPageData(Id, false));
        }

        public ActionResult LocationsUp(int Id)
        {
            return View("Locations", new LocationPageData(Id, true));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateLocationName(LocationC location)
        {
            return PartialView("_Location", SQLData.UpdateLocationName(location));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteLocation(LocationC location)
        {
            SQLData.DeleteLocation(location.Id);
            return Json(location.Id);
        }

        public ActionResult Rollup ()
        {
            return View(SQLData.SelectEventCountForRollup());
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Rollup(string dummy)
        {
            var theUser = (LoginPerson)Session["TheUser"];
            if (theUser.RoleType != LoginPerson.Admin)
                throw new Exception("Only the top level Admin can perform a rollup.");
            SQLData.RollupEvents();
            return RedirectToAction("Rollup");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateLocation(Location location)
        {
            SQLData.UpdateLocation(location);
            return Json(0);
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
        public ActionResult UpdatePerson(Contact person, int assignedToLocation)
        {

            person.ParentLocation = Admin.LocationIdSecured();
            if (person.Id == 0)
            {
                person.UserName = Admin.CreateUser(person);
                person.Available = true;
            }

            int ret = SQLData.UpdateContact(person);

            if (person.Id == 0)
                person.Id = ret;

            var personOut = new ContactForView(person)
            {
                AssignedToLocation = assignedToLocation
            };

            return PartialView("_Person", personOut);
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