using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{
    public class EntryViewModel
    {
        private IEnumerable<EntryBase> _entries;
        private IEnumerable<EntryDetails> _entryDetails;
        private IDictionary<int, string> _entryDetailsRequired;
        private IEnumerable<StudentName> _studentNames;
        private IEnumerable<ClassTypeData> _classTypes;
        private EventViewModel _eventVM;

        public EntryViewModel(EventViewModel eventVM, int teacher)
        {
            SQLData.SelectEntryDetails(eventVM.Event.Id, teacher,
                out _studentNames, out _classTypes, out _entries, out _entryDetails, out var entryDetailsRequired);

            _entryDetailsRequired = entryDetailsRequired.ToDictionary(p => p.Id, p => p.RequiredDescription);
            _eventVM = eventVM;
        }

        public ClassTypeData GetClassTypeData(char classType)
        {
            return (from c in _classTypes
                    where c.ClassType == classType
                    select c).Single();
        }

        public IEnumerable<EntryVM> EntriesByClassType(char classType)
        {
            return from e in _entries
                   where e.ClassType == classType
                   join s in _studentNames
                   on e.Student equals s.Id
                   join d in _entryDetails
                   on e.Id equals d.Id into full
                   from f in full.DefaultIfEmpty()
                   orderby s.LastName, s.FirstName
                   select new EntryVM
                   {
                       StudentName = s.FullName,
                       EntryBase = e,
                       EntryDetails = f.Id == 0 ? new EntryDetails { Id = e.Id } : f,
                       RequiredPieceDesc = f.Id == 0 ? "" : _entryDetailsRequired[f.RequiredPiece] + TranslatePieceExtension(f.RequiredExtension) 
                   };
        }

        public IEnumerable<ClassTypeData> ClassTypes { get => _classTypes; }
        public EventViewModel EventVM { get => _eventVM; }

        private string TranslatePieceExtension(byte ext)
        {
            if (ext == 0)
                return "";
            else
                return $" Mvt. {ext}"; 
        }
    }

    public class EntryVM
    {
        public string StudentName { get; set; }
        public String ChoicePieceDesc { get;}
        public String RequiredPieceDesc { get; set; }
        public EntryBase EntryBase { get; set; }
        public EntryDetails EntryDetails { get; set; }
    }

}