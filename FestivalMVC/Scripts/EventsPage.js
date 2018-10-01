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
            FestivalLib.postAjax("/Chair/Index", { id: event.Event.Id }, false, onAjaxSelectEventSuccess, null);
        }
    };

    function onAjaxSelectEventSuccess(response) {
        window.location = response.redirect;
    }

})();

$(document).ready(function () {
    EventsPage.init();
}); 
