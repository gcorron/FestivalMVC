"use strict";

var RegisterApp = (function () {
    return {
        init: function () {
            $('#students tr').find('[rowspan]:first-child').each(function (i,v) {
                FestivalLib.convertJqueryData(v,'student');
            });
            $('[data-toggle="popover"]').popover();

        },
        removeStudent: function () {
            if (!confirm("Remove student from your roles?"))
                return;
            FestivalLib.postAjax('/Teacher/RemoveStudent', 'student', true, onRemoveStudentSuccess, onStudentFormFail);
        },

        registerStudent: function (student) {
            FestivalLib.popupForm('register', student);
        },

        editStudent: function (student) {
            var canDelete;
            if (student == null) {
                student = new Student();
                canDelete = false;
            }
            else {
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

    function onRemoveStudentSuccess() {
        var removeId = $formElt('student', 'Id').val();
        var $removeElt = $('#students tr[name="' + removeId + '"]').nextUntil('[name]').addBack();
        $removeElt.remove();
        $('#studentModal').modal('hide');
    }

    function onUpdateStudentSuccess(html) {

        var $elt, $elt2;
        var removeId = $formElt('student', 'Id').val();

        $elt = $(html);
        var student=FestivalLib.convertJqueryData($elt[0], 'student');

        if (removeId === "0") {
            $elt2 = $('<tr name="' + student.Id + '">' + '<td rowspan="2"></td>' + '<td></td>'.repeat(2) + '<tr></tr>' + '<td></td>'.repeat(2));
            $removetd = $elt2.find('td[rowspan]');
            $removetd.replaceWith($elt);
            $elt2.appendTo('#students');
        }
        else {
            var $removetd = $('#students tr[name="' + removeId + '"]').find('td[rowspan]');
            //patch-in existing CanDelete property

            student = $removetd.data('student');
            var canDelete = student.CanDelete;

            student = $elt.data('student');
            student.CanDelete = canDelete;
            $elt.data('student', student);

            $removetd.replaceWith($elt);
        }

        FestivalLib.sortTableForPerson('student');

        $('#studentModal').modal('hide');
    }

    function onStudentFormFail(response) {
        FestivalLib.ajaxFormFailure('student', response);
    }

    function $formElt(formName, eltName) {
        return $('#' + formName + 'Form [name="' + eltName + '"]');
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