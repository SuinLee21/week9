var date = new Date();

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
    document.getElementById('monthButton' + (date.getMonth() + 1).toString()).style.backgroundColor = "rgb(218, 227, 243)";
}

function createDay(month, isTargetNumEqualTodayMonth) {
    var mainId = document.getElementById('main');
    var daySectionId = document.getElementById('daySection');
    var createDivParent = document.createElement('div');

    var thirtyOneList = [1, 3, 5, 7, 8, 10, 12];
    var thirtyList = [4, 6, 9, 11];
    var dayCount = 1;
    var lastDay = 0;

    if (thirtyOneList.includes(month)) {
        lastDay = 31;
    } else if (thirtyList.includes(month)) {
        lastDay = 30;
    } else {
        lastDay = 28;
    }

    if (daySectionId) {
        daySectionId.remove();
    }

    createDivParent.setAttribute('id', 'daySection');
    createDivParent.setAttribute('class', 'daySection');

    for (i = 1; i <= 35; i++) {
        var createButtonChild = document.createElement('button');
        var createTextDiv = document.createElement('div');
        // var createScheduleDiv = document.createElement('div');

        createButtonChild.setAttribute('class', 'day');

        // createScheduleDiv.setAttribute('class', 'scheduleCount');

        if (dayCount <= lastDay) {
            createButtonChild.setAttribute('id', `day${i}`);
            createButtonChild.setAttribute('data-value', `${i - 1}`);
            createButtonChild.setAttribute('onclick', 'openModalEvent(event)')

            createTextDiv.setAttribute('class', 'dayText');
            createTextDiv.setAttribute('data-value', `${i - 1}`);
            createTextDiv.innerText = dayCount;

            dayCount++;
        } else {
            createTextDiv.innerText = "\n"
        }

        createDivParent.appendChild(createButtonChild);

        createButtonChild.appendChild(createTextDiv);
        // createButtonChild.appendChild(createScheduleDiv);
    }
    mainId.appendChild(createDivParent)

    if (isTargetNumEqualTodayMonth) {
        document.getElementById('day' + (date.getDate()).toString()).style.backgroundColor = "rgb(218, 227, 243)";
    }
}

function createDayEvent(e) {
    var monthSelectionId = document.getElementById('monthSection');
    var buttonList = monthSelectionId.getElementsByTagName('button');
    var targetNum = parseInt(e.target.innerText);
    var isTargetNumEqualTodayMonth = false;

    for (i = 0; i < 12; i++) {
        buttonList[i].style.backgroundColor = "white";
    }
    e.target.style.backgroundColor = "rgb(218, 227, 243)";

    if (targetNum === date.getMonth() + 1) {
        isTargetNumEqualTodayMonth = true;
    }

    createDay(targetNum, isTargetNumEqualTodayMonth);
}

createMonth();
createDay(date.getMonth() + 1, false);