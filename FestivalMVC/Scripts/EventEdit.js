"use strict";

var EventEdit = (function () {
    return {

        //public functions

        init: function () {

            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });
        },


        editEvent: function (event) {

            var $elt = $formElt('deleteButton');
            if (event == null) {
                $elt.hide();
                event = new Event();
            }
            else {
                $elt.show();
                event = JSON.parse(event, dateTimeReviver);
            }

            FestivalLib.populateForm('event',event);
            clearAlerts();


            $("#modalEventEdit").modal();
        },

        deleteEvent: function () {
            if (!confirm("Delete this event. Are you sure?"))
                return;
            ajaxDeleteEvent();
        },

        updateEvent: function () {

            jQuery.validator.addMethod("beforeDate", function (value, element, params) {
                return this.optional(element) || value < params[0];
            }, jQuery.validator.format("Date must be before {1}."));

            $('#eventForm').validate({
                errorClass: 'bg-danger',
                errorPlacement: function (error, element) {
                    if (element.attr("name") == "ClassTypes[]")
                        error.appendTo($formElt('classTypeSelect'));
                    else
                        error.insertAfter(element);
                },

                rules: {
                    OpenDate: {
                        required: true,
                        beforeDate: {
                            param: [$formElt('CloseDate').val(), 'Closed Date'],
                            depends: function (element) {
                                return $formElt('CloseDate').val();
                            }
                        }
                    },
                    CloseDate: {
                        required: true,
                        beforeDate: {
                            param: [$formElt('EventDate').val(), 'Audition Date'],
                            depends: function (element) {
                                return $formElt('EventDate').val();
                            }
                        }
                    },
                    "ClassTypes[]": {
                        required: function (element) {
                            var boxes = $formElt('ClassTypes[]');
                            if (boxes.filter(':checked').length == 0) {
                                return true;
                            }
                            return false;
                        },
                        minlength: 1
                    }
                },

                messages: {
                    "ClassTypes[]": 'Please select at least one Class Type.'
                }
            });
            if (!$('#eventForm').valid()) {
                showWarning('Please make corrections first.');
                return;
            }
            clearAlerts();
            ajaxUpdateEvent();
        }
    };

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


  
    function showEditError(prompt, message) {
        var $errdiv = $formElt('submitError');
        $errdiv.find('span').text(message);
        $errdiv.find('strong').text(prompt + '  ');
        $errdiv.show();
    }

    //utility

    function $formElt(name) {
        return $('#eventForm [name="' + name + '"]');
    }

    function dateTimeReviver(key, value) {
        var a;
        if (typeof value === 'string') {
            a = /\/Date\((\d*)\)\//.exec(value);
            if (a) {
                return new Date(+a[1]);
            }
        }
        return value;
    }

    //AJAX

    function onUpdateEventFailure(response) {
        showEditError('Server Error', parseResponse(response));
    }

    function ajaxDeleteEvent() {
        $.ajax({
            type: "POST",
            url: "/Chair/DeleteEvent",
            data: FestivalLib.AddAntiForgeryToken({ id: $formElt('Id').val() }),
            dataType: "json",
            success: onAjaxUpdateEventSuccess,
            failure: onUpdateEventFailure,
            error: onUpdateEventFailure
        });
    }

    function ajaxUpdateEvent() {
        $.ajax({
            type: "POST",
            url: "/Chair/UpdateEvent",
            data: FestivalLib.collectFormData('event',true),
            dataType: "json",
            success: onAjaxUpdateEventSuccess,
            failure: onUpdateEventFailure,
            error: onUpdateEventFailure
        });
    }

    function onAjaxUpdateEventSuccess(response) {
        window.location = response.redirect;
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

    function Event() {
        this.Id = 0;
        this.Location = $('#events').data('location');
        this.OpenDate = "";
        this.CloseDate = "";
        this.EventDate = "";
        this.Instrument = "";
        this.Status = "A";
        this.Venue = "";
        this.Notes = "";
    }


})();

$(document).ready(function () {
    EventEdit.init();
}); 
