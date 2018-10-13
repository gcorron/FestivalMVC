"use strict";

var FestivalLib = (function () {

    return {

        parseObject: function (o) {
            return JSON.parse(o, dateTimeReviver);
        },

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
            $('#' + formNamePart + 'Form').find('.form-control, .form-check-input').each(function (i, control) {
                name = control.name;
                var isMulti = name.match(/[[\]]/);
                if (isMulti)
                    name = name.replace(/[[\]]/g, "");

                if (name in o) {

                    var val = o[name];
                    if (val === null || val === undefined)
                        val= '';

                    if (control.type === 'checkbox') {
                        if (isMulti)
                            control.checked = val.indexOf(control.value) >= 0;
                        else
                            control.checked = val;
                    }
                    else if (val && control.type === 'date') {
                        control.value = val.toISOString().split('T')[0];
                    }
                    else {
                        control.value = val;
                    }
                }

            });
        },

        popupForm(formNamePart, o, canDelete, optionalFields) {
            FestivalLib.populateForm(formNamePart, o);
            $(FestivalLib.formErrorDiv(formNamePart)).hide();

            FestivalLib.$formElt(formNamePart, 'submitError').hide();

            if (canDelete)
                FestivalLib.$formElt(formNamePart, 'deleteButton').show();
            else
                FestivalLib.$formElt(formNamePart, 'deleteButton').hide();

            if (typeof optionalFields !== 'undefined') {
                if (optionalFields) {
                    $('#' + formNamePart + 'Form .optional-show').show();
                    $('#' + formNamePart + 'Form .optional-hide').hide();
                }
                else {
                    $('#' + formNamePart + 'Form .optional-show').hide();
                    $('#' + formNamePart + 'Form .optional-hide').show();
                }
            }
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

        getAjax: function (url, successFn, failFn) {
            if (failFn == null)
                failFn = FestivalLib.onAjaxFailure;
            $.ajax({
                type: "GET",
                url: url,
                dataType: "json",
                success: successFn,
                failure: failFn,
                error: failFn
            });
        },

        postAjax: function (url, data, expectsHtml, successFn, failFn) {
            if (failFn == null)
                failFn = FestivalLib.onAjaxFailure;
            if (typeof (data) === 'string' || data instanceof String)
                data = FestivalLib.collectFormData(data, true);
            else
                data = FestivalLib.addAntiForgeryToken(data);

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: expectsHtml ? "html" : "json",
                success: successFn,
                failure: failFn,
                error: failFn
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
            var div = FestivalLib.formErrorDiv(formNamePart);
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
            var isStudent = false;
            var table, rows, switching, i, shouldSwitch;
            var personx, persony, compared;

            isStudent = (rowName === 'student');
            table = document.getElementById(rowName + 's');
            var rowInc = Number($(table).find('tr [rowspan]').attr('rowspan') || 1);

            switching = true;
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 0; i < (rows.length - rowInc); i += rowInc) {
                    shouldSwitch = false;
                    personx = getRowData(i);
                    persony = getRowData(i + rowInc);
                    compared = compare(personx.LastName, persony.LastName);
                    if (compared === 0)
                        compared = compare(personx.FirstName, persony.FirstName);
                    if (compared > 0) {
                        shouldSwitch = true;
                        break;
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + rowInc], rows[i]);
                    if (isStudent)
                        rows[i + 1].parentNode.insertBefore(rows[i + 1 + rowInc], rows[i + 1]);
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
            function getRowData(rowNum) {
                if (isStudent) {
                    var temp = $(rows[rowNum]).find('div[name="student"]').data(rowName);
                    return temp.Student;
                }
                else
                    return $(rows[rowNum]).data(rowName);
            }
        },

        $tableRow: function (tableName, id) {
            return $((tableName === '*' ? '':'#' + tableName + ' ') + 'tr[name="' + id + '"]');
        },

        $formElt: function (formNamePart, name) {
            return $('#' + formNamePart + 'Form [name="' + name + '"]');
        },
        formErrorDiv: function (formNamePart) {
            return $('#' + formNamePart + 'Form div[name=submitError]');
        }
    };

    function dateTimeReviver(key, value) {
        var a;
        if (typeof value === 'string') {
            a = /\/Date\(([-]?\d*)\)\//.exec(value);
            if (a) {
                return new Date(+a[1]);
            }
        }
        return value;
    }

})();