using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{
    public class EntryViewModel
    {
        public IDictionary<int, string> Composers;
        public IDictionary<int, Piece> Pieces;
        public ILookup<string, int> PiecesByClass;
        public IEnumerable<EntryBase> _entries;
        public IEnumerable<EntryDetails> _entryDetails;
        public IEnumerable<StudentName> _studentNames;


        public EntryViewModel(int ev, int teacher)
        {
            SQLData.SelectEntryDetails(ev, teacher,
                out _studentNames, out var classTypes, out _entries, out _entryDetails, out var pieces, out var composers);

            Composers = (from c in composers
                         select c).ToDictionary(r => r.Id, r => r.Composer);
            Pieces = (from p in pieces
                      select p).ToDictionary(r => r.Id, r => r);
            PiecesByClass = (from p in pieces
                             select p).ToLookup(r => r.ClassAbbr, r => r.Id);
        }

        public IEnumerable<EntryVM> EntryByClassType(char classType)
        {
            return from e in _entries
                   join d in _entryDetails
                   on e.Id equals d.Id
                   join s in _studentNames
                   on e.Student equals s.Id
                   where e.ClassType == classType
                   select new EntryVM
                   {
                       StudentName = s.FullName,
                       EntryBase = e,
                       EntryDetails = d
                   };
        }

    }
    public class EntryVM
    {
        public string StudentName { get; set; }
        public EntryBase EntryBase { get; set; }
        public EntryDetails EntryDetails { get; set; }
    }
}