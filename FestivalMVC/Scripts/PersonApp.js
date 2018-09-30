"use strict";

var PersonApp = (function () {
    var assignFunction = null;
    var controllerUrl;
    var personAvailIcon = 'glyphicon glyphicon-star-empty';
    var personBusyIcon = 'glyphicon glyphicon-star';

    return {
        init: function (forTeacher) {
            $('#persons tr').each(function (i, v) {
                installPersonRow(v);
            });
            FestivalLib.sortTableForPerson('person');
            $('#starsKey').attr('data-content', '<p>' + FestivalLib.spanIcon(personBusyIcon) + ' means the person has been assigned to an event or location.</p>' +
                '<p>' + FestivalLib.spanIcon(personAvailIcon) + ' means the person has not been assigned.</p>'
                + (forTeacher ? '' : '<p> No star means the person has been designated not available to be assigned.</p>')).popover();
            if (forTeacher) {
                $formElt('Available').closest('div').hide().removeClass('no-new');
            }
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
            populatePersonForm(person);
            $('#personForm .no-new').hide();
            $formElt('submitError').hide();

            if (person.Id !== 0) {
                $('#personForm .no-new').show();
            }

            if (canDelete) {
                $formElt('deleteButton').removeAttr('disabled');
            }
            else {
                $formElt('deleteButton]').attr('disabled', 'disabled');
            }

            $("#modalEdit").modal();
        },

        deletePerson: function () {
            if ($formElt('deleteButton').attr('disabled')) {
                return;
            }
            if (confirm('Delete, are you sure?')) {
                $.ajax({
                    type: "POST",
                    url: "Admin/DeletePerson",
                    data: personFormData(),
                    dataType: "json",
                    success: onDeletePersonSuccess,
                    failure: onUpdatePersonFailure,
                    error: onUpdatePersonFailure
                });
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
            PersonApp.editPerson(person, 0);
        },

        updatePerson: function () {
            if (!$('#personForm').valid()) {
                return;
            }
            updatePersonAjax();
        }
    };

    function updatePersonAjax() {
        $.ajax({
            type: "POST",
            url: controllerUrl + "/UpdatePerson",
            data: personFormData(),
            dataType: "html",
            success: onUpdatePersonSuccess,
            failure: onUpdatePersonFailure,
            error: onUpdatePersonFailure
        });
    }

    function personFormData() {
        var person = FestivalLib.collectFormData('person', false);
        var assignedToLocation = $('#personForm').data('assignedToLocation') || 0;
        return FestivalLib.addAntiForgeryToken({ person: person, assignedToLocation: assignedToLocation });
    }

    function onUpdatePersonSuccess(html) {

        var removePersonId = $formElt('Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person if it exists

        var newRow = $(html)[0];
        var person = installPersonRow(newRow);

        $('#persons').append(newRow);
        sortPersonTable();
        //now update the person's name in the location table, if assigned to one
        if (person.locationId) {
            var row = $('#locations tr[name="' + locationId + '"]')[0];
            row.children[1].innerText = person.FullName;
        }

        $('#modalEdit').modal('hide');
    }

    function onDeletePersonSuccess() {
        var removePersonId = $formElt('Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person
        $('#modalEdit').modal('hide');
    }

    function onUpdatePersonFailure(response) {
        FestivalLib.ajaxFormFailure('person', response);
    }


    function installPersonRow(v) {
        o = FestivalLib.convertJqueryData(v, 'person');
        $(v).find('a').
            popover({
                title: 'Contact',
                trigger: 'hover',
                content: o.Email + '  ph: ' + o.Phone
            });
        FestivalLib.convertJqueryData(v, 'location');
        return o; //return the data
    }

    function personRowSelector(id) {
        return '#persons >tr[name="' + id + '"]';
    }

    $formElt(eltName) {
        return $('#personForm [name="' + eltName + '"]');
    }

    function populatePersonForm(person) {
        FestivalLib.populateForm('person', person);
        $('#personForm').data('assignedToLocation', person.AssignedToLocation); //needed for the new table row partial view being created on the server
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