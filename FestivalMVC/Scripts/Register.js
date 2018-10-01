"use strict";

var RegisterApp = (function () {
    return {
        editStudent: function (student) {
            var canDelete;
            if (student == null) {
                student = new Student();
                canDelete = false;
            }
            else {
                canDelete = student.Enrolled;
                student = student.Student; //student data contained in ViewModel
            }
            FestivalLib.popupForm('student', student ,canDelete);
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

        var removeId = $formElt('student', 'Id').val();
        var $removeTr;

        if (removeId !== 0) {
            $removeTr = $('#students tr').find('name = [' + removeId + ']');
            $removeTr.remove();
        }

        var tr = $(html)[0];
        var student = FestivalLib.convertJqueryData(tr, 'student');
        if (removeId !== 0) { //replace enrollment flag from previously
            student.Enrolled = $removeTr.data('student').Enrolled;
            $(tr).data('student', student);
        }

        $('#students').append(tr);

        FestivalLib.sortTableForPerson('student');

        $('#studentModal').modal('hide');
    }

    function onStudentFormFail(response) {
        FestivalLib.ajaxFormFailure('student',response);
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