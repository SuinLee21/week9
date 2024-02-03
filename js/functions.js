function yearMinusEvent() {
    var yearElement = document.getElementById('year');
    var yearValue = parseInt(yearElement.innerText) - 1;
    yearElement.innerText = yearValue;
}

function yearPlusEvent() {
    var yearElement = document.getElementById('year');
    var yearValue = parseInt(yearElement.innerText) + 1;
    yearElement.innerText = yearValue;
}

function modifyEvent(e) {
    var keepDivScheduleElement = document.getElementById('divSchedule');
    var keepHiddenScheduleElement = document.getElementById('hiddenSchedule');

    keepDivScheduleElement.style.display = "none";
    keepHiddenScheduleElement.style.display = "flex";
    e.target.style.display = "none";
    document.getElementById('delete').style.display = "none";

    createOption('modifyHourSelect', 'modifyMinuteSelect');
}
