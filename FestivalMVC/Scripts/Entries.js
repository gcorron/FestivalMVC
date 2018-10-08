"use strict";

var EntriesApp = (function () {
    var _composers;

    return {
        init: function () {
            //we need the required pieces and composers in local storage if not there already
            _composers = localStorage.getItem('Festival.Composers');
            if (_composers === null) {
                FestivalLib.getAjax('\Teacher\Composers',onGetComposers);
            }
        }
        };

    function onGetComposers(composers) {
        localStorage.setItem('Festival.Composers', JSON.stringify(composers));
        _composers = composers;
    }

        })();

    $(document).ready(function () {
        EntriesApp.init();
    });