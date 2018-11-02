using System;

namespace FestivalMVC.Models
{

    public struct Contact
    {
        private string firstName, lastName, email, phone;

        public int Id { get; set; }
        public string FirstName { get => firstName; set => firstName = value?.Trim(); }
        public string LastName { get => lastName; set => lastName = value?.Trim(); }
        public string Email { get => email; set => email = value?.Trim(); }
        public string Phone { get => phone; set => phone = value?.Trim(); }
        public string UserName { get; set; }
        public char Instrument { get; set; }
        public Boolean Available { get; set; }
        public int ParentLocation { get; set; }
    }

    public struct ContactForView
    {

        public ContactForView(Contact contact)
        {
            Id = contact.Id;
            Email = contact.Email;
            Phone = contact.Phone;
            LastName = contact.LastName;
            FirstName = contact.FirstName;
            Instrument = contact.Instrument;
            Available = contact.Available;
            ParentLocation = contact.ParentLocation;
            AssignedToLocation = 0;
            UserName = contact.UserName;
        }

        public int Id { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public char Instrument { get; set; }
        public Boolean Available { get; set; }
        public int ParentLocation { get; set; }
        public int AssignedToLocation { get; set; }
        public string UserName { get; set; }
        public string FullName
        {
            get
            {
                return FirstName + " " + LastName;
            }
        }
    }

    public struct ContactShort
    {
        private string firstName, lastName, email, phone;

        public int Id { get; set; }
        public string FirstName { get => firstName; set => firstName = value?.Trim(); }
        public string LastName { get => lastName; set => lastName = value?.Trim(); }
        public string Email { get => email; set => email = value?.Trim(); }
        public string Phone { get => phone; set => phone = value?.Trim(); }
    }

    public struct Location
    {
        public string LocationName { get; set; }
        public int Id { get; set; }
        public int? ContactId { get; set; }
    }

    public struct LocationB
    {
        public string LocationName { get; set; }
        public int Id { get; set; }
        public string ContactName { get; }
        public char LocationType { get; }
    }

    public struct LocationC
    {
        public string LocationName { get; set; }
        public int Id { get; set; }
        public int ParentLocation { get; set; }
    }


    public static class PersonHelper
    {
        private const string _LEVELS = "ABCDE";

        public const char Admin = 'A';
        public const char Director = 'B';
        public const char Manager = 'C';
        public const char Coordinator = 'D';
        public const char Chair = 'E';
        public const char Teacher = 'T';

        private static char NextLevelType(char locationType)
        {
            return _LEVELS[_LEVELS.IndexOf(locationType) + 1];
        }

        public static string LocationRole(char role)
        {
            switch (role)
            {
                case 'A': return "Admin";
                case 'B': return "Director";
                case 'C': return "Manager";
                case 'D': return "Coordinator";
                case 'E': return "Chair";
                case 'T': return "Teacher";
                default: return "---";
            }

        }

        public static string CurrentDomain(char role)
        {
            switch (role)
            {
                case 'A': return "Domain";
                case 'B': return "Division";
                case 'C': return "Region";
                case 'D': return "Metro";
                case 'E': return "District";
                case 'T': return "Studio";
                default: return "---";
            }
        }
        public static string NextDomain(char role) { return CurrentDomain(NextLevelType(role)); }
        public static string NextRole(char role) { return LocationRole(NextLevelType(role)); }

    }

    [Serializable]
    public struct LoginPerson
    {
        public int Id { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Instrument { get; set; }
        public string LocationName { get; set; }
        public int LocationId { get; set; }
        public string ParentLocationName { get; set; }
        public int ParentLocationId { get; set; }
        public char RoleType { get; set; }
    }
}