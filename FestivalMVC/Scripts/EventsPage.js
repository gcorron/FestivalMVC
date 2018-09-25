"use strict";

var EventsPage = (function () {

    return {

        //public functions

        init: function () {

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

            var o;

            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });


            $('a[data-event]').each(function (i, v) {
                o = JSON.parse($(v).attr('data-event'), dateTimeReviver);
                $(v).data('event', o);
                $(v).removeAttr('data-event');
            });

            $('.hide').removeClass('hide');
        },

        selectEvent: function (elt) {
            var event = $(elt).data('event');
            var data = AddAntiForgeryToken({ id: event.Event.Id });
            ajaxSelectEvent(data);
        }
    };


    // UI

    function showInfoModal(heading, message) {
        $('#infoModal h4').text(heading);
        $('#infoModal p').text(message);
        $("#infoModal").modal();
    }

    //utility

    function AddAntiForgeryToken(data) {
        data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
        return data;
    }

    //AJAX
    function ajaxSelectEvent(data) {
        $.ajax({
            type: "POST",
            url: "/Chair/Index",
            data: data,
            dataType: "json",
            success: onAjaxSelectEventSuccess,
            failure: onAjaxFailure,
            error: onAjaxFailure
        });
    }

    function onAjaxSelectEventSuccess(response) {
        window.location = response.redirect;
    }

    function onAjaxFailure(response) {
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

})();

$(document).ready(function () {
    EventsPage.init();
}); 
