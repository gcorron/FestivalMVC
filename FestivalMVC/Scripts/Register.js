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
                            param: [Date.now()],
                        }

                    },
                }
            });

            if (!$('#studentForm').valid()) {
                return;
            }

            function updatePersonAjax() {
                $.ajax({
                    type: "POST",
                    url: "UpdateStudent",
                    data: FestivalLib.collectFormData('student'),
                    dataType: "html",
                    success: onUpdateStudentSuccess,
                    failure: FestivalLib.onAjaxFailure,
                    error: FestivalLib.onAjaxFailure
                });
            }
        }
    };

    function onUpdateStudentSuccess(html) {

        var removeId = $('#studentForm [name=Id]').val();
        if (removeId != 0)
            $('#students td').remove('name = [' + removeId + ']');

        var tr = $(html)[0];
        var student = FestivalLib.convertJqueryData(tr, 'student');

        $('#students').append(tr);

        FestivalLib.sortTableForPerson('student');

        $('#studentModal').modal('hide');
    }

    function Student() {
        this.Id = 0;
        this.FirstName = null;
        this.LastName = null;
        this.BirthDate = null;
        this.Phone = null;
    }

})();