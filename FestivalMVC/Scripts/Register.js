"use strict";

var RegisterApp = (function () {
    return {
        editStudent: function (student, isRegistered) {
            if (student == null)
                student = new Student();

            FestivalLib.popupForm('student', student, false);
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

        var newelt = $(html)[0];
        var student = FestivalLib.convertJqueryData(newelt, 'student');

        $('#students').append(newRow);

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