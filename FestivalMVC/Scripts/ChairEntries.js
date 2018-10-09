"use strict";

var ChairEntriesApp = (function () {

    return {
        init: function () {

        },

        approveEntries: function () {
            if (confirm('Approve all entries for this teacher. Are you sure?')) {
                var $sel = FestivalLib.$formElt('select', 'SelectedTeacher');
                var teacher = $sel.find('option:selected').val();
                FestivalLib.postAjax('/Chair/ApproveEntries', { teacher }, false, onApproveSuccess, FestivalLib.onAjaxFailure);
            }
        }
    };

    function onApproveSuccess() {
        location.reload();
    }

})();

$(document).ready(function () {
    ChairEntriesApp.init();
});