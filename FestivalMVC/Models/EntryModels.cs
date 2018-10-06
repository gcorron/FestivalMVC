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
        public bool ChoicePiece { get; set; }
    }

    public struct StudentName
    {
        public int Id { get; set; }
        public string FullName { get; set; }
    }

    public struct EntryBase
    {
        public int Id { get; set; }
        public int Student { get; set; }
        public char ClassType { get; set; }
        public string ClassAbbr { get; set; }
    }

    public struct EntryDetails
    {
        public int Id { get; set; }
        public int RequiredPiece { get; set; }
        public byte RequiredExtension { get; set; }
        public string ChoicePiece { get; set; }
        public string ChoiceComposer { get; set; }
        public string Publisher { get; set; }
        public string Accompanist { get; set; }
        public string Notes { get; set; }
    }

    public struct Piece
    {
        public int Id { get; set; }
        public string ClassAbbr { get; set; }
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