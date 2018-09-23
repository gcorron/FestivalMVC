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



            $('.form-control').each(function (i, elt) { // jQuery validation needs an unique name field to work
                elt.name = elt.id;
            });

            hideOrShowTable();
            $('#events input').attr('checked', false);
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
        onSelectedEvent: function () {
            $('.selectFirst').show();
            $('#prompt').text('Now you can go to Planning, Entries, or Results.');
        }


    };

    //private functions

    // UI


    function hideOrShowTable() {
        var rowCount = $('table tr').length;
        var starting = false;
        if (rowCount < 2)
            starting = true;

        if (starting) {
            $('table').hide();
            $('#prompt1').show();
            $('#prompt2').hide();
        }
        else {

            $('table').show();
            $('#prompt1').hide();
            $('#prompt2').show();
        }
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

function onAJAXFailure(response) {
    showInfoModal('Server Error', parseResponse(response));
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

function onUpdateEventSuccess(response) {

    if (response.success == false) {
        showEditError('Server Error', response.responseText);
        return;
    }

    var html = response.view;

    var removeEventId = $('#Id').val();
    $('#events >tr[name="' + id + '"]').remove(); //remove previous row for event if it exists

    var newRow = $(html)[0];
    installEventRow(newRow);
    // could try to insert it in the correct sort order
    $('#events').append(newRow);
    $('#modalEdit').modal('hide');
}

function installEventRow(v) {
    var o = JSON.parse($(v).attr('data-event'));
    $(v).data('event', o);
    $(v).removeAttr('data-event');
}

function onUpdateEventFailure(reponse) {
    showEditError('Server Error', parseResponse(response));
}

function showEditError(prompt, message) {
    $('#submitError span').text(message);
    $('#submitError >strong').text(prompt + '  ');
    $('#submitError').show();
}
function AddAntiForgeryToken(data) {
    data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
    return data;
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


}) ();

$(document).ready(function () {
    ChairApp.init();
}); 
