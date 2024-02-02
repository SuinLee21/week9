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

function openModalEvent(e) {
    var daySelectionElement = document.getElementById('daySection');
    var buttonList = daySelectionElement.getElementsByTagName('button');

    document.getElementById('modal').style.display = "block";

    for (i = 0; i < 31; i++) {
        buttonList[i].style.backgroundColor = "white";
    }
    buttonList[e.target.dataset.value].style.backgroundColor = "rgb(218, 227, 243)";
}

function modalCloseEvent() {
    document.getElementById('modal').style.display = "none";
}

function modifyEvent(e) {
    var keepDivScheduleElement = document.getElementById('divSchedule');
    var keepHiddenScheduleElement = document.getElementById('hiddenSchedule');

    keepDivScheduleElement.style.display = "none";
    keepHiddenScheduleElement.style.display = "flex";

    createOption('modifyHourSelect', 'modifyMinuteSelect');
}