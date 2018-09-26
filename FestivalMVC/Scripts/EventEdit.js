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


            $('.form-control').each(function (i, elt) { // jQuery validation needs an unique name field to work
                elt.name = elt.id;
            });

        },


        editEvent: function (event) {

            if (event == null) {
                $('#deleteButton').hide();
                event = new Event();
            }
            else {
                $('#deleteButton').show();
                event = JSON.parse(event, dateTimeReviver);
            }

            populateEventForm(event);
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

            $('#formEdit').validate({
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

            if (!$('#formEdit').valid()) {
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

    function populateEventForm(event) {

        var control;

        for (var name in event) {
            control = $('#modalEventEdit #' + name);
            if (control) {
                if (control.prop('type') === 'checkbox')
                    control.prop('checked', event[name]);
                else if (control.prop('type') === 'date')
                    control.val(event[name].toISOString().split('T')[0]);
                else
                    control.val(event[name]);
            }
        }
    }

    function showEditError(prompt, message) {
        $('#submitError span').text(message);
        $('#submitError >strong').text(prompt + '  ');
        $('#submitError').show();
    }

    //utility

    function AddAntiForgeryToken(data) {
        data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
        return data;
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
            data: AddAntiForgeryToken({ id: $('#Id').val() }),
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
            data: CollectFormData(),
            dataType: "json",
            success: onAjaxUpdateEventSuccess,
            failure: onUpdateEventFailure,
            error: onUpdateEventFailure
        });

        function CollectFormData() {
            var name;
            var o = {};
            $('#formEdit .form-control').each(function (i, control) {
                name = control.getAttribute('name');
                if (control.type === 'checkbox') {
                    o[name] = control.checked;
                }
                else {
                    o[name] = $.trim(control.value);
                }
            });
            var temp = AddAntiForgeryToken({ theEvent: o }); //can't use 'event' as parameter name because C# won't allow it
            return temp;
        }
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
