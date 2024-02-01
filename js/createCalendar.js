var date = new Date();

function createMonth() {
    var monthSectionElement = document.getElementById('monthSection');

    for (i = 1; i <= 12; i++) {
        var newMonthButton = document.createElement('button');

        newMonthButton.setAttribute('id', `monthButton${i}`);
        newMonthButton.setAttribute('class', 'monthButton');
        newMonthButton.setAttribute('onclick', 'createDayEvent(event)');
        newMonthButton.innerText = i;

        monthSectionElement.appendChild(newMonthButton);
    }
    document.getElementById('monthButton' + (date.getMonth() + 1).toString()).style.backgroundColor = "rgb(218, 227, 243)";
}

function createDay(month, isTargetNumEqualTodayMonth) {
    var mainElement = document.getElementById('main');
    var daySectionElement = document.getElementById('daySection');
    var newDaySectionDiv = document.createElement('div');

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

    if (daySectionElement) {
        daySectionElement.remove();
    }

    newDaySectionDiv.setAttribute('id', 'daySection');
    newDaySectionDiv.setAttribute('class', 'daySection');

    for (i = 1; i <= 35; i++) {
        var newDayButton = document.createElement('button');
        var newDayTextDiv = document.createElement('div');
        // var createScheduleDiv = document.createElement('div');

        newDayButton.setAttribute('class', 'day');

        // createScheduleDiv.setAttribute('class', 'scheduleCount');

        if (dayCount <= lastDay) {
            newDayButton.setAttribute('id', `day${i}`);
            newDayButton.setAttribute('data-value', `${i - 1}`);
            newDayButton.setAttribute('onclick', 'openModalEvent(event)')

            newDayTextDiv.setAttribute('class', 'dayText');
            newDayTextDiv.setAttribute('data-value', `${i - 1}`);
            newDayTextDiv.innerText = dayCount;

            dayCount++;
        } else {
            newDayTextDiv.innerText = "\n"
        }

        newDaySectionDiv.appendChild(newDayButton);

        newDayButton.appendChild(newDayTextDiv);
        // newDayButton.appendChild(createScheduleDiv);
    }
    mainElement.appendChild(newDaySectionDiv)

    if (isTargetNumEqualTodayMonth) {
        document.getElementById('day' + (date.getDate()).toString()).style.backgroundColor = "rgb(218, 227, 243)";
    }
}

function createDayEvent(e) {
    var monthSelectionElement = document.getElementById('monthSection');
    var buttonList = monthSelectionElement.getElementsByTagName('button');
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