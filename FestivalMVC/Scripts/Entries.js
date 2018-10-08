"use strict";

var EntriesApp = (function () {
    var _composers;
    var _requiredVersion;
    var _callbackFn;

    return {
        init: function (requiredVersion) {

            $('tr[name]').each(function (i, v) {
                FestivalLib.convertJqueryData(v, 'entry');
            });

            //we need the required composers in local storage if not there already
            _requiredVersion = requiredVersion;
            _composers = getFromStorage('Composers');
            if (_composers === null) {
                FestivalLib.getAjax('/Teacher/Composers', onGetComposers);
            }
        },

        editEntry: function (entryVM) {
            var entry = entryVM.EntryDetails;
            entry.StudentName = entryVM.StudentName;
            editEntryContinue.entry = entry;
            requiredPieces(entryVM.EntryBase.ClassAbbr, editEntryContinue);
        },

        onRequiredChange: function () {
            var $op = FestivalLib.$formElt('entry','RequiredPiece').find('option').filter(':selected');
            var ext = $op.data('extension');

            var $sel = FestivalLib.$formElt('entry', 'RequiredExtension');
            $sel.find('option').remove();
            $(new Option('Select ....', 0, true)).appendTo($sel).attr('disabled', true);

            if (ext !== 0) {
                for (var i = 1; ext > 0; ext = ext >>> 1, i++) {
                    if (ext & 1)
                        $sel.append(new Option('Mvt. ' + i, i));
                }
                $sel.cloest('div').show();
            }
            else {
                $sel.closest('div').hide();
            }
        }
    };

    function requiredPieces(classAbbr, callbackFn) {
        _callbackFn = callbackFn;
        var pieces = getFromStorage('Pieces.' + classAbbr);
        if (pieces === null)
            FestivalLib.getAjax('/Teacher/Pieces?ClassAbbr=' + classAbbr, onGetPieces);
        else
            callbackFn(pieces);
    }

    function editEntryContinue(pieces) {
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

        FestivalLib.popupForm('entry', editEntryContinue.entry, false);
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


})();

$(document).ready(function () {
    EntriesApp.init('1');
});