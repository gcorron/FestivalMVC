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

        spanIcon: function (icon) {
            return '<span class="' + icon + '"></span>';
        }
    };
})();