var date = new Date();
var keepPreviousMonthId = "";

function createMonth() {
    var monthSectionId = document.getElementById('monthSection');

    for (i = 1; i <= 12; i++) {
        var createButton = document.createElement('button');

        createButton.setAttribute('id', `monthButton${i}`);
        createButton.setAttribute('class', 'monthButton');
        createButton.setAttribute('onclick', 'createDayEvent(event)');
        createButton.innerText = i;

        monthSectionId.appendChild(createButton);
    }
    keepPreviousMonthId = document.getElementById('monthButton' + String(date.getMonth() + 1));
    keepPreviousMonthId.style.backgroundColor = "rgb(218, 227, 243)";
}

function createDay(lastDay) {
    var mainId = document.getElementById('main');
    var daySectionId = document.getElementById('daySection');
    var createDivParent = document.createElement('div');
    var dayCount = 1;

    if (daySectionId) {
        daySectionId.remove();
    }

    createDivParent.setAttribute('id', 'daySection');
    createDivParent.setAttribute('class', 'daySection');

    for (i = 0; i < 35; i++) {
        var createDivChild = document.createElement('div');
        var createTextDiv = document.createElement('div');
        // var createScheduleDiv = document.createElement('div');

        createDivChild.setAttribute('id', `day${i}`);
        createDivChild.setAttribute('class', 'day');
        createDivChild.setAttribute('onclick', 'openModalEvent(event)')

        createTextDiv.setAttribute('class', 'dayText');
        // createScheduleDiv.setAttribute('class', 'scheduleCount');

        if (dayCount <= lastDay) {
            createTextDiv.innerText = dayCount;
            dayCount++;
        } else {
            createTextDiv.innerText = "\n"
        }

        createDivParent.appendChild(createDivChild);

        createDivChild.appendChild(createTextDiv);
        // createDivChild.appendChild(createScheduleDiv);
    }

    mainId.appendChild(createDivParent)
}

function getLastDay(month) {
    var thirtyOneList = [1, 3, 5, 7, 8, 10, 12];
    var thirtyList = [4, 6, 9, 11];
    var twentyEightList = [2];

    if (thirtyOneList.includes(month)) {
        createDay(31);
    } else if (thirtyList.includes(month)) {
        createDay(30);
    } else {
        createDay(28);
    }
}

function createDayEvent(e) {
    getLastDay(parseInt(e.target.innerText));

    if (e.target != keepPreviousMonthId) {
        keepPreviousMonthId.style.backgroundColor = "white";
        keepPreviousMonthId = e.target;
        e.target.style.backgroundColor = "rgb(218, 227, 243)";
    }
}

createMonth();
getLastDay(date.getMonth() + 1);