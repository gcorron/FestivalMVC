"use strict";

var AdminApp = (function () {


    return {

        fillOrVacate: function (elt) {

            var personAvailIcon = 'glyphicon glyphicon-star-empty';

            if (PersonApp.canAssignPerson()) {
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
                changeAlertBox('#locationsAlert', 'Now, select a person with a ' + FestivalLib.spanIcon(personAvailIcon) + ' or click the cancel link.');
                changeAlertBox('#peopleAlert', 'You are selecting a person for ' + blob.location.LocationName + '.');
                $('#addPerson').hide();
                $(elt).children('td')[1].append($('#cancelAssignment > a')[0]); //move the the cancel link out of the invisible div
                PersonApp.setAssignFunction(assignToLocation);
                return;
            }
        },

        init: function () {
            $('#locations tr').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'location');
            });
        }
    };

    // ajax functions

    function updateLocation(location) {
        cancelAssignmentMode();
        FestivalLib.postAjax('Admin/UpdateLocation', { location }, false, onUpdateLocationSuccess,null);
    }

    function onUpdateLocationSuccess() {
        storedLocation({ update: true });
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

    function assignToLocation(person, assignedToLocation) {
        var blob = storedLocation({});

        if (!person.Available) {
            FestivalLib.showInfoModal('Assign Person', person.FullName + ' does not have Available status. (You can change that.)');
            return;
        }

        if (assignedToLocation > 0) {
            FestivalLib.showInfoModal('Assign Person', person.FullName + ' is already assigned to another location.');
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

    function cancelAssignmentMode() {
        $('#cancelAssignment').append($('#locations').find('a')[0]); // move the cancel link back into invisible div
        PersonApp.setAssignFunction(null);
        restoreAlertBox('#locationsAlert');
        restoreAlertBox('#peopleAlert');
        $('#addPerson').show();
    }

    //processing and data functions
    function storedLocation(o) {

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
                PersonApp.changePersonAssigned(me.stored.ContactId, 0); // old no longer assigned to location 
            }
            if (me.stored.location.ContactId) {
                PersonApp.changePersonAssigned(me.stored.location.ContactId, me.stored.location.Id);
            }
            me.stored.element.children[1].innerText = me.stored.personName;
            delete me.stored;
            return;
        }
        return $.extend({}, me.stored);
    }


})();

$(document).ready(function () {
    PersonApp.init(false);
    AdminApp.init();
});