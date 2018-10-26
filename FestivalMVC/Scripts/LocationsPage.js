"use strict";

var LocationsApp = (function () {


    return {

        init: function () {
            FestivalLib.initAjaxCursor();
            $('[data-toggle="popover"]').popover();

            $('#locations tr').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'location');
            });
        },

        editLocation: function (elt) {
            if (elt === null) {
                var location = {};
                location.Id = 0;
                location.LocationName = "";
            }
            else {
                location = $(elt).data('location');
            }
            FestivalLib.popupForm('location', location);
        },

        updateLocation: function () {
            if (!$('#locationForm').valid()) {
                return;
            }
            FestivalLib.postAjax('/Admin/UpdateLocationName', 'location', true, onUpdateLocationSuccess,null);
        },

        deleteLocation: function () {
            if (!confirm("Delete this location, are you sure?"))
                return;
            FestivalLib.postAjax('/Admin/DeleteLocation', 'location', false, onDeleteLocationSuccess, null);
        }


    };

    function onDeleteLocationSuccess(id) {
        var $tr = FestivalLib.$tableRow('locations', id);
        $tr.remove();
        $('#locationModal').modal('hide');
    }

    function onUpdateLocationSuccess(html) {
        var tr = $(html)[0];
        var location = FestivalLib.convertJqueryData(tr, 'location');
        var $oldtr = FestivalLib.$tableRow('locations', location.Id);
        if ($oldtr.length === 0) {
            $('#locations').append(tr);
        }
        else {
            $oldtr[0].parentNode.replaceChild(tr, $oldtr[0]);
        }
        $('#locationModal').modal('hide');
    }

    function onUpdateFailure(response) {
        FestivalLib.ajaxFormFailure('location', response);
    }


})();

$(document).ready(function () {
    LocationsApp.init();
});