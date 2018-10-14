"use strict";

var PreparePageApp = (function () {
    return {
        init: function () {
            FestivalLib.initAjaxCursor();
            PersonApp.setAssignFunction(changeParticipate);
        },

        editJudge: function (elt) {

            var judge;
            if (elt)
                judge = $(elt).data('judge');
            else
                judge = new Judge();

            FestivalLib.popupForm('judge',judge,judge.Id !== 0);
        },

        deleteJudge: function () {
            var judge = FestivalLib.collectFormData('judge');
            if (!confirm('Delete ' + judge.Name + '?'))
                return;
            judge.Id = -(judge.Id);
            FestivalLib.postAjax('UpdateJudge', judge, true, onUpdateJudgeSuccess, onUpdateJudgeFailure);
        },

        updateJudge: function () {
            FestivalLib.postAjax('UpdateJudge', 'judge', true, onUpdateJudgeSuccess, onUpdateJudgeFailure);
        }
    };

    function changeParticipate(person, currentAssignment) {

        var id = person.Id;
        var participate = (currentAssignment == 0);
        FestivalLib.postAjax('UpdateTeacherEventAssignment', { id, participate }, false, onChangeParticipateSuccess, null);
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