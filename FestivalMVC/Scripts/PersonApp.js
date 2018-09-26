"use strict";

var PersonApp = (function () {
    var assignFunction = null;

    return {
        init: function () {
            $('#people tr').each(function (i, v) {
                installPersonRow(v);
            });
            sortPersonTable();
        },

        canAssignPerson: function () {
            return assignFunction !== null;
        },

        assignPerson: function (person, currentAssignment) {
            if (!assignFunction)
                return;
            assignFunction(person, currentAssignment);
        },

        ChangePersonAssigned: function (personId, LocationId) {

            function toggleStar(icon, appear) {
                $(personRowSelector(personId)).find('span').toggleClass(icon, appear);
            }

            var star = 'glyphicon-star';
            $(personRowSelector(personId)).attr('data-location', LocationId);
            toggleStar(star + '-empty', LocationId == 0);
            toggleStar(star, LocationId > 0);
        },

        editPerson: function (person, canDelete) {
            populatePersonForm(person);
            $('.no-new').hide();
            $('#submitError').hide();

            if (person.Id !== 0) {
                $('.no-new').show();
            }

            if (canDelete) {
                $('#deleteButton').removeAttr('disabled');
            }
            else {
                $('#deleteButton').attr('disabled', 'disabled');
            }

            $('#instrumentGroup').hide();
            if ($('#RoleType').val() === 'E') {
                $('#instrumentGroup').show();
            }
            $("#modalEdit").modal();
        },

        deletePerson: function () {
            if (confirm('Delete, are you sure?')) {
                $.ajax({
                    type: "POST",
                    url: "Admin/DeletePerson",
                    data: CollectFormData(),
                    dataType: "json",
                    success: onDeletePersonSuccess,
                    failure: onUpdatePersonFailure,
                    error: onUpdatePersonFailure
                });
            }
        },

        setAssignFunction: function (fn) {
            assignFunction = fn; // if null then it won't be called
        },

        addPerson: function () {
            var person = new Person();
            PersonApp.editPerson(person, 0);
        },

        updatePerson: function () {
            if (!$('#personForm').valid()) {
                showEditError('Attention', 'Please make corrections.');
                return;
            }
            updatePersonAjax();
        }

    };

    function updatePersonAjax() {
        $.ajax({
            type: "POST",
            url: "Admin/UpdatePerson",
            data: CollectFormData(),
            dataType: "html",
            success: onUpdatePersonSuccess,
            failure: onUpdatePersonFailure,
            error: onUpdatePersonFailure
        });
    }
    
    function CollectFormData() {
        var name;
        var person = {};
        $('#personForm .form-control').each(function (i, control) {
            name = control.getAttribute('name');
            if (control.type === 'checkbox') {
                person[name] = control.checked;
            }
            else {
                person[name] = $.trim(control.value);
            }
        });
        var assignedToLocation = $('#personForm').data('assignedToLocation') || 0;
        return FestivalLib.addAntiForgeryToken({ person: person, assignedToLocation: assignedToLocation });
    }

    function onUpdatePersonSuccess(html) {

    var removePersonId = $('#Id').val();
    $(personRowSelector(removePersonId)).remove(); //remove previous row for person if it exists

    var newRow = $(html)[0];
    var person = installPersonRow(newRow);

    $('#people').append(newRow);
    sortPersonTable();
    //now update the person's name in the location table, if assigned to one
    if (person.locationId) {
        var row = $('#locations tr[name="' + locationId + '"]')[0];
        row.children[1].innerText = person.FullName;
    }

    $('#modalEdit').modal('hide');
}

function onDeletePersonSuccess() {
    var removePersonId = $('#Id').val();
    $(personRowSelector(removePersonId)).remove(); //remove previous row for person
    $('#modalEdit').modal('hide');
}

function onUpdatePersonFailure(response) {
    showEditError('Server Error', FestivalLib.parseResponse(response));
}


//DOM functions
function sortPersonTable() {
    var table, rows, switching, i, shouldSwitch;
    var personx, persony, compared;
    table = document.getElementById("people");
    switching = true;
    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 0; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            personx = $(rows[i]).data('person');
            persony = $(rows[i + 1]).data('person');
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

function installPersonRow(v) {
    var o = JSON.parse($(v).attr('data-person'));
    $(v).data('person', o);
    $(v).find('[data-toggle="popover"]').
        popover({
            title: 'Contact',
            trigger: 'hover',
            content: o.Email + '  ph: ' + o.Phone
        });
    $(v).removeAttr('data-person');
    var p = JSON.parse($(v).attr('data-location'));
    $(v).data('location', p);
    $(v).removeAttr('data-location');
    return o; //return the data
}

function personRowSelector(id) {
    return '#people >tr[name="' + id + '"]';
}

function populatePersonForm(person) {
    var name;
    $('#personForm .form-control').each(function (i, control) {
        name = control.getAttribute('name');
        if (control.type === 'checkbox') {
            control.checked = person[name];
        }
        else {
            control.value = (person[name]);
        }
    });
    $('#personForm').data('assignedToLocation', person.AssignedToLocation); //needed for the new table row partial view being created on the server
}

function showEditError(prompt, message) {
    $('#submitError span').text(message);
    $('#submitError >strong').text(prompt + '  ');
    $('#submitError').show();
}

//constructor for new person
function Person() {
    this.FirstName = '';
    this.LastName = '';
    this.Id = 0;
    this.Email = '';
    this.Phone = '';
    this.Available = true;
    this.Instrument = '';
}



}) ();