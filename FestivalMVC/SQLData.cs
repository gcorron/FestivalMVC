using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using Dapper;
using FestivalMVC.Models;

namespace FestivalMVC
{
    public class SQLData
    {

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
                int ret = connection.Query<int>("UpdateContact", contact, commandType: CommandType.StoredProcedure).Single<int>();
                return ret;
            }

        }

        public static void SelectDataForLocation(int location, out Contact[] contacts, out Location[] locations)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectDataForLocation", new { location }, commandType: CommandType.StoredProcedure))
                {
                    contacts = multi.Read<Contact>().ToArray<Contact>();
                    locations = multi.Read<Location>().ToArray<Location>();
                }
            }

        }

        public static void SelectDataForChair(int location, out List<Contact> contacts, out List<Event> events, out List<TeacherEvent> teacherEvents)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectDataForChairLocation", new { location }, commandType: CommandType.StoredProcedure))
                {
                    contacts = multi.Read<Contact>().ToList<Contact>();
                    events = multi.Read<Event>().ToList<Event>();
                    teacherEvents = multi.Read<TeacherEvent>().ToList<TeacherEvent>();
                }
            }

        }

        public static LoginPerson GetLoginPerson(string userName)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var userList = connection.Query<LoginPerson>("GetLoginPerson", new { userName }, commandType: CommandType.StoredProcedure).ToList<LoginPerson>();
                if (userList.Count != 1)
                    throw new RowNotInTableException();
                return userList[0];
            }
        }

        public static string GenerateUserName(string seed)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var resultList = connection.Query<string>("GenerateUserName", new { seed }, commandType: CommandType.StoredProcedure).ToList<string>();
                if (resultList.Count != 1)
                    throw new RowNotInTableException();
                return resultList[0];
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