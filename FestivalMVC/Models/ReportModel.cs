using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public static class ReportModelRoles
    {
        public static readonly char AdminRole='A';
        public static readonly char ChairRole = 'C';
        public static readonly char TeacherRole = 'T';
    }

    public static class ReportModelParamTypes
    {
        public static readonly char Location = 'L';
        public static readonly char Event = 'E';
        public static readonly char Teacher = 'T';
    }

    public struct ReportModel
    {
        public int Id { get; }
        public string Description { get; }
        public string Name { get; }
        public string Params { get; }
    }
}