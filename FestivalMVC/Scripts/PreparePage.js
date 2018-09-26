"use strict";

var PreparePageApp = (function () {
    return {
        init: function () {
            PersonApp.setAssignFunction(changeParticipate);
        }
    };

    function changeParticipate (person, currentAssignment) {

        var id = person.Id;
        var participate = (currentAssignment == 0);

        $.ajax({
            type: "POST",
            url: "UpdateTeacherEventAssignment",
            data: FestivalLib.addAntiForgeryToken({ id, participate }),
            dataType: "json",
            success: onChangeParticipateSuccess,
            failure: FestivalLib.onAjaxFailure,
            error: FestivalLib.onAjaxFailure
        });
    }

    function onChangeParticipateSuccess(o) {
        PersonApp.changePersonAssigned(o.id, o.eventId);
    }
})();

$(document).ready(function () {
    PersonApp.init();
    PreparePageApp.init();
});