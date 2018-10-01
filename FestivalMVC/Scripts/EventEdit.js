"use strict";

var EventEdit = (function () {
    return {

        //public functions

        init: function () {
            FestivalLib.initAjaxCursor();
        },

        editEvent: function (event) {

            var newEvent = false;
            if (event == null) {
                event = new Event();
                newEvent = true;
            }
            else {
                event = FestivalLib.parseObject(event);
            }
            FestivalLib.popupForm('event', event,newEvent);
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
                return;
            }
            ajaxUpdateEvent();
        }
    };

    function $formElt(name) {
        return $('#eventForm [name="' + name + '"]');
    }

    function onUpdateEventFailure(response) {
        FestivalLib.ajaxFormFailure('event', response);
    }

    function ajaxDeleteEvent() {
        FestivalLib.postAjax('/Chair/DeleteEvent', { id: $formElt('Id').val() }, false, onUpdateEventSuccess, onUpdateEventFailure);
    }
    function onUpdateEventSuccess(response) {
        window.location = response.redirect;
    }

    function ajaxUpdateEvent() {
        FestivalLib.postAjax('/Chair/UpdateEvent', 'event', false, onUpdateEventSuccess, onUpdateEventFailure);
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
        this.ClassTypes = "";
    }

})();

$(document).ready(function () {
    EventEdit.init();
}); 
