"use strict";

$(document).ready(function () {
    AdminApp.init();
});

var AdminApp = (function () {


    var personAvailIcon = '<span class="glyphicon glyphicon-star-empty"></span>';
    var personBusyIcon = '<span class="glyphicon glyphicon-star"></span>';

    return {


        fillOrVacate: function (elt) {

            if (assignmentMode()) {
                cancelAssignmentMode();
                return;
            }

            var blob = storedLocation({ element: elt, begin:true});
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

        editPerson: function (person, assignedToLocation) {
            var canDelete = !assignedToLocation && person.Id;

            if (assignmentMode()) {

                var blob = storedLocation({});

                if (!person.Available) {
                    showInfoModal('Assign Person', fullName(person) + ' does not have Available status. (You can change that.)');
                    return;
                }

                if (assignedToLocation > 0) {
                    showInfoModal('Assign Person', fullName(person) + ' is already assigned to another location.');
                    return;
                }

                if (confirm('Assign ' + fullName(person) + ' to ' + blob.location.LocationName + '?')) {
                    blob.location.ContactId = person.Id;
                    blob.personName = fullName(person);
                    storedLocation(blob);
                    updateLocation(blob.location);
                    return;
                }
            }
            else {
                populatePersonForm(person.Id);
                $('.no-new, #submitError').hide();

                if (id !== 0) {
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
                    url: "Admin.aspx/DeletePerson",
                    data: CollectJsonFormData(),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: onDeletePersonSuccess,
                    failure: onUpdatePersonFailure,
                    error: onUpdatePersonFailure
                });
            }
        },

        updatePerson: function () {
            if (!$('form').valid()) {
                showInfoModal('Attention', 'Please make corrections first.');
                return;
            }

            $.ajax({
                type: "POST",
                url: "Admin.aspx/UpdatePerson",
                data: CollectJsonFormData(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: onUpdatePersonSuccess,
                failure: onUpdatePersonFailure,
                error: onUpdatePersonFailure
            });
        },

        init: function () {

            $('#starsKey').attr('data-content', '<p>' + personBusyIcon + ' means the person has been assigned to one of your locations.</p>' +
                '<p>' + personAvailIcon + ' means the person has not been assigned.</p>' +
                '<p> No star means the person has been designated not available to be assigned.</p>');


            $('[data-toggle="popover"]').popover(); // enable popover anchor for persons

        }


    };

    function updateLocation(location) {
        cancelAssignmentMode();

        $.ajax({
            type: "POST",
            url: "Admin/UpdateLocation",
            data: JSON.stringify({ location }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onUpdateLocationSuccess,
            failure: onAJAXFailure,
            error: onAJAXFailure
        });
    }

    function onUpdateLocationSuccess(response) {
        storedLocation({ update: true });
    }

    function storedLocation(o) {

        function ChangePersonAssigned(personId,LocationId) {
            $('#people >tr[name="' + personId + '"]').attr('data-location',LocationId);
        }

        var me = storedLocation;

        if (o.begin) {
            delete o.begin;
            me.stored = {};
            me.stored.element = o.element;
            me.stored.location = JSON.parse(o.element.getAttribute('data-location'));
            me.stored.ContactId = me.stored.location.ContactId;
            me.stored.personName = o.element.children[1].innerText;    
            return $.extend({},me.stored);
        }
        if ('location' in o) {
            me.stored.location = o.location;
        }
        if ('personName' in o) {
            me.stored.personName = o.personName;
        }

        if (o.update) {
            me.stored.element.setAttribute('data-location',JSON.stringify(me.stored.location));
            if (me.stored.ContactId) {
                ChangePersonAssigned(me.stored.ContactId, "0"); // old no longer assigned to location 
            }
            if (me.stored.location.ContactId) {
                ChangePersonAssigned(me.stored.location.ContactId, me.stored.location.Id);
            }
            me.stored.element.children[1].innerText = me.stored.personName;
            delete me.stored;
        }
        return $.extend({}, me.stored);
    }

    function storedPerson(p) {
        var element;

        if ('children' in p) { //it's an element, checking the data out
            element = p;
            return JSON.parse($(element).attr('data-person'));
        }
        else { //it's a data object, checking it in
            $(element).attr('data-person', JSON.stringify(p));
        }
    }

    function onUpdatePersonSuccess(response) {
        var person = JSON.parse(response.d);
        $('#modalEdit').modal('hide');
    }

    function onDeletePersonSuccess(response) {
        var person = JSON.parse(response.d);
        $('#modalEdit').modal('hide');
    }

    function onUpdatePersonFailure(response) {
        $('#serverError').text(parseResponse(response));
        $('#submitError').show();

    }

    function cancelAssignmentMode() {
        $('#cancelAssignment').append($('#locations').find('a')[0]); // move the cancel link back into invisible div
        restoreAlertBox('#locationsAlert');
        restoreAlertBox('#peopleAlert');
        $('#addPerson').show();
    }


    function onAJAXFailure(response) {

        showInfoModal(parseResponse(response));
    }

    function parseResponse(response) {
        if (response.d) {
            try {
                return JSON.parse(response.d);
            }
            catch (e) {
                return response.d;
            }
        }
        else if (response.responseJSON) {
            return response.responseJSON.Message;
        }
        else if (response.responseText) {
            return response.responseText;
        }
        else {
            return 'No response from server.';
        }
    }

    function populatePersonForm(id) {
        var person = myStorage.getPerson(id);
        var mess;
        var control;

        if (!person) {
            mess = + 'person ' + id + ' not found!';
            alert(mess);
            throw mess;
        }

        for (var name in person) {
            control = $('#' + name);
            if (control) {
                if ($(control).attr('type') === 'checkbox')
                    control.prop('checked', person[name]);
                else
                    control.val(person[name]);
            }
        }
    }

    function CollectJsonFormData() {
        var control;
        var person = myStorage.getPerson(0); //just to get the property names

        for (var name in person) {
            control = $('#' + name);
            if (control) {
                if ($(control).attr('type') === 'checkbox')
                    person[name] = control.prop('checked');
                else
                    person[name] = control.val();
            }
        }
        return JSON.stringify({ person: person });
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

    function assignmentMode() {
        return ($('#cancelAssignment').has('a').length === 0);
    }

    function showInfoModal(heading, message) {
        $('#infoModal h4').text(heading);
        $('#infoModal p').text(message);
        $("#infoModal").modal();
    }

    function fullName(person) {
        return person.FirstName + ' ' + person.LastName;
    }
})();

