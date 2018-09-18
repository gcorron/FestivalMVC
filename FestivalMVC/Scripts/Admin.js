"use strict";

$(document).ready(function () {
    AdminApp.init();
});

var AdminApp = (function () {


    var personAvailIcon = '<span class="glyphicon glyphicon-star-empty"></span>';
    var personBusyIcon = '<span class="glyphicon glyphicon-star"></span>';

    var myStorage = new classStorage();
    var pendingLocation;

    getData();

    return {


        fillOrVacate: function (elt) {
            var person;
            var location = $(elt).data('lid');
            var keys = {};
            var tlocation;
            var eligiblePerson;

            if (assignmentMode()) {
                cancelAssignmentMode();
                return;
            }
            if (location.ContactId) {
                person = myStorage.getPerson(location.ContactId);
                if (confirm('Remove ' + fullName(person) + ' from ' + location.LocationName + '?')) {
                    updateLocation(0);
                }
            }
            else {
                //check how many are eligibile to fill

                myStorage.begin(); //create keys to search
                while ((tlocation = myStorage.nextLocation())) {
                    if (tlocation.ContactId) {
                        keys['p' + tlocation.ContactId] = 'Y';
                    }
                }

                // search for available people not assigned
                myStorage.begin();

                var count = 0;
                while ((person = myStorage.nextPerson()) && count <= 2) {
                    if (person.Available && !keys['p' + person.Id]) {
                        eligiblePerson = person;
                        count++;
                    }
                }

                switch (count) {
                    case 0: {
                        showInfoModal('Fill vacancy', 'No people are eligile right now.\nA person can only fill one position, and must have available status.\n' +
                            'Add a person or edit one who is not assigned,\nchanging their available status.');
                        return;
                    }
                    case 1: {
                        if (confirm('One person is eligible right now. Assign ' + fullName(eligiblePerson) + ' to ' + location.LocationName + '?')) {
                            pendingLocation = location;
                            updateLocation(eligiblePerson.Id);
                            return;
                        }
                        return;
                    }
                    default: {
                        changeAlertBox('#locationsAlert', 'Now, select a person with a ' + personAvailIcon + ' or click the cancel link.');
                        changeAlertBox('#peopleAlert', 'You are selecting a person for ' + location.LocationName + '.');
                        $('#addPerson').hide();
                        $(elt).children('td')[1].append($('#cancelAssignment > a')[0]); //move the the cancel link out of the invisible div
                        pendingLocation = location;
                        return;
                    }
                }
            }
        },

        editPerson: function (id) {
            var person;
            var location;
            var isAssigned = isPersonAssigned(); //nested function, also sets location if assigned
            var canDelete = !isAssigned && id !== 0;

            if (assignmentMode()) {
                person = myStorage.getPerson(id);

                if (!person.Available) {
                    showInfoModal('Assign Person', fullName(person) + ' does not have Available status. (You can change that.)');
                    return;
                }

                if (isAssigned) {
                    showInfoModal('Assign Person', fullName(person) + ' is already assigned to ' + location.LocationName + '.');
                }

                if (confirm('Assign ' + fullName(person) + ' to ' + pendingLocation.LocationName + '?')) {
                    updateLocation(id);
                }
                return;
            }
            else {
                populatePersonForm(id);
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

            function isPersonAssigned() {
                myStorage.begin();
                while ((location = myStorage.nextLocation())) {
                    if (location.ContactId === id) {
                        return true;
                    }
                }
                return false;
            }



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
            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });

            $('form').validate();

            $('#starsKey').attr('data-content', '<p>' + personBusyIcon + ' means the person has been assigned to one of your locations.</p>' +
                '<p>' + personAvailIcon + ' means the person has not been assigned.</p>' +
                '<p> No star means the person has been designated not available to be assigned.</p>');
        }

    };

    function updateLocation(contactId) {
        pendingLocation.ContactId = contactId;
        cancelAssignmentMode();

        $.ajax({
            type: "POST",
            url: "Admin.aspx/UpdateLocation",
            data: JSON.stringify({ location: pendingLocation }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onUpdateLocationSuccess,
            failure: onAJAXFailure,
            error: onAJAXFailure
        });
    }

    function onUpdateLocationSuccess(response) {
        myStorage.setLocation(pendingLocation);
        renderTables();
    }

    function onUpdatePersonSuccess(response) {
        var person = JSON.parse(response.d);
        myStorage.setPerson(person);
        renderTables();
        $('#modalEdit').modal('hide');
    }

    function onDeletePersonSuccess(response) {
        var person = JSON.parse(response.d);
        myStorage.deletePerson(person.Id);
        renderTables();
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

    function getData() {
        $.ajax({
            type: "POST",
            url: "Admin.aspx/GetPeople",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onGetDataSuccess,
            failure: onAJAXFailure,
            error: onAJAXFailure,
            global: true
        });
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

    function onGetDataSuccess(response) {
        var array = JSON.parse(response.d);
        var people = array[0];
        var locations = array[1];

        people.forEach(function (person) { myStorage.setPerson(person); });
        locations.forEach(function (location) { myStorage.setLocation(location); });
        renderTables();
    }

    function renderTables() {
        var row;
        var tr;
        var table;
        var clone;
        var anchor;
        var person;
        var people;
        var location;
        var assigned = {};

        // erase any existing rows, except the blank template row
        $('#locations>tr').not('#blankLocation').remove();
        $('#people>tr').not('#blankPerson').remove();

        // add locations (sort order never changes)

        myStorage.begin();
        row = document.getElementById('blankLocation');
        table = document.getElementById('locations');
        while ((location = myStorage.nextLocation()) !== null) {
            if (location.ContactId) {
                assigned[location.ContactId] = 'Y';
            }
            clone = row.cloneNode(true);
            clone.getElementsByTagName('td')[0].innerText = location.LocationName;
            clone.getElementsByTagName('td')[1].innerText = contactName(location.ContactId);
            clone.setAttribute('id', location.key);
            $(clone).data('lid', location);
            addClone();
        }

        // add people
        people = sortedPeople();
        row = document.getElementById('blankPerson');
        table = document.getElementById('people'); // find table body to append to

        for (var i = 0; i < people.length; i++) {
            person = people[i];
            clone = row.cloneNode(true); // true means get all descendant nodes too
            clone.setAttribute('id', person.key);
            anchor = clone.getElementsByTagName('a')[0];
            anchor.innerText = fullName(person);
            anchor.setAttribute('data-content', person.Email + '  ph. ' + person.Phone);
            $(anchor).data("pid", person.Id);
            clone.getElementsByTagName('td')[1].innerHTML = assigned[person.Id] ? personBusyIcon : person.Available ? personAvailIcon : '';
            addClone();
        }
        $('[data-toggle="popover"]').popover(); // enable popover anchor for persons

        function addClone() {
            $(clone).removeClass('nodisplay')
            table.append(clone);
        }

    }

    function enableButton(buttonName) {
        document.getElementById(buttonName).classList.remove('disabled');
    }

    function sortedPeople() {
        var arr = [];
        var person;

        myStorage.begin();
        while ((person = myStorage.nextPerson())) {
            arr.push(person);
        }

        arr.sort(function (a, b) {
            return sortName(a) < sortName(b) ? -1 : 1;
        });

        return arr;

        function sortName(person) {
            return person.LastName + ' ' + person.FirstName;
        }

    }

    //simulates localstorage, or database, ensuring that objects returned are not references to the stored data
    //which the code could inadvertently change
    function classStorage() {
        var dict = {};
        var index;
        var keyz;

        return {
            begin: function () {
                keyz = Object.keys(dict);
                index = 0;
            },

            nextPerson: function () {
                return nextObject('p');
            },

            nextLocation: function () {
                return nextObject('l');
            },

            setPerson: function (person) {
                set((person.Id === 0 ? 'P' : 'p') + person.Id, person); // P for blank person, so nextPerson does not return it
            },

            getPerson: function (id) {
                return get((id === 0 ? 'P' : 'p') + id);
            },

            deletePerson: function (id) {
                delete dict['p' + id];
            },

            setLocation: function (location) {
                set('l' + location.Id, location);
            },

            getLocation: function (id) {
                return get('l' + id);
            }
        };

        function set(key, datum) {
            dict[key] = datum;
        }

        function get(key) {
            var o = jQuery.extend(true, {}, dict[key]); // return a clone of the object
            Object.defineProperty(o, "key", {
                value: key,
                writable: false,
                enumerable: false,
                configurable: true
            });
            return o;
        }

        function nextObject(keytype) {
            while (index < keyz.length && keyz[index].slice(0, 1) !== keytype) {
                index++;
            }
            if (index < keyz.length) {
                return get(keyz[index++]);
            }
            else {
                return null;
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

    function contactName(id) {
        var person;
        if (id) {
            person = myStorage.getPerson(id);
            return fullName(person);
        }
        return '';
    }

    function fullName(person) {
        return person.FirstName + ' ' + person.LastName;
    }
})();

