using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using Dapper;
using Dapper.Contrib;
using FestivalMVC.Models;

namespace FestivalMVC
{
    public class SQLData
    {

        public static void UpdateContactForAccount(ContactForSelf model)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateContactForAccount", model, commandType: CommandType.StoredProcedure);
            }
        }

        public static ContactForSelf SelectContactForAccount(string userName)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<ContactForSelf>("SelectContactForAccount", new { userName }, commandType: CommandType.StoredProcedure);
            }

        }
        public static void UpdateLocation(Location location)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateLocation", location, commandType: CommandType.StoredProcedure);
            }

        }
        public static void DeleteContact(int id)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("DeleteContact", new { id }, commandType: CommandType.StoredProcedure);
            }

        }
        public static int UpdateContact(Contact contact)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<int>("UpdateContact", contact, commandType: CommandType.StoredProcedure);
            }

        }

        public static int UpdateEvent(Event ev)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<int>("UpdateEvent", ev, commandType: CommandType.StoredProcedure);
            }

        }

        public static void SelectDataForLocation(int location, out IEnumerable<ContactForView> contacts, out IEnumerable<Location> locations)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectDataForLocation", new { location }, commandType: CommandType.StoredProcedure))
                {
                    contacts = multi.Read<ContactForView>();
                    locations = multi.Read<Location>();
                }
            }

        }

        public static void SelectEventsForDistrict(int locationId, out IEnumerable<Event> events,
            out IEnumerable<Instrum> instruments, out Location location)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectEventsForDistrict", new { location=locationId }, commandType: CommandType.StoredProcedure))
                {
                    events = multi.Read<Event>();
                    instruments = multi.Read<Instrum>();
                    location = multi.ReadSingle<Location>();
                }
            }

        }

        public static LoginPerson GetLoginPerson(string userName)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<LoginPerson>("GetLoginPerson", new { userName }, commandType: CommandType.StoredProcedure);
            }
        }

        public static string GenerateUserName(string seed)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<string>("GenerateUserName", new { seed }, commandType: CommandType.StoredProcedure);
            }

        }

        public static IDbConnection GetDBConnection()
        {
            return new System.Data.SqlClient.SqlConnection(CnnVal("FestivalConnection"));
        }

        public static string CnnVal(string name)
        {
            try
            {
                return ConfigurationManager.ConnectionStrings[name].ConnectionString;
            }
            catch
            {
                throw new ArgumentException($"Database connection info for {name} not found!");
            }
        }

    }
}