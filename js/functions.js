var keepScheduleSectionId = "";
var keepDivScheduleId = "";
var keepHiddenScheduleId = "";

function createOption(hourSelectId, minuteSelectId) {
    var hourSelect = document.getElementById(hourSelectId);
    var minuteSelect = document.getElementById(minuteSelectId);

    for (i = 1; i <= 23; i++) {
        var createOption = document.createElement('option');

        createOption.setAttribute('value', `${i}`);
        createOption.innerText = i;

        hourSelect.appendChild(createOption);
    }
    for (i = 1; i <= 59; i++) {
        var createOption = document.createElement('option');

        createOption.setAttribute('value', `${i}`);
        createOption.innerText = i;

        minuteSelect.appendChild(createOption);
    }
}

function modalCloseEvent() {
    document.getElementById('modal').style.display = "none";
}

function modifyEvent(e) {
    keepDivScheduleId = document.getElementById('divSchedule');
    keepHiddenScheduleId = document.getElementById('hiddenSchedule');

    keepScheduleSectionId = e.target.parentElement;

    keepDivScheduleId.style.display = "none";
    keepHiddenScheduleId.style.display = "flex";

    createOption('modifyHourSelect', 'modifyMinuteSelect');
}