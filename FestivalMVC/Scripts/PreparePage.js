"use strict";

var PreparePageApp = (function () {
    return {
        init: function () {
            PersonApp.setAssignFunction(changeParticipate);
        },

        editJudge: function (elt) {
            var judge = $(elt).data('judge');
            if (!judge) {
                judge = new Judge();
            }
            FestivalLib.popupForm('judge',judge);
        },

        deleteJudge: function () {
            var judge = FestivalLib.collectFormData('judge');
            if (!confirm('Delete ' + judge.Name + '?'))
                return;
            judge.Id = -(judge.Id);
            $.ajax({
                type: "POST",
                url: "UpdateJudge",
                data: FestivalLib.addAntiForgeryToken(judge),
                dataType: "html",
                success: onUpdateJudgeSuccess,
                failure: onUpdateJudgeFailure,
                error: onUpdateJudgeFailure
            });
        },

        updateJudge: function () {
            $.ajax({
                type: "POST",
                url: "UpdateJudge",
                data: FestivalLib.collectFormData('judge', true),
                dataType: "html",
                success: onUpdateJudgeSuccess,
                failure: onUpdateJudgeFailure,
                error: onUpdateJudgeFailure
            });
        }
    };

    function changeParticipate(person, currentAssignment) {

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

    function onUpdateJudgeSuccess(html) {
        //replace the whole judge list
        var replaceNode = $('#judges')[0];
        var newNode = $(html)[0];
        replaceNode.parentElement.replaceChild(newNode, replaceNode);
        $('#judgeModal').modal('hide');
    }

    function onUpdateJudgeFailure(response) {
        FestivalLib.ajaxFormFailure('judge', response);
    }

    function Judge() {
        this.Id = 0; //will be assigned by the server
        this.Name = '';
        this.Event = 0; //will be assigned by the server
    }

})();

$(document).ready(function () {
    PersonApp.init(true);
    PreparePageApp.init();
});