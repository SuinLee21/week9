var date = new Date();

function createYear() {
    var yearElement = document.getElementById('year');

    yearElement.innerText = date.getFullYear();
}

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

function createDay(month, isTargetNumEqualTodayMonth, scheduleDataList) {
    var year = document.getElementById('year').innerText;
    var mainElement = document.getElementById('main');
    var daySectionElement = document.getElementById('daySection');

    var newDaySectionDiv = document.createElement('div');

    var thirtyOneList = [1, 3, 5, 7, 8, 10, 12];
    var thirtyList = [4, 6, 9, 11];
    var dayCount = 1;
    var lastDay = 0;
    var scheduleCountList = [];
    var dateList = [];

    if (thirtyOneList.includes(month)) {
        lastDay = 31;
    } else if (thirtyList.includes(month)) {
        lastDay = 30;
    } else {
        lastDay = 28;
    }

    for (i = 0; i < lastDay; i++) {
        scheduleCountList.push(0);
    }
    for (i = 0; i < scheduleDataList.length; i++) {
        var yearAndMonth = scheduleDataList[i][4].substr(0, 6);
        if (yearAndMonth === `${year}0${month}` || yearAndMonth === `${year}${month}`) {
            dateList.push(scheduleDataList[i][4].substr(6, 2));
        }
    }
    for (i = 0; i < dateList.length; i++) {
        scheduleCountList[parseInt(dateList[i]) - 1]++;
    }

    if (daySectionElement) {
        daySectionElement.remove();
    }

    newDaySectionDiv.setAttribute('id', 'daySection');
    newDaySectionDiv.setAttribute('class', 'daySection');

    for (day = 1; day <= 35; day++) {
        var newDayButton = document.createElement('button');
        var newDayTextDiv = document.createElement('div');
        var newScheduleCountDiv = document.createElement('div');

        newDayButton.setAttribute('class', 'day');

        if (dayCount <= lastDay) {
            if (scheduleCountList[day - 1]) {
                newScheduleCountDiv.setAttribute('class', 'scheduleCount');
                newScheduleCountDiv.innerText = scheduleCountList[day - 1];
            }
            newDayButton.setAttribute('id', `day${day}`);
            newDayButton.setAttribute('data-value', `${day - 1}`);
            if (month < 10 && day < 10) {
                newDayButton.setAttribute('data-date', `${year}0${month}0${day}`);
            } else if (month < 10 && day > 9) {
                newDayButton.setAttribute('data-date', `${year}0${month}${day}`);
            } else if (month > 10 && day < 10) {
                newDayButton.setAttribute('data-date', `${year}${month}0${day}`);
            } else if (month > 10 && day > 9) {
                newDayButton.setAttribute('data-date', `${year}${month}${day}`);
            }
            newDayButton.setAttribute('onclick', 'openModalEvent(event)')

            newDayTextDiv.setAttribute('class', 'dayText');
            newDayTextDiv.setAttribute('data-value', `${day - 1}`);
            newDayTextDiv.innerText = dayCount;

            dayCount++;
        } else {
            newDayTextDiv.innerText = "\n"
        }

        newDaySectionDiv.appendChild(newDayButton);

        newDayButton.appendChild(newDayTextDiv);
        newDayButton.appendChild(newScheduleCountDiv);
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

    createDay(targetNum, isTargetNumEqualTodayMonth, scheduleDataList);
}