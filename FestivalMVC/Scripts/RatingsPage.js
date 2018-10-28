
"use strict";

var RatingApp = (function () {
    return {

        init: function () {
            $('#students tr[name]').each(function(i,tr) {
                FestivalLib.convertJqueryData(tr, 'rating');
            });

            FestivalLib.initAjaxCursor();
            FestivalLib.initPopupForm('rating');
        },

        editRating: function (elt) {
            var rating = $(elt).data('rating');
            FestivalLib.popupForm('rating', rating, false);
        },

        updateRating: function () {
            var rating = {};
            rating.Id = FestivalLib.$formElt('rating', 'Id').val();
            rating.AwardRating = FestivalLib.$formElt('rating', 'AwardRating').val();
            FestivalLib.postAjax('/Chair/UpdateAwardRating', rating, false, onUpdateRatingSuccess, onUpdateRatingFail);
        },

        complete: function () {
            var $td = $('#ratings td[name="awardRating"]:contains("-")');
            if ($td.length > 0) {
                FestivalLib.showInfoModal('Reminder', 'All students must be given a rating before the event can be designated Complete.');
                return;
            }
            if (!confirm('Designate this event as complete?'))
                return;
            FestivalLib.postAjax('/Chair/UpdateEventCompleted', {}, false, function (url) { window.location = url; }, FestivalLib.onAjaxFailure);
        }
    };

    function onUpdateRatingSuccess(rating) {
        var $tr = FestivalLib.$tableRow('ratings', rating.Id);
        var ratingData = $tr.data('rating');
        ratingData.AwardRating = rating.AwardRating;
        $tr.data('rating', ratingData);
        $tr.find('[name=awardRating]').text(rating.AwardRating);
        $('#ratingModal').modal('hide');
    }

    function onUpdateRatingFail(response) {
        FestivalLib.ajaxFormFailure('schedule', response)
    }


})();

$(document).ready(function () {
    RatingApp.init();
});