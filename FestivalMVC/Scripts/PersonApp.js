"use strict";

var PersonApp = (function () {
    var assignFunction = null;
    var controllerUrl;
    var personAvailIcon = 'glyphicon glyphicon-star-empty';
    var personBusyIcon = 'glyphicon glyphicon-star';

    return {
        init: function (forTeacher) {
            FestivalLib.initAjaxCursor();
            $('#persons tr').each(function (i, v) {
                installPersonRow(v);
            });
            FestivalLib.sortTableForPerson('person');
            $('#starsKey').attr('data-content', '<p>' + FestivalLib.spanIcon(personBusyIcon) + ' means the person has been assigned to an event or location.</p>' +
                '<p>' + FestivalLib.spanIcon(personAvailIcon) + ' means the person has not been assigned.</p>'
                + (forTeacher ? '' : '<p> No star means the person has been designated not available to be assigned.</p>')).popover();
            FestivalLib.$formElt('person','deleteButton').popover();
            controllerUrl = forTeacher ? '/Chair' : '/Admin';
        },

        canAssignPerson: function () {
            return assignFunction !== null;
        },

        assignPerson: function (person, currentAssignment) {
            if (!assignFunction)
                return;
            assignFunction(person, currentAssignment);
        },

        changePersonAssigned: function (personId, LocationId) {

            var star = 'glyphicon-star';
            var tr = $(personRowSelector(personId))[0];
            $(tr).data('location', LocationId);
            var span = $(tr).find('span')[0];
            $(span).toggleClass(star + '-empty', LocationId == 0);
            $(span).toggleClass(star, LocationId > 0);
        },

        editPerson: function (person, canDelete) {
            $('#personForm').data('assignedToLocation', person.AssignedToLocation); //needed for the new table row partial view being created on the server
            FestivalLib.popupForm('person', person, canDelete, person.Id === 0);
        },

        deletePerson: function () {
            if ($formElt('deleteButton').attr('disabled')) {
                return;
            }
            if (confirm('Delete, are you sure?')) {
                FestivalLib.postAjax(controllerUrl +'/DeletePerson', personFormData(), false, onDeletePersonSuccess, onUpdatePersonFailure);
            }
        },

        setAssignFunction: function (fn) {
            assignFunction = fn; // if null then it won't be called
        },

        addPerson: function () {
            var person = new Person();
            var instrument = $('#eventInstrument').val();
            if (instrument)
                person.Instrument = instrument;
            PersonApp.editPerson(person, false);
        },

        updatePerson: function () {
            if (!$('#personForm').valid()) {
                return;
            }
            FestivalLib.postAjax(controllerUrl + '/UpdatePerson', personFormData(), true,onUpdatePersonSuccess, onUpdatePersonFailure);
        }
    };

    function personFormData() {
        var person = FestivalLib.collectFormData('person', false);
        var assignedToLocation = $('#personForm').data('assignedToLocation') || 0;
        return { person: person, assignedToLocation: assignedToLocation };
    }

    function onUpdatePersonSuccess(html) {

        var removePersonId = $formElt('Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person if it exists

        var newRow = $(html)[0];
        var person = installPersonRow(newRow);

        $('#persons').append(newRow);
        FestivalLib.sortTableForPerson('person');
        //now update the person's name in the location table, if assigned to one
        if (person.locationId) {
            var row = $('#locations tr[name="' + locationId + '"]')[0];
            row.children[1].innerText = person.FullName;
        }
        $('#personModal').modal('hide');
    }

    function onDeletePersonSuccess() {
        var removePersonId = $formElt('Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person
        $('#personModal').modal('hide');
    }

    function onUpdatePersonFailure(response) {
        FestivalLib.ajaxFormFailure('person', response);
    }

    function installPersonRow(v) {
        var o = FestivalLib.convertJqueryData(v, 'person');
        $(v).find('a').
            popover({
                title: 'Contact',
                trigger: 'hover',
                placement: 'bottom',
                content: o.Email + '  ph: ' + o.Phone + '  login: ' + o.UserName
            });
        FestivalLib.convertJqueryData(v, 'location');
        return o; //return the data
    }

    function personRowSelector(id) {
        return '#persons >tr[name="' + id + '"]';
    }

    function $formElt(eltName) {
        return $('#personForm [name="' + eltName + '"]');
    }

    //constructor for new person
    function Person() {
        this.FirstName = '';
        this.LastName = '';
        this.Id = 0;
        this.Email = '';
        this.Phone = '';
        this.Available = true;
        this.Instrument = '-';
    }

})();