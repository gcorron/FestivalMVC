using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public struct ReportModel
    {
        public int Id { get; }
        public string Description { get; }
        public string Name { get; }
        public string Params { get; }
    }
}