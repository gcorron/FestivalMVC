"use strict";


var ChairApp = (function () {

    var myStorage;

    return {

        //public functions

        init: function () {
            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });


            //create the navigation menu from the divs
            var name;
            var uname;
            $('#contents .content').each(function (i, e) {
                name = $(e).attr('id');
                uname = name.substr(0, 1).toUpperCase() + name.substr(1);
                $('#menu').append('<li><a name="' + name + '" href="#" onclick="ChairApp.navigate(this.name)" >' + uname + '</a></li>');
            });



            getInitialData();


            //setup jQuery validation

            jQuery.validator.addMethod("beforeDate", function (value, element, params) {
                return this.optional(element) || value < params[0];
            }, jQuery.validator.format("Date must be before {1}."));


            $('.form-control').each(function (i, elt) { // jQuery validation needs an unique name field to work
                elt.name = elt.id;
            });



        },

        navigate: function (id) {
            switch (id) {
                case 'home': renderHome();
            }


            $('#menu li').removeClass('active');
            $('#contents .content').each(function (i, e) {
                if ($(e).attr('id') == id) {
                    $(e).show();
                    $($('#menu li')[i]).addClass('active');
                }
                else {
                    $(e).hide();
                }
            });
        },

        editEvent: function (id) {
            populateEventForm(id);
            clearAlerts();

            //if (id !== 0) {
            //    $('.no-new').show();
            //}

            //if (canDelete) {
            //    $('#deleteButton').removeAttr('disabled');
            //}
            //else {
            //    $('#deleteButton').attr('disabled', 'disabled');
            //}
            $("#modalEventEdit").modal();
        },

        updateEvent: function () {
            $('#formmodalEventEdit').validate({
                rules: {
                    OpenDate: {
                        required: true,
                        beforeDate: {
                            param: [$('#CloseDate').val(), 'Closed Date'],
                            depends: function (element) {
                                return $('#CloseDate').val();
                            }
                        }
                    },
                    CloseDate: {
                        required: true,
                        beforeDate: {
                            param: [$('#EventDate').val(), 'Audition Date'],
                            depends: function (element) {
                                return $('#EventDate').val();
                            }
                        }

                    }
                }
            });

            if (!$('#formmodalEventEdit').valid()) {
                showWarning('Please make corrections first.');
                return;
            }
            clearAlerts();
            //ajaxUpdateEvent();
        }
    };

    //private functions

    // render content
    function renderHome() {
        var events = myStorage.eventList();
        var clone;

        $('#selectEvent').remove('option').not('.blank');
        events.forEach(function (v, i, a) {
            clone = $('#selectEvent >.blank')[0].cloneNode(true);
            $(clone).text(v.EventDate);
            $(clone).find('input').val(v.Id);
            $('#selectEvent').append(clone);
        });
    }


    // UI
    function showWarning(message) {
        showAlert('.formWarning', message);
    }

    function showError(message) {
        showAlert('.formError', message);
    }

    function showAlert(selector, message) {
        clearAlerts();
        $(selector + ' >span').text(message);
        $(selector).show();
    }

    function clearAlerts() {
        $('.no-new, .alert').hide();
    }

    function showInfoModal(heading, message) {
        $('#infoModal h4').text(heading);
        $('#infoModal p').text(message);
        $("#infoModal").modal();
    }

    function onAJAXFailure(response) {
        showInfoModal('Server Error', parseResponse(response));
    }

    function populateEventForm(id) {
        var event = myStorage.event(id);
        var mess;
        var control;

        if (!event) {
            mess = 'event ' + id + ' not found!';
            alert(mess);
            throw mess;
        }

        for (var name in event) {
            control = $('#modalEventEdit #' + name);
            if (control) {
                if ($(control).attr('type') === 'checkbox')
                    control.prop('checked', event[name]);
                else
                    control.val(event[name]);
            }
        }
    }

    //utility
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

    function parseHelper(name, value) {
        // Remove any values whose property name begins with an underscore
        if (name[0] == '_') return undefined;
        // If the value is a string in ISO 8601 date format convert it to a Date.
        if (typeof value === "string" && /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ$/.test(value)) {
            return new Date(value);
        }
        // Otherwise, return
        return value;
    }

    //AJAX
    function ajaxUpdateEvent() {
        $.ajax({
            type: "POST",
            url: "Chair.aspx/UpdateEvent",
            data: CollectEventFormData(),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onUpdateEventSuccess,
            failure: onUpdateEventFailure,
            error: onUpdateEventFailure
        });

        function CollectEventFormData() {
            var control;
            var event = myStorage.getEvent(0); //just to get the property names

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


    }

    //data
    function getInitialData() {
        $.ajax({
            type: "POST",
            url: "Chair.aspx/GetInitialData",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onGetDataSuccess,
            failure: onAJAXFailure,
            error: onAJAXFailure
        });
    }

    function onGetDataSuccess(response) {
        myStorage = classStorage(response);
        ChairApp.navigate('home');
        $('#contents').removeAttr('style'); //now we can reveal everthing
    }

    function classStorage(response) {
        var array = JSON.parse(response.d, parseHelper);
        var people = makeDictionary(array[0], 'Id');
        var events = makeDictionary(array[1], 'Id');
        var teachers = makeLookup(array[2], 'Event', 'Teacher');

        return {
            person: function (key, person) {
                if (person) {
                    people[key] = person;
                }
                else {
                    return JSON.parse(JSON.stringify(people[key])); //return a clone to prevent changes to the original by reference
                }
            },

            event: function (key, event) {
                if (event) {
                    events[key] = event;
                }
                else {
                    return JSON.parse(JSON.stringify(events[key])); //return a clone to prevent changes to the original by reference
                }
            },
            teacher: function (eventkey, personkey, include) {
                if (teacher) {
                    if (include) {
                        teachers[eventkey][personkey] = true;
                    }
                    else {
                        delete teachers[eventkey][personkey];
                    }
                }
                else {
                    return (teachers[eventkey][personkey] === true);
                }
            },
            teacherList: function (eventkey) {
                //return new array of people
                //sorted by lastname, firstname, for the event
                return teachers[eventkey].filter(function (teacher) { return teacher.Event; }) //filter out null or 0 id, used for a prototype
                    .sort(function (a, b) { return (a.LastName === b.LastName) ? (a.FirstName < b.FirstName) : (a.LastName < b.LastName); });
            },
            eventList: function () {
                return events.filter(function (event) { event.Id; }).sort(function (a, b) { return a.EventDate < b.EventDate; });
            }
        };


        function makeDictionary(arr, key) {
            var newArray = new Array();
            arr.forEach(function (v, i, a) {
                newArray[v[key]] = v;
            });
            return newArray;
        }
        function makeLookup(arr, key1, key2) {
            var newArray = new Array();
            arr.forEach(function (v, i, a) {
                if (!(v[key1] in newArray)) {
                    newArray[v[key1]] = new Array();
                }
                newArray[v[key1]][v[key2]] = true;
            });
            return newArray;
        }
    }

})();

$(document).ready(function () {
    ChairApp.init();
}); 
