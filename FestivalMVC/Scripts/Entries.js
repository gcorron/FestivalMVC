"use strict";

var EntriesApp = (function () {
    var _composers;
    var _requiredVersion;
    var _callbackFn;

    return {
        init: function (requiredVersion) { //version of required pieces database cached in local storage

            FestivalLib.initAjaxCursor();

            $('tr[name]').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'entry');
            });

            $('div.tab-pane').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'classType');
            });

            //we need the required composers in local storage if not there already
            _requiredVersion = requiredVersion;
            _composers = getFromStorage('Composers');
            if (_composers === null) {
                FestivalLib.getAjax('/Teacher/Composers', onGetComposers);
            }
        },

        editEntry: function (entryVM, classType) {
                var entry = entryVM.EntryDetails;
                entry.StudentName = entryVM.StudentName;
                editEntryContinue.entry = entry;
                editEntryContinue.optionalFields = !classType.RequiresChoicePiece;
                requiredPieces(entryVM.EntryBase.ClassAbbr, editEntryContinue);
        },

        onRequiredChange: function (extValue) {
            var $op = FestivalLib.$formElt('entry','RequiredPiece').find('option').filter(':selected');
            var ext = $op.data('extension');

            var $sel = FestivalLib.$formElt('entry', 'RequiredExtension');
            $sel.find('option').remove();
            $(new Option('Select ....', 0, true)).appendTo($sel).attr('disabled', true);

            if (ext) {
                for (var i = 1; ext > 0; ext = ext >>> 1, i++) {
                    if (ext & 1)
                        $sel.append(new Option('Mvt. ' + i, i));
                }
                $sel.closest('div').show();
            }
            else {
                $sel.closest('div').hide();
            }
            if (extValue)
                $sel.val(extValue);
        },

        updateEntry: function () {

            $('#entryForm').validate({
                errorClass: 'bg-danger',
                ignore: ":not(:visible)"
            });

            if (!$('#entryForm').valid()) {
                return;
            }

            $('#entryForm  .form-control').find(':not(:visible)').val("");
            FestivalLib.postAjax('/Teacher/UpdateEntryDetails', 'entry', false, onUpdateEntrySuccess, onUpdateEntryFail);
        },

        submitEntries: function () {
            if (allComplete()===false) {
                FestivalLib.showInfoModal('Attention','All fields are not complete for all entries!');
                return;
            }
            if (confirm('Once you submit these entries, you cannot go back and make changes. Are you sure?')) {
                FestivalLib.postAjax('/Teacher/SubmitEntries', {}, false, onSubmitSuccess, FestivalLib.onAjaxFailure);
            }
        },

        approveEntry: function (status) {
            var approve = {};
            approve.Id = FestivalLib.$formElt('entry','Id').val();
            approve.Status = status;
            approve.Notes = FestivalLib.$formElt('entry','Notes').val();
            FestivalLib.postAjax('/Chair/UpdateEntryStatus', approve, false, onApproveSuccess, onUpdateEntryFail);
        },

        approveEntries: function () {
            if (confirm('Approve all entries for this teacher. Are you sure?')) {
                var $sel = FestivalLib.$formElt('select', 'SelectedTeacher');
                var teacher = $sel.find('option:selected').val();
                FestivalLib.postAjax('/Chair/ApproveEntries', { teacher }, false, onSubmitSuccess, FestivalLib.onAjaxFailure);
            }
        }
    };

    function onApproveSuccess(approve) {

        var $tr = FestivalLib.$tableRow('*', approve.Id);
        var entryVM = $tr.data('entry');
        entryVM.EntryDetails.Notes = approve.Notes;
        entryVM.EntryBase.Status = approve.Status;
        $tr.data('entry', entryVM);

        updateLabelColor($tr, approve.Status);

        //update the notes in table
        $tr.find('td[name="notes"]').text(approve.Notes);


        $('#entryModal').modal('hide');
    }

    function onSubmitSuccess() {
        document.location.reload();
    }

    function allComplete() {
        var entry;
        var $tr = $('tr[name]');
        var ret = true;
        $tr.each(function (i, elt) {
            entry = $(elt).data('entry');
            if (!entry.EntryDetails.RequiredPiece) {
                ret = false;
                return false;
            }

            switch (entry.EntryBase.ClassType) {
                case 'C': //TODO: don't rely on constant, this is tricky
                    if (!entry.EntryDetails.Accompanist) {
                        ret = false;
                        return false;
                    }
                    break;
                case 'S':
                    if (!(entry.EntryDetails.ChoiceComposer && entry.EntryDetails.ChoicePiece)) {
                        ret = false;
                        return false;
                    }
                    break;
                default: //should never happen
            }
        });
        return ret;
    }

    function onUpdateEntrySuccess(entry) {
        var $tr = FestivalLib.$tableRow('*',entry.Id);

        var entryVM = $tr.data('entry');
        entryVM.EntryDetails = entry;
        var status = entryVM.EntryBase.Status;
        if (status === '?' || status === 'A') {
            status = 'R';
            entryVM.EntryBase.Status = status;
            updateLabelColor($tr, status);
        }
        $tr.data('entry', entryVM);

        //reconstruct required piece desc
        var pieces = getFromStorage('Pieces.' + entryVM.EntryBase.ClassAbbr);
        var piece = findPiece(entry.RequiredPiece);
        var pieceName = _composers[piece.Composer] + ': ' + piece.Composition;
        findTd('req').text(pieceName);

        //if choice piece, display that
        var $td = findTd('choice');
        if ($td.length > 0)
            $td.text(entry.ChoiceComposer + ': ' + entry.ChoicePiece);

        //if accomp, display that
        $td = findTd('acc');
        if ($td.length > 0)
            $td.text(entry.Accompanist);

        $td = findTd('notes');
        $td.text(entry.Notes);
        
        $('#entryModal').modal('hide');

        function findTd(name) {
            return $tr.find('td[name="' + name + '"]');
        }

        function findPiece(id) {
            for (var i = 0; i < pieces.length; i++) {
                if (pieces[i].Id === id)
                    return pieces[i];
            }
        }

    }

    function onUpdateEntryFail(response) {
        FestivalLib.ajaxFormFailure('entry',response);
    }

    function requiredPieces(classAbbr, callbackFn) {
        _callbackFn = callbackFn;
        var pieces = getFromStorage('Pieces.' + classAbbr);
        if (pieces === null)
            FestivalLib.getAjax('/Teacher/Pieces?ClassAbbr=' + classAbbr, onGetPieces);
        else
            callbackFn(pieces);
    }

    function editEntryContinue(pieces) {
        //populate the options for the required piece and extensions for each
        var $sel = FestivalLib.$formElt('entry', 'RequiredPiece');
        $sel.find('option').remove();
        $sel.append('<option value="" disabled selected hidden>Select ...</option>');

        var tmpAry = new Array();
        for (var i = 0; i < pieces.length; i++) {
            tmpAry[i] = new Array();
            tmpAry[i][0] = _composers[pieces[i].Composer] + ': ' + pieces[i].Composition;
            tmpAry[i][1] = pieces[i].Id;
            tmpAry[i][2] = pieces[i].Extension;
        }

        tmpAry.sort();
        for (i = 0; i < tmpAry.length; i++) {
            var op = new Option(tmpAry[i][0], tmpAry[i][1]);
            $(op).data('extension', tmpAry[i][2]);
            $sel.append(op);
        }

        FestivalLib.popupForm('entry', editEntryContinue.entry, false, editEntryContinue.optionalFields);
        EntriesApp.onRequiredChange(editEntryContinue.entry.RequiredExtension);

    }

    function onGetComposers(arr) {
        _composers = {};
        for (var i = 0; i < arr.length; i++) {
            _composers[arr[i].Id] = arr[i].Composer;
        }
        localStorage.setItem(storageName('Composers'), JSON.stringify(_composers));
    }

    function onGetPieces(pieces) {
        var classAbbr = pieces.classAbbr;
        pieces = pieces.pieces;
        localStorage.setItem(storageName('Pieces.' + classAbbr),JSON.stringify(pieces));
        _callbackFn(pieces);
    }

    function storageName(base) {
        return 'Festival.' + base + '.' + _requiredVersion;
    }

    function getFromStorage(base) {
        var str = localStorage.getItem(storageName(base));
        if (str === null)
            return null;
        return JSON.parse(str);
    }

    function updateLabelColor($tr,status) {
        //update the color of the label
        var labelType;
        switch (status) {
            case 'A': labelType = 'success'; break;
            case '?': labelType = 'danger'; break;
            case 'R': labelType = 'info';break
            default: labelType = 'default';
        }
        var elt = $tr.find('span.label')[0];
        elt.className = 'label label-fixed label-' + labelType;

    }

})();

$(document).ready(function () {
    EntriesApp.init('1');
});