using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using Dapper;
using FestivalMVC.Models;
using FestivalMVC.ViewModels;

namespace FestivalMVC
{
    public class SQLData
    {

        public static void CopyFromShadowTables()
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("CopyFromShadowTables", commandType: CommandType.StoredProcedure);
            }
        }

        public static IEnumerable<ReportModel> SelectReports(char role)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<ReportModel>("SelectReports", new { role }, commandType: CommandType.StoredProcedure);
            }
        }

        public static void RollupEvents()
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("RollupEvents", new { testing = false }, commandType: CommandType.StoredProcedure); //set testing to false to purge event entries
            }
        }

        public static int SelectEventCountForRollup()
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingleAsync<int>("SelectEventCountForRollup", commandType: CommandType.StoredProcedure).Result;
            }
        }

        #region ChairRating

        public static void UpdateEventCompleted(int ev)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateEventCompleted", new { ev }, commandType: CommandType.StoredProcedure);
            }
        }


        public static void UpdateAwardRating(EntryRatingUpdate rating)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateAwardRating", rating, commandType: CommandType.StoredProcedure);
            }
        }

        public static IEnumerable<EntryRating> SelectAuditionForEventRating(int ev)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<EntryRating>("SelectAuditionForEventRating", new { ev }, commandType: CommandType.StoredProcedure);
            }
        }

        #endregion


        #region ChairSchedule
        public static void InsertAudition(ProcessAuditionModel audition)
        {

            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("InsertAudition", new { audition.Id, audition.Schedule, audition.AuditionTime }, commandType: CommandType.StoredProcedure);
            }
        }

        public static void SelectDataForGeneratingSchedule(int ev, out List<ProcessScheduleModel> schedules,
            out List<ProcessAuditionModel> auditions)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var multi = connection.QueryMultiple("SelectDataForGeneratingSchedule", new { ev }, commandType: CommandType.StoredProcedure);
                schedules = multi.Read<ProcessScheduleModel>().AsList();
                auditions = multi.Read<ProcessAuditionModel>().AsList();
            }
        }

        public static void UpdateSchedule(ScheduleModel schedule, out IEnumerable<ScheduleModel> schedules, out IEnumerable<Judge> judges)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var multi = connection.QueryMultiple("UpdateSchedule", schedule, commandType: CommandType.StoredProcedure);
                schedules = multi.Read<ScheduleModel>();
                judges = multi.Read<Judge>();
            }
        }

        public static void DeleteSchedule(int id, out IEnumerable<ScheduleModel> schedules, out IEnumerable<Judge> judges)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var multi = connection.QueryMultiple("DeleteSchedule", new { id }, commandType: CommandType.StoredProcedure);
                schedules = multi.Read<ScheduleModel>();
                judges = multi.Read<Judge>();
            }
        }

        public static void SelectScheduleSetupData(int ev, out IEnumerable<UnscheduledSummaryModel> summary,
            out IEnumerable<ScheduledSummaryModel> summary2, out IEnumerable<ScheduleModel> schedules, out IEnumerable<Judge> judges)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                var multi = connection.QueryMultiple("SelectScheduleSetupData", new { ev }, commandType: CommandType.StoredProcedure);
                summary = multi.Read<UnscheduledSummaryModel>();
                summary2 = multi.Read<ScheduledSummaryModel>();
                schedules = multi.Read<ScheduleModel>();
                judges = multi.Read<Judge>();
            }
        }

        public static void UpdateEntryStatus(int id, char status, string notes)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateEntryStatus", new { id, status, notes }, commandType: CommandType.StoredProcedure);
            }

        }
        #endregion

        #region TeacherEntry

        public static void UpdateAllEntryStatus(int ev, int teacher, char status)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateAllEntryStatus", new { ev, teacher, status }, commandType: CommandType.StoredProcedure);
            }

        }

        public static void UpdateEntryDetails(EntryDetails details)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateEntryDetails", details, commandType: CommandType.StoredProcedure);
            }

        }


        public static IEnumerable<Piece> SelectPiecesForClassAbbr(string classAbbr)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<Piece>("SelectPiecesForClassAbbr", new { classAbbr }, commandType: CommandType.StoredProcedure);
            }
        }

        public static IEnumerable<ComposerName> SelectComposers()
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<ComposerName>("SelectComposers", commandType: CommandType.StoredProcedure);
            }
        }

        public static void SelectEntryDetails(int ev, int teacher,
        out IEnumerable<StudentName> studentNames,
        out IEnumerable<ClassTypeData> classTypes,
        out IEnumerable<EntryBase> entries,
        out IEnumerable<EntryDetails> entryDetails,
        out IEnumerable<EntryDetailsRequired> entryDetailsRequired,
        out IEnumerable<ContactShort> teachers)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectEntryDetails", new { ev, teacher }, commandType: CommandType.StoredProcedure))
                {
                    studentNames = multi.Read<StudentName>();
                    classTypes = multi.Read<ClassTypeData>();
                    entries = multi.Read<EntryBase>();
                    entryDetails = multi.Read<EntryDetails>();
                    entryDetailsRequired = multi.Read<EntryDetailsRequired>();
                    teachers = multi.Read<ContactShort>();
                }
            }

        }
        #endregion

        #region TeacherRegister
        public static PayReg UpdateEntryPaid(int ev, int teacher, decimal totalAmt)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<PayReg>("UpdateEntryPaid", new { ev, teacher, totalAmt }, commandType: CommandType.StoredProcedure);
            }
        }

        public static RegisteredDB UpdateEntry(RegisteredDB entry)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<RegisteredDB>("UpdateEntry", entry, commandType: CommandType.StoredProcedure);
            }
        }

        public static void RemoveStudentFromTeacher(int id, int teacher)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("RemoveStudentFromTeacher", new { id, teacher }, commandType: CommandType.StoredProcedure);
            }
        }

        public static int UpdateStudent(StudentDB student)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<int>("UpdateStudent", student, commandType: CommandType.StoredProcedure);
            }
        }

        public static void SelectDataForTeacherEvent(int ev, int teacher, out IEnumerable<Student> students
            , out IEnumerable<History> history, out IEnumerable<Registered> registered, out Event eventModel, out string instrumentName
            , out IEnumerable<ClassAbbreviation> classAbbrs)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectDataForTeacherEvent", new { ev, teacher }, commandType: CommandType.StoredProcedure))
                {
                    students = multi.Read<Student>();
                    history = multi.Read<History>();
                    registered = multi.Read<Registered>();
                    eventModel = multi.ReadSingle<Event>();
                    instrumentName = multi.ReadSingle<string>();
                    classAbbrs = multi.Read<ClassAbbreviation>();
                }
            }
        }

        public static void SelectEventsForTeacher(int parentLocation, DateTime currentTime, out IEnumerable<Event> events,
out IEnumerable<Instrum> instruments, out Location location)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectEventsForTeacher", new { parentLocation, currentTime }, commandType: CommandType.StoredProcedure))
                {
                    events = multi.Read<Event>();
                    instruments = multi.Read<Instrum>();
                    location = multi.ReadSingle<Location>();
                }
            }
        }

        #endregion

        #region ChairEvent

        public static IEnumerable<ContactShort> SelectTeachersForEventEntries(int ev)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<ContactShort>("SelectTeachersForEventEntries", new { ev }, commandType: CommandType.StoredProcedure);
            }
        }

        public static void SelectEventsForDistrict(int locationId, out IEnumerable<Event> events,
            out IEnumerable<Instrum> instruments, out Location location)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectEventsForDistrict", new { location = locationId }, commandType: CommandType.StoredProcedure))
                {
                    events = multi.Read<Event>();
                    instruments = multi.Read<Instrum>();
                    location = multi.ReadSingle<Location>();
                }
            }
        }

        public static IEnumerable<Judge> UpdateJudge(Judge judge)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.Query<Judge>("UpdateJudge", judge, commandType: CommandType.StoredProcedure);
            }
        }

        public static void UpdateTeacherEvent(int teacher, int ev, bool participate)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateTeacherEvent", new { teacher, ev, participate }, commandType: CommandType.StoredProcedure);
            }

        }

        public static void DeleteEvent(int id)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("DeleteEvent", new { id }, commandType: CommandType.StoredProcedure);
            }
        }

        public static void SelectTeachersForEvent(int id, out IEnumerable<ContactForView> teachers, out IEnumerable<Judge> judges)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectTeachersForEvent", new { id }, commandType: CommandType.StoredProcedure))
                {
                    teachers = multi.Read<ContactForView>();
                    judges = multi.Read<Judge>();
                }
            }
        }

        public static Event SelectEvent(int id, out string instrumentName)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectEvent", new { id }, commandType: CommandType.StoredProcedure))
                {
                    var ev = multi.ReadSingle<Event>();
                    instrumentName = multi.ReadSingle<string>();
                    return ev;
                }
            }
        }

        public static int UpdateEvent(Event ev)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<int>("UpdateEvent", ev, commandType: CommandType.StoredProcedure);
            }

        }

        #endregion

        #region ContactOrLocation

        public static void SelectLocations(int currentId, bool goingUp, out LocationB currentLocation, out IEnumerable<LocationB> locations)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                using (var multi = connection.QueryMultiple("SelectLocations", new { currentId, goingUp }, commandType: CommandType.StoredProcedure))
                {
                    currentLocation = multi.ReadSingle<LocationB>();
                    locations = multi.Read<LocationB>();
                }
            }
        }

        public static void DeleteLocation(int id)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("DeleteLocation", new { id }, commandType: CommandType.StoredProcedure);
            }
        }

        public static LocationB UpdateLocationName(LocationC location)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<LocationB>("UpdateLocationName", location, commandType: CommandType.StoredProcedure);
            }
        }

        public static void UpdateContactForAccount(ContactShort model)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                connection.Execute("UpdateContactForAccount", model, commandType: CommandType.StoredProcedure);
            }
        }

        public static ContactShort SelectContactForAccount(string userName)
        {
            using (IDbConnection connection = GetDBConnection())
            {
                return connection.QuerySingle<ContactShort>("SelectContactForAccount", new { userName }, commandType: CommandType.StoredProcedure);
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
        #endregion

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