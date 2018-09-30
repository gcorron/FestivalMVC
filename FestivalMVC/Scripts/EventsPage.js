"use strict";

var EventsPage = (function () {

    return {

        //public functions

        init: function () {

            
            var o;

            FestivalLib.initAjaxCursor();

            $('a[data-event]').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'event');
            });

            $('.hide').removeClass('hide');
        },

        selectEvent: function (elt) {
            var event = $(elt).data('event');
            var data = FestivalLib.addAntiForgeryToken({ id: event.Event.Id });
            ajaxSelectEvent(data);
        }
    };


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
        FestivalLib.showInfoModal('Server Error', parseResponse(response));
    }

})();

$(document).ready(function () {
    EventsPage.init();
}); 
