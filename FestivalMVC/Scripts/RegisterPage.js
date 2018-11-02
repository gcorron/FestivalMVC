"use strict";

var RegisterApp = (function () {
    var _classTypes;
    return {
        init: function () {

            FestivalLib.initAjaxCursor();
            FestivalLib.initPopupForm('student');

            $('#students tr[name]').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'register');
                FestivalLib.convertJqueryData($(v).find('div[data-student]')[0], 'student');
            });
            _classTypes = FestivalLib.convertJqueryData('table[data-classTypes]', 'classTypes');
            $('[data-toggle="popover"]').popover();

            //remove any register buttons and student links where they can't register
            if ($('#registerForm').length === 0) {
                $('#students a.btn').remove();
                $('#students a[name="studentName"]').contents().unwrap();
            }
            else {
                var register;
                $('#students tr[name]').each(function (i, v) {
                    register = $(v).data('register');
                    if (register.length === _classTypes.length && register.every(function (r) {
                        return r.Status !== '-';
                    })) {
                        $(v).find('a.btn').remove();
                    }
                });
            }


        },
        removeStudent: function () {
            if (!confirm("Remove student from your roles?"))
                return;
            FestivalLib.postAjax('/Teacher/RemoveStudent', 'student', true, onRemoveStudentSuccess, onStudentFormFail);
        },

        registerStudent: function (elt) {
            var newRegister = $({});
            var register = $(elt).closest('tr').data('register');
            var student = $(elt).closest('div').data('student');
            newRegister.FullName = student.FullName;
            newRegister.Student = student.Student.Id;

            var fieldName;

            //default settings for select controls
            for (var i = 0; i < _classTypes.length; i++) {
                fieldName = 'ClassAbbr' + _classTypes.charAt(i);
                newRegister[fieldName] = '';
            }
            $('#register select').attr('disabled', false);
            //set fields to any previous registrations
            for (i = 0; i < register.length; i++) {
                fieldName = 'ClassAbbr' + register[i].ClassType;
                newRegister[fieldName] = register[i].ClassAbbr;
                FestivalLib.$formElt('register', fieldName).attr('disabled', register[i].Status !== '-');
            }
            FestivalLib.popupForm('register', newRegister, false);
        },

        editStudent: function (student) {
            if (student === null) {
                student = new Student();
                var canDelete = false;
            }
            else {
                student = student.Student; //student data contained in ViewModel
                var register = FestivalLib.$tableRow('students', student.Id).data('register');
                if (register.length === 0)
                    canDelete = true;
            }
            FestivalLib.popupForm('student', student, canDelete);
        },

        updateStudent: function () {
            jQuery.validator.addMethod("beforeDate", function (value, element, params) {
                return this.optional(element) || value < params[0];
            }, jQuery.validator.format("Date must be before today."));

            jQuery.validator.addMethod("afterDate", function (value, element, params) {
                return this.optional(element) || value > params[0];
            }, jQuery.validator.format("Date is out of range."));


            $('#studentForm').validate({
                rules: {
                    BirthDate: {
                        required: true,
                        beforeDate: {
                            param: [new Date(Date.now()).toISOString()]
                        },
                        afterDate: {
                            param: [new Date(1910, 1, 1).toISOString()]
                        }
                    }
                }
            });

    if (!$('#studentForm').valid()) {
        return;
    }
    FestivalLib.postAjax('/Teacher/UpdateStudent', 'student', true, onUpdateStudentSuccess, onStudentFormFail);
},

    updateEntry: function (elt) {
        FestivalLib.formErrorDiv('register').hide();
        var register = {};
        register.Student = FestivalLib.$formElt('register', 'Student').val();
        register.ClassType = elt.name.slice(-1);
        register.ClassAbbr = elt.value || '';
        FestivalLib.postAjax('/Teacher/UpdateEntry', register, false, onUpdateEntrySuccess, onEntryFormFail);
    },

payRegistration: function () {
    FestivalLib.postAjax('/Teacher/PayRegistration', { amountDue: 0.00 }, false, onPayRegistrationSuccess, FestivalLib.onAjaxFailure);
}
    };

function updateStudentCount() {
    $('#totalStudents').text($('#students tr[name]').length);
}

function onRemoveStudentSuccess() {
    var removeId = FestivalLib.$formElt('student', 'Id').val();
    var $removeElt = $('#students tr[name="' + removeId + '"]').nextUntil('[name]').addBack();
    $removeElt.remove();
    updateStudentCount();
    $('#studentModal').modal('hide');
}

function onUpdateStudentSuccess(html) {

    var $elt, $elt2;
    var removeId = FestivalLib.$formElt('student', 'Id').val();

    $elt = $(html);

    if (removeId === "0") { //server returns the whole row for new student
        FestivalLib.convertJqueryData($elt[0], 'register');
        FestivalLib.convertJqueryData($elt.find('div[data-student]')[0], 'student');
        $elt.appendTo('#students');
        updateStudentCount();
    }
    else {
        FestivalLib.convertJqueryData($elt[0], 'student');
        var $tr = $('#students tr[name="' + removeId + '"]');
        var $removediv = $tr.find('div[name="student"]');
        var canRegister = true;
        var register = $tr.data('register');
        if (register.length === _classTypes.length)
            canRegister = $tr.data('register').some(function (reg) {
                return reg.Status === '-';
            });

        if (!canRegister)
            $elt.find('a.btn').remove();
        $removediv.replaceWith($elt);
    }

    FestivalLib.sortTableForPerson('student');

    $('#studentModal').modal('hide');
}

function onUpdateEntrySuccess(register) {
    var name = register.ClassType + register.Student;
    var $span = $('#students td[name="' + name + '"]').find('span');
    $span.text(register.ClassAbbr);
    //upate data
    var $tr = FestivalLib.$tableRow('students',register.Student);
    var registered = $tr.data('register');

    var updated = false;
    for (var i = 0; i < registered.length; i++) {
        if (registered[i].ClassType === register.ClassType) {
            registered[i].ClassAbbr = register.ClassAbbr;
            registered[i].Status = '-';
            updated = true;
        }
    }
    if (!updated) {
        i = registered.length;
        register.Status = '-';
        registered[i] = register;
    }

    $tr.data('register', registered);

}

function onStudentFormFail(response) {
    FestivalLib.ajaxFormFailure('student', response);
}

function onEntryFormFail(response) {
    FestivalLib.ajaxFormFailure('register', response);
}

function onPayRegistrationSuccess(payreg) {
    if (payreg.Message === '?') {
        if (confirm('Process payment of $' + payreg.AmountDue + ' for ' + payreg.Entries + ' entries?')) {
            FestivalLib.postAjax('/Teacher/PayRegistration', { amountDue: payreg.AmountDue }, false, onPayRegistrationSuccess, FestivalLib.onAjaxFailure);
        }
    }
    else {
        $('#infoModal').on('click', '.btn, .close', function () {
            window.location.reload();
        });

        FestivalLib.showInfoModal('Payment Transaction', payreg.Message);

    }
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

}) ();

$(document).ready(function () {
    RegisterApp.init();
});