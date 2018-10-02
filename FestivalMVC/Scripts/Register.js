"use strict";

var RegisterApp = (function () {
    return {
        init: function () {
            $('#students tr').find('[rowspan]:first-child').each(function (i,v) {
                FestivalLib.convertJqueryData(v,'student');
            });
        },
        editStudent: function (elt) {
            var canDelete;
            var student;
            if (elt == null) {
                student = new Student();
                canDelete = false;
            }
            else {
                student = $(elt).data('student');
                canDelete = student.CanDelete;
                student = student.Student; //student data contained in ViewModel
            }
            FestivalLib.popupForm('student', student, canDelete);
        },
        updateStudent: function () {
            jQuery.validator.addMethod("beforeDate", function (value, element, params) {
                return this.optional(element) || value < params[0];
            }, jQuery.validator.format("Date must be before today."));

            $('#studentForm').validate({
                rules: {
                    BirthDate: {
                        required: true,
                        beforeDate: {
                            param: [new Date(Date.now()).toISOString()],
                        }

                    },
                }
            });

            if (!$('#studentForm').valid()) {
                return;
            }
            FestivalLib.postAjax('/Teacher/UpdateStudent', 'student', true, onUpdateStudentSuccess, onStudentFormFail);
        }
    };

    function onUpdateStudentSuccess(html) {

        var $elt;

        var removeId = $formElt('student', 'Id').val();

        if (removeId !== 0) {
            $elt = $(html);
            FestivalLib.convertJqueryData($elt[0], 'student');

            var $removetd = $('#students tr[name="' + removeId + '"]').find('td [rowspan]');
            $removetd.replaceWith($elt);
        }
        else {
            html = '<tr name="' + student.Id + '">' + html + '<td></td>'.repeat(4);
            $elt = $(html);
            FestivalLib.convertJqueryData($elt.find('[rowspan]:first-child'), 'student');
            $('#students').append($elt);
        }

        FestivalLib.sortTableForPerson('student');

        $('#studentModal').modal('hide');
    }

    function onStudentFormFail(response) {
        FestivalLib.ajaxFormFailure('student', response);
    }

    function $formElt(eltName) {
        return $('#personForm [name="' + eltName + '"]');
    }

    function Student() {
        this.Id = 0;
        this.Teacher = 0;
        this.Instrument = '-';
        this.FirstName = null;
        this.LastName = null;
        this.BirthDate = null;
        this.Phone = null;
    }

})();

$(document).ready(function () {
    RegisterApp.init(true);
});