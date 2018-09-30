﻿"use strict";

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
                var o = JSON.parse(message);
                return o.Message;
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
            $('#' + formNamePart + 'Form .form-control, .form-check-input').each(function (i, control) {
                name = control.getAttribute('name');
                if (name.match(/[[\]]/)) {
                    if (control.checked) {
                        name = name.replace(/[[\]]/g, "");
                        if (!o[name])
                            o[name] = '';
                        o[name] = o[name] + control.value;
                    }
                }
                else if (control.type === 'checkbox') {
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

        //pass a string like 'person' and the object with the data
        populateForm: function (formNamePart, o) {
            var name;
            $('#' + formNamePart + 'Form .form-control, .form-check-input').each(function (i, control) {
                name = control.name;
                var isMulti = name.match(/[[\]]/);
                if (isMulti)
                    name = name.replace(/[[\]]/g, "");
                var val = o[name];

                if (isMulti) {
                    control.checked = val.indexOf(control.value) >= 0;
                }
                else if (control.type === 'checkbox') {
                    control.checked = val;
                }
                else if (val && control.type === 'date')
                    control.value = val.toISOString().split('T')[0];
                else {
                    control.value = val;
                }
            });
        },
        popupForm(formNamePart, o, canDelete) {
            FestivalLib.populateForm(formNamePart, o);
            $(formErrorDiv(formNamePart)).hide();
            $('#submitError').hide();

            if (canDelete)
                $('#deleteButton').show();
            else
                $('#deleteButton').hide();

            $('#' + formNamePart + 'Modal').modal();
        },

        addAntiForgeryToken: function (data) {
            data.__RequestVerificationToken = $('#__AjaxAntiForgeryForm input[name=__RequestVerificationToken]').val();
            return data;
        },

        initAjaxCursor: function () {
            $(document).ajaxStart(function () {
                document.body.style.cursor = 'wait';
            });

            $(document).ajaxStop(function () {
                document.body.style.cursor = 'default';
            });
        },

        showInfoModal: function (heading, message) {
            $('#infoModal .modal-header h4').text(heading);
            $('#infoModal .modal-body p').text(message);
            $("#infoModal").modal();
        },

        onAjaxFailure: function (response) {
            FestivalLib.showInfoModal('Server Error', FestivalLib.parseResponse(response));
        },

        ajaxFormFailure: function (formNamePart, response) {
            var div = formErrorDiv(formNamePart);
            var span = $(div).find('span');
            $(span).text(FestivalLib.parseResponse(response));
            $(div).show();
        },

        spanIcon: function (icon) {
            return '<span class="' + icon + '"></span>';
        },

        convertJqueryData(elt, name) {
            var o = JSON.parse($(elt).attr('data-' + name), dateTimeReviver);
            $(elt).data(name, o);
            $(elt).removeAttr('data-' + name);
            return o;
        },

        sortTableForPerson(rowName) {
            var table, rows, switching, i, shouldSwitch;
            var personx, persony, compared;
            table = document.getElementById(rowName + 's');
            switching = true;
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 0; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    personx = $(rows[i]).data(rowName);
                    persony = $(rows[i + 1]).data(rowName);
                    compared = compare(personx.LastName, persony.LastName);
                    if (compared === 0)
                        compared = compare(personx.FirstName, persony.FirstName);
                    if (compared > 0) {
                        shouldSwitch = true;
                        break;
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                }
            }
            function compare(x, y) {
                var cx = x.toLowerCase();
                var cy = y.toLowerCase();
                if (cx > cy)
                    return 1;
                if (cx < cy)
                    return -1;
                return 0;
            }
        }
    };

    function dateTimeReviver(key, value) {
        var a;
        if (typeof value === 'string') {
            a = /\/Date\((\d*)\)\//.exec(value);
            if (a) {
                return new Date(+a[1]);
            }
        }
        return value;
    }

    function formErrorDiv(formNamePart) {
        return $('#' + formNamePart + 'Form div[name=submitError]')[0];
    }
})();