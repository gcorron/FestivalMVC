using System;
using System.Linq;
using System.Web;

using FestivalMVC.Models;
using Microsoft.AspNet.Identity;

using Microsoft.AspNet.Identity.Owin;
using System.Web.Security;
using System.Web.Configuration;

namespace FestivalMVC.ViewModels
{
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