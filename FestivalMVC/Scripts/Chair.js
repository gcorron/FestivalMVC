"use strict";

var ChairApp = (function () {

     return {

        //public functions

        init: function () {
            function dateTimeReviver (key, value) {
                var a;
                if (typeof value === 'string') {
                    a = /\/Date\((\d*)\)\//.exec(value);
                    if (a) {
                        return new Date(+a[1]);
                    }
                }
                return value;
            }
            var o;

            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });


            $('#events tr').each(function (i, v) {
                o = JSON.parse($(v).attr('data-event'), dateTimeReviver);
                $(v).data('event', o);
                $(v).removeAttr('data-event');
            });



            $('.form-control').each(function (i, elt) { // jQuery validation needs an unique name field to work
                elt.name = elt.id;
            });

        
            $('.hide').removeClass('hide');


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
        },
        selectEvent: function (elt) {
            var event = $(elt).data('event');
            $('#selectedEvent').val(event.EventDescription);
            $('#selectedEvent').data(event);
            $('.sel-event').removeClass('disabled');
            nextPhase();
        }
     };

    //private functions


    // UI
    function nextPhase() {
        var form = document.createElement("form");
        var event = $('#selectedEvent').data();
        form.setAttribute("method", "post");
        form.setAttribute("action", "/Chair/Index");



        for (var key in params) {
            if (params.hasOwnProperty(key)) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", key);
                hiddenField.setAttribute("value", params[key]);

                form.appendChild(hiddenField);
            }
        }

        document.body.appendChild(form);
        form.submit();

        window.location.assign('/Chair/NextPhase?id=Prepare');
    }

   
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

        function populateEventForm(id) {
        var event;

        if (id == 0)
            event = new Event();
        else
            event = getEvent(id);

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

    //AJAX

    function onAJAXFailure(response) {
        showInfoModal('Server Error', parseResponse(response));
    }

    function onUpdateEventFailure(response) {
        showEditError('Server Error', parseResponse(response));
    }

    function ajaxUpdateEvent() {
        $.ajax({
            type: "POST",
            url: "Chair/UpdateEvent",
            data: CollectFormData(),
            dataType: "json",
            success: onUpdateEventSuccess,
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
            var temp = AddAntiForgeryToken({ theEvent: o }); //can't use event as parameter name because C# won't allow it
            return temp;
        }
    }

    function onUpdateEventSuccess(html) {
        $('#modalEdit').modal('hide');
        nextPhase();
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
    ChairApp.init();
}); 
