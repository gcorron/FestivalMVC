"use strict";

var ScheduleApp = (function () {
    var _MS_PER_DAY = 1000 * 60 * 60 * 24;
    var _eventDate;
    return {

        init: function () {
            _eventDate = FestivalLib.convertJqueryData(FestivalLib.$formElt('schedule', 'StartDay')[0], 'eventDate');
            convertScheduleData();
        },

        addSchedule: function () {
            var schedule = {
                Id: 0, Minutes: 240, PrefHighLow: '*', ClassType: '*', StartTime: _eventDate
            };
            doEditSchedule(schedule);
        },

        editSchedule: function (elt) {
            var schedule = $(elt).data('schedule');
            doEditSchedule(schedule);
        },

        deleteSchedule: function (id) {
            if (confirm('Delete - are you sure?')) {
                id = FestivalLib.$formElt('schedule', 'Id').val();
                FestivalLib.postAjax('/Chair/DeleteSchedule', { id }, true, onUpdateScheduleSuccess, onUpdateScheduleFail);
            }
        },

        updateSchedule: function () {
            var schedule = FestivalLib.collectFormData('schedule', false);
            var time = FestivalLib.$formElt('schedule', 'StartDay').data('eventDate');
            time = new Date(time.getTime() + schedule.StartDay * 86400000);
            time.setHours(schedule.StartHour, schedule.StartMinute);
            schedule.StartTime = time.toISOString();
            delete schedule.StartDay;
            delete schedule.StartHour;
            delete schedule.StartMinute;
            FestivalLib.postAjax('/Chair/UpdateSchedule', schedule, true, onUpdateScheduleSuccess, onUpdateScheduleFail);
        }
    };

    function doEditSchedule(schedule) {
        // break down starttime to day, hour and minute
        schedule.StartDay = dateDiffInDays(_eventDate, schedule.StartTime);
        schedule.StartHour = schedule.StartTime.getHours();
        schedule.StartMinute = schedule.StartTime.getMinutes();

        var $sel = FestivalLib.$formElt('schedule', 'Judge');
        var $ops = $sel.children();
        if ($ops.length === 2) //if only one judge, select by default
            schedule.Judge = $($ops[1]).val();
        FestivalLib.popupForm('schedule', schedule, schedule.Id !== 0);

    }

    function onUpdateScheduleSuccess(html) {
        var tbody = $('#schedules')[0];
        tbody.parentNode.replaceChild($(html)[0], tbody);
        convertScheduleData();
        $('#scheduleModal').modal('hide');
    }

    function onUpdateScheduleFail(response) {
        FestivalLib.ajaxFormFailure('schedule', response)
    }

    function convertScheduleData() {
        $('#schedules tr[data-schedule]').each(function (i, elt) {
            FestivalLib.convertJqueryData(elt, 'schedule');
        });

    }


    // a and b are javascript Date objects
    function dateDiffInDays(a, b) {

        // Discard the time and time-zone information.
        var utc1 = Date.UTC(a.getFullYear(), a.getMonth(), a.getDate());
        var utc2 = Date.UTC(b.getFullYear(), b.getMonth(), b.getDate());

        return Math.floor((utc2 - utc1) / _MS_PER_DAY);
    }

})();

$(document).ready(function () {
    ScheduleApp.init();
});