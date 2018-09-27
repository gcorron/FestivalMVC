"use strict";

var FestivalLib = (function () {

    return {

        parseResponse: function (response) {
            var message;

            if (response.responseJSON && response.responseJSON.Message)
                return response.responseJSON.Message;

            message = response.d || response.responseText;

            if (message == null)
                return 'No details available';

            try {
                return JSON.parse(message);
            }
            catch (e) {
                return message;
            }
        },

        //form routines expect form to look like this (formNamePart = 'judge')

        //  <form id="judgeForm">
        //      < div class="modal fade" id = "judgeModal" role = "dialog" >
        //          <div class="modal-dialog modal-sm">

        //and to have a div for reporting errors, like this:

        //  <div class="alert alert-danger" name="submitError">
        //      < strong > Server error! </strong > <span></span>
        //  </div >

        //and each element in the form will have class="form-control"

        collectFormData: function (formNamePart, addAntiForgery) {
            var name;
            var o = {};
            $('#' + formNamePart + 'Form .form-control').each(function (i, control) {
                name = control.getAttribute('name');
                if (control.type === 'checkbox') {
                    o[name] = control.checked;
                }
                else {
                    o[name] = $.trim(control.value);
                }
            });
            if (addAntiForgery)
                return FestivalLib.addAntiForgeryToken(o);
            else
                return o;
        },

        //pass a string like '#personForm' and the object with the data
        populateForm(formNamePart,o) {
            var name;
            $('#' + formNamePart + 'Form .form-control').each(function (i, control) {
                name = control.getAttribute('name');
                if (control.type === 'checkbox') {
                    control.checked = o[name];
                }
                else {
                    control.value = (o[name]);
                }
            });
        },
        popupForm(formNamePart, o) {
            FestivalLib.populateForm(formNamePart, o);
            $(formErrorDiv(formNamePart)).hide();
            $('#' + formNamePart + 'Modal').modal();
        },

        addAntiForgeryToken: function (data) {
            data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
            return data;
        },

        showInfoModal: function (heading, message) {
            $('#infoModal .modal-header h4').text(heading);
            $('#infoModal .modal-body p').text(message);
            $("#infoModal").modal();
        },

        onAjaxFailure: function (response) {
            FestivalLib.showInfoModal('Server Error', FestivalLib.parseResponse(response));
        },

        ajaxFormFailure: function (formNamePart,response) {
            var div = formErrorDiv(formNamePart);
            var span = $(div).find('span');
            $(span).text(FestivalLib.parseResponse(response));
            $(div).show();
        },

        spanIcon: function (icon) {
            return '<span class="' + icon + '"></span>';
        }
    };

    function formErrorDiv(formNamePart) {
        return $('#' + formNamePart + 'Form div[name=submitError]')[0];
    }
})();