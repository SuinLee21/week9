var date = new Date();

function createYear(year) {
    var yearElement = document.getElementById('year');

    yearElement.innerText = year;
}

function createMonth(month) {
    var monthSectionElement = document.getElementById('monthSection');

    for (i = 1; i <= 12; i++) {
        var newMonthButton = document.createElement('button');

        newMonthButton.setAttribute('id', `monthButton${i}`);
        newMonthButton.setAttribute('class', 'monthButton');
        newMonthButton.setAttribute('onclick', 'createDayEvent(event)');
        newMonthButton.innerText = i;

        monthSectionElement.appendChild(newMonthButton);
    }
    document.getElementById('monthButton' + month).style.backgroundColor = "rgb(218, 227, 243)";
}

function createDay(year, month, dateList) {
    var daySectionElement = document.getElementById('daySection');
    console.log(month)
    var thirtyOneList = [1, 3, 5, 7, 8, 10, 12];
    var thirtyList = [4, 6, 9, 11];
    var dayCount = 1;
    var lastDay = 0;
    var scheduleCountList = [];
    var dayList = [];

    //month의 최대 일자 계산
    if (thirtyOneList.includes(parseInt(month))) {
        lastDay = 31;
    } else if (thirtyList.includes(parseInt(month))) {
        lastDay = 30;
    } else {
        lastDay = 28;
    }

    //각 일자의 스케줄 갯수 세기
    for (i = 0; i < dateList.length; i++) {
        dayList.push(dateList[i][0].substr(6, 2));
    }
    for (i = 0; i < lastDay; i++) {
        scheduleCountList.push(0);
    }
    for (i = 0; i < dayList.length; i++) {
        scheduleCountList[parseInt(dayList[i]) - 1]++;
    }

    //day 생성
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

        daySectionElement.appendChild(newDayButton);

        newDayButton.appendChild(newDayTextDiv);
        newDayButton.appendChild(newScheduleCountDiv);
    }

    if (date.getFullYear() === parseInt(year) && date.getMonth() + 1 === parseInt(month)) {
        document.getElementById('day' + (date.getDate()).toString()).style.backgroundColor = "rgb(218, 227, 243)";
    }
}