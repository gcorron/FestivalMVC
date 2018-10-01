using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FestivalMVC;
using FestivalMVC.Models;

namespace FestivalMVC.ViewModels
{

    public struct PreparePageViewModel
    {
        // Constructor
        public PreparePageViewModel(int eventId)
        {

            SQLData.SelectTeachersForEvent(eventId, out IEnumerable<ContactForView> teachers, out IEnumerable<Judge> judges);

            PeopleViewModel = new PeopleViewModel(teachers, "Teachers");
            Judges = judges;
        }

        public PeopleViewModel PeopleViewModel { get; private set; }
        public IEnumerable<Judge> Judges { get; private set; }

    }

}
