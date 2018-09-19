using System;
using System.Linq;
using System.Web;

using FestivalMVC.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Web.Security;
using System.Web.Configuration;
using System.Collections.Generic;
using System.Diagnostics;

namespace FestivalMVC.ViewModels
{
    public class AdminPageData
    {

        private Dictionary<int, int> personIndex;

        public AdminPageData(LoginPerson theUser)
        {
            Contact[] people;
            Location[] locations;


            TheUser = theUser;
            SQLData.SelectDataForLocation(theUser.LocationId, out people, out locations);

            People = people;
            Locations = locations;
            personIndex = new Dictionary<int, int>();


            for (var i = 0; i < people.Length; i++) {
                people[i].AssignedToLocation = locations
                    .Where<Location>(p => p.ContactId == people[i].Id)
                    .Select(p => p.Id)
                    .SingleOrDefault<int>();
                personIndex.Add(people[i].Id, i);
            }
        }

        public LoginPerson TheUser { get; private set; }
        public Contact[] People { get; private set; }
        public Location[] Locations { get; private set; }

        public string GetPersonName(int? id)
        {
            if (id is null)
                return "";
            else
                return GetPerson((int)id).FullName;
        }

        public Contact GetPerson(int id)
        {
            return People[personIndex[id]];
        }

    }

    public class Admin
    {
        public static int LocationIdSecured // call only from web methods
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


        private static string Left(string s, int i)
        {
            return s.Length <= i ? s : s.Substring(0, i);
        }

        public static string CreateUser(Contact person)
        {
            string seed = Left(person.FirstName, 1) + Left(person.LastName, 4);
            string userName = SQLData.GenerateUserName(seed);

            var manager = HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() { UserName = userName, Email = person.Email };
            string password = WebConfigurationManager.AppSettings["NewUserPassword"];
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
    }
}