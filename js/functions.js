var keepPreviousDayId = document.getElementById('day' + String(date.getDate()));
var currentDateId = document.getElementById('currentDate');
var keepScheduleSectionId = "";
var keepDivScheduleId = "";
var keepHiddenScheduleId = "";
keepPreviousDayId.style.backgroundColor = "rgb(218, 227, 243)";
currentDateId.innerText = String(date.getFullYear()) + "." + String(date.getMonth() + 1) + "." + String(date.getDate());

function yearMinusEvent() {
    var year = document.getElementById('year');
    var yearValue = parseInt(year.innerText) - 1;
    year.innerText = yearValue;
}

function yearPlusEvent() {
    var year = document.getElementById('year');
    var yearValue = parseInt(year.innerText) + 1;
    year.innerText = yearValue;
}

function openModalEvent(e) {
    document.getElementById('modal').style.display = "block";

    if (e.target != keepPreviousDayId) {
        keepPreviousDayId.style.backgroundColor = "white";
        keepPreviousDayId = e.target;
        e.target.style.backgroundColor = "rgb(218, 227, 243)";
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