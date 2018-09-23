"use strict";

var AdminApp = (function () {


    var personAvailIcon = 'glyphicon glyphicon-star-empty';
    var personBusyIcon = 'glyphicon glyphicon-star';

    return {

        //public functions

        fillOrVacate: function (elt) {

            if (assignmentMode()) {
                cancelAssignmentMode();
                return;
            }

            var blob = storedLocation({ element: elt, begin: true });
            if (blob.location.ContactId) {
                if (confirm('Remove ' + blob.personName + ' from ' + blob.location.LocationName + '?')) {
                    blob.location.ContactId = 0;
                    blob.personName = '';
                    storedLocation(blob);
                    updateLocation(blob.location);
                }
            }
            else { //changed mode, update the UI
                changeAlertBox('#locationsAlert', 'Now, select a person with a ' + personAvailIcon + ' or click the cancel link.');
                changeAlertBox('#peopleAlert', 'You are selecting a person for ' + location.LocationName + '.');
                $('#addPerson').hide();
                $(elt).children('td')[1].append($('#cancelAssignment > a')[0]); //move the the cancel link out of the invisible div
                return;
            }
        },

        addPerson: function () {
            var person = new Person();
            AdminApp.editPerson(person, 0);
        },

        editPerson: function (person, assignedToLocation) {

            var canDelete = !assignedToLocation && person.Id;

            if (assignmentMode()) {

                var blob = storedLocation({});

                if (!person.Available) {
                    showInfoModal('Assign Person', person.FullName + ' does not have Available status. (You can change that.)');
                    return;
                }

                if (assignedToLocation > 0) {
                    showInfoModal('Assign Person', person.FullName + ' is already assigned to another location.');
                    return;
                }

                if (confirm('Assign ' + person.FullName + ' to ' + blob.location.LocationName + '?')) {
                    blob.location.ContactId = person.Id;
                    blob.personName = person.FullName;
                    storedLocation(blob);
                    updateLocation(blob.location);
                    return;
                }
            }
            else {

                populatePersonForm(person);
                $('.no-new').hide();
                $('#submitError').hide();

                if (person.Id !== 0) {
                    $('.no-new').show();
                }

                if (canDelete) {
                    $('#deleteButton').removeAttr('disabled');
                }
                else {
                    $('#deleteButton').attr('disabled', 'disabled');
                }

                $('#instrumentGroup').hide();
                if ($('#RoleType').val() === 'E') {
                    $('#instrumentGroup').show();
                }
            }
            $("#modalEdit").modal();

        },

        deletePerson: function () {
            if (confirm('Delete, are you sure?')) {
                $.ajax({
                    type: "POST",
                    url: "Admin/DeletePerson",
                    data: CollectFormData(),
                    dataType: "json",
                    success: onDeletePersonSuccess,
                    failure: onUpdatePersonFailure,
                    error: onUpdatePersonFailure
                });
            }
        },


        init: function () {
            $('#starsKey').attr('data-content', '<p>' + spanIcon(personBusyIcon) + ' means the person has been assigned to one of your locations.</p>' +
                '<p>' + spanIcon(personAvailIcon) + ' means the person has not been assigned.</p>' +
                '<p> No star means the person has been designated not available to be assigned.</p>').popover();

            //parse all the table row json objects, replace them with JQuery data objects
            var o;
            $('#locations tr').each(function (i, v) {
                o = JSON.parse($(v).attr('data-location'));
                $(v).data('location', o);
                $(v).removeAttr('data-location');
            });

            $('#people tr').each(function (i, v) {
                installPersonRow(v);
            });
            sortPersonTable();
        },

        updatePerson: function () {
            if (!$('#personForm').valid()) {
                showEditError('Attention', 'Please make corrections.');
                return;
            }
            updatePersonAjax();
        }

    };

    // ajax functions

    function updatePersonAjax() {
        $.ajax({
            type: "POST",
            url: "Admin/UpdatePerson",
            data: CollectFormData(),
            dataType: "html",
            success: onUpdatePersonSuccess,
            failure: onUpdatePersonFailure,
            error: onUpdatePersonFailure
        });

    }

    function updateLocation(location) {
        cancelAssignmentMode();

        $.ajax({
            type: "POST",
            url: "Admin/UpdateLocation",
            data: AddAntiForgeryToken({ location }),
            dataType: "json",
            success: onUpdateLocationSuccess,
            failure: onAJAXFailure,
            error: onAJAXFailure
        });
    }

    function onUpdateLocationSuccess() {
        storedLocation({ update: true });
    }

    function onUpdatePersonSuccess(html) {

        var removePersonId = $('#Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person if it exists

        var newRow = $(html)[0];
        var person = installPersonRow(newRow);

        $('#people').append(newRow);
        sortPersonTable();
        //now update the person's name in the location table, if assigned to one
        if (person.locationId) {
            var row = $('#locations tr[name="' + locationId + '"]')[0];
            row.children[1].innerText = person.FullName;
        }

        $('#modalEdit').modal('hide');
    }

    function onDeletePersonSuccess() {
        var removePersonId = $('#Id').val();
        $(personRowSelector(removePersonId)).remove(); //remove previous row for person
        $('#modalEdit').modal('hide');
    }

    function onUpdatePersonFailure(response) {
        showEditError('Server Error', parseResponse(response));
    }

    function onAJAXFailure(response) {
        showInfoModal('Server Error', parseResponse(response));
    }

    function parseResponse(response) {
        var message;

        if (response.responseJSON && response.responseJSON.Message)
            return response.responseJSON.Message;

        message = response.d || response.responseText;

        if (message == null)
            return 'No details available';

        try {
            return JSON.parse(message);
        }
        catch (e) {
            return message;
        }
    }

    function CollectFormData() {
        var name;
        var person = {};
        $('#personForm .form-control').each(function (i, control) {
            name = control.getAttribute('name');
            if (control.type === 'checkbox') {
                person[name] = control.checked;
            }
            else {
                person[name] = $.trim(control.value);
            }
        });
        var assignedToLocation = $('#personForm').data('assignedToLocation') || 0;
        return AddAntiForgeryToken({ person: person, assignedToLocation: assignedToLocation });
    }

    function AddAntiForgeryToken(data) {
        data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
        return data;
    }

    //DOM functions
    function sortPersonTable() {
        var table, rows, switching, i, shouldSwitch;
        var personx, persony, compared;
        table = document.getElementById("people");
        switching = true;
        while (switching) {
            switching = false;
            rows = table.rows;
            for (i = 0; i < (rows.length - 1); i++) {
                shouldSwitch = false;
                personx = $(rows[i]).data('person');
                persony = $(rows[i + 1]).data('person');
                compared = compare(personx.LastName, persony.LastName);
                if (compared === 0)
                    compared = compare(personx.FirstName, persony.FirstName);
                if (compared > 0) {
                    shouldSwitch = true;
                    break;
                }
            }
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
            }
        }
        function compare(x, y) {
            var cx = x.toLowerCase();
            var cy = y.toLowerCase();
            if (cx > cy)
                return 1;
            if (cx < cy)
                return -1;
            return 0;
        }

    }

    function changeAlertBox(selector, message) {
        var o = $(selector);
        // save the original message to restore later
        if (!(o.data('defaultMessage'))) {
            o.data('defaultMessage', o.text());
        }
        o.html(message);
        o.toggleClass('alert-info alert-warning');
    }

    function restoreAlertBox(selector) {
        var o = $(selector);
        var message = o.data('defaultMessage');
        o.text(message);
        o.toggleClass('alert-info alert-warning');
    }

    function spanIcon(icon) {
        return '<span class="' + icon + '"></span>';
    }

    function assignmentMode() {
        return ($('#cancelAssignment').has('a').length === 0);
    }

    function showInfoModal(heading, message) {
        $('#infoModal .modal-header h4').text(heading);
        $('#infoModal .modal-body p').text(message);
        $("#infoModal").modal();
    }

    function showEditError(prompt, message) {
        $('#submitError span').text(message);
        $('#submitError >strong').text(prompt + '  ');
        $('#submitError').show();
    }

    function cancelAssignmentMode() {
        $('#cancelAssignment').append($('#locations').find('a')[0]); // move the cancel link back into invisible div
        restoreAlertBox('#locationsAlert');
        restoreAlertBox('#peopleAlert');
        $('#addPerson').show();
    }

    function installPersonRow(v) {
        var o = JSON.parse($(v).attr('data-person'));
        $(v).data('person', o);
        $(v).find('[data-toggle="popover"]').
            popover({
                title: 'Contact',
                trigger: 'hover',
                content: o.Email + '  ph: ' + o.Phone
            });
        $(v).removeAttr('data-person');
        var p = JSON.parse($(v).attr('data-location'));
        $(v).data('location', p);
        $(v).removeAttr('data-location');
        return o; //return the data
    }

    //processing and data functions
    function storedLocation(o) {

        function ChangePersonAssigned(personId, LocationId) {
            function toggleStar(icon, appear) {
                $(personRowSelector(personId)).find('span').toggleClass(icon, appear);
            }

            var star = 'glyphicon-star';
            $(personRowSelector(personId)).attr('data-location', LocationId);
            toggleStar(star + '-empty', LocationId == 0);
            toggleStar(star, LocationId > 0);
        }

        var me = storedLocation;

        if (o.begin) {
            delete o.begin;
            me.stored = {};
            me.stored.element = o.element;
            me.stored.location = $(o.element).data('location');
            me.stored.ContactId = me.stored.location.ContactId;
            me.stored.personName = o.element.children[1].innerText;
            return $.extend({}, me.stored);
        }
        if ('location' in o) {
            me.stored.location = o.location;
        }
        if ('personName' in o) {
            me.stored.personName = o.personName;
        }

        if (o.update) {
            $(me.stored.element).data('location', me.stored.location);
            if (me.stored.ContactId) {
                ChangePersonAssigned(me.stored.ContactId, 0); // old no longer assigned to location 
            }
            if (me.stored.location.ContactId) {
                ChangePersonAssigned(me.stored.location.ContactId, me.stored.location.Id);
            }
            me.stored.element.children[1].innerText = me.stored.personName;
            delete me.stored;
            return;
        }
        return $.extend({}, me.stored);
    }

    function personData(id, data) {

        if (data) {
            $(personRowSelector(id)).data('person', data);
        }
        else {
            return $(personRowSelector(id)).data('person');
        }

    }

    function personRowSelector(id) {
        return '#people >tr[name="' + id + '"]';
    }

    function populatePersonForm(person) {
        var name;
        $('#personForm .form-control').each(function (i, control) {
            name = control.getAttribute('name');
            if (control.type === 'checkbox') {
                control.checked = person[name];
            }
            else {
                control.value = (person[name]);
            }
        });
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
        this.Instrument = '';
    }

})();

$(document).ready(function () {
    AdminApp.init();
});