using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC.Models
{
    public struct ClassTypeData
    {
        public char ClassType { get; set; }
        public string TypeName { get; set; }
        public bool RequiresChoicePiece { get; set; }
        public bool RequiresAccomp { get; set; }
    }

    public struct StudentName
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get => $"{FirstName} {LastName}"; }
    }

    public struct EntryBase
    {
        public int Id { get; set; }
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
        public char Status { get; set; }
    }

    public struct EntryDetails
    {
        private string _choicePiece;
        private string _choiceComposer;
        private string _publisher;
        private string _accompanist;
        private string _notes;

        public int Id { get; set; }
        public int RequiredPiece { get; set; }
        public char RequiredExtension { get; set; }
        public string ChoicePiece { get =>_choicePiece; set => _choicePiece= (value ?? "").Trim(); }
        public string ChoiceComposer { get => _choiceComposer; set => _choiceComposer =(value ?? "").Trim(); }
        public string Publisher { get => _publisher; set => _publisher = (value ?? "").Trim(); }
        public string Accompanist { get => _accompanist; set => _accompanist = (value ?? "").Trim(); }
        public string Notes { get => _notes; set => _notes = (value ?? "").Trim(); }
    }

    public struct EntryDetailsRequired
    {
        public int Id { get; set; }
        public string RequiredDescription { get; set; }
    }

    public struct Piece
    {
        public int Id { get; set; }
        public string Composition { get; set; }
        public int Composer { get; set; }
        public byte Extension { get; set; }
    }

    public struct ComposerName
    {
        public int Id { get; set; }
        public string Composer { get; set; }
    }

}