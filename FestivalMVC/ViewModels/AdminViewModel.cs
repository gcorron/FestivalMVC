using System;
using System.Linq;
using System.Web;
using FestivalMVC.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Web.Security;
using System.Web.Configuration;
using System.Collections.Generic;
using System.Data;

namespace FestivalMVC.ViewModels
{
    public class AdminPageData
    {

        public AdminPageData(LoginPerson theUser)
        {
            TheUser = theUser;
            SQLData.SelectDataForLocation(theUser.LocationId, out IEnumerable<ContactForView> people, out IEnumerable<Location> locations);

            Locations = locations;
            People = people;
        }

        public LoginPerson TheUser { get; private set; }

        public IEnumerable<ContactForView> People { get; private set; }

        public IEnumerable<Location> Locations { get; private set; }

        public string GetPersonName(int? id)
        {
            if (id is null)
                return "";
            var person = GetPerson((int)id);
            return person.FirstName + " " + person.LastName;
        }

        public ContactForView GetPerson(int id)
        {
            return (from p in People
                    where p.Id == id
                    select p).Single();
        }
    }

    public static class Admin
    {
        public static string RealUserName()
        {
            try
            {
                LoginPerson theUser = (LoginPerson)HttpContext.Current.Session["TheUser"];
                return theUser.FullName;
            }
            catch
            {
                return " --- ";
            }
        }

        public static int LocationIdSecured
        {
            get
            {
                string userData;
                try
                {
                    userData = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
                }
                catch (Exception e)
                {
                    throw new Exception("Session expired. Please log in again to continue.");
                }
                string role = userData.Substring(0, 1);
                if (!("ABCDE".Contains(role)))
                    throw new Exception("Security Role Violation!");
                string id = userData.Substring(1);
                return int.Parse(id);
            }
        }

        public static string CreateUser(Contact person)
        {
            string seed = Left(person.FirstName, 1) + Left(person.LastName, 4);
            string userName = SQLData.GenerateUserName(seed);

            var manager = HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() { UserName = userName, Email = person.Email };
            string password = WebConfigurationManager.AppSettings["NewUserPassword"];
            if (string.IsNullOrEmpty(password))
            {
                throw new Exception("Server is not configured for new user password!");
            }
            IdentityResult result = manager.Create(user, password); //initial password, they can change it later
            if (result.Succeeded)
            {
                return userName;
            }
            else
            {
                throw new Exception(result.Errors.FirstOrDefault());
            }
        }

        private static string Left(string s, int i)
        {
            return s.Length <= i ? s : s.Substring(0, i);
        }

    }
}