function createSchedule() {
    var modalId = document.getElementById('modal');
    var createScheduleSection = document.createElement('div');
    var createSchdule = document.createElement('div');
    var createScheduleTime = document.createElement('div');
    var createScheduleText = document.createElement('h2');
    var createhiddenSchedule = document.createElement('div');
    var createHourSelect = document.createElement('select');
    var createMinuteSelect = document.createElement('select');
    var createHourOption = document.createElement('option');
    var createMinuteOption = document.createElement('option');
    var createModifyTextarea = document.createElement('textarea');
    var createModify = document.createElement('div');
    var createDelete = document.createElement('div');

    // setAttribute
    createScheduleSection.setAttribute('id', 'scheduleSection');//
    createScheduleSection.setAttribute('class', 'scheduleSection');

    createSchdule.setAttribute('id', 'divSchedule');//
    createSchdule.setAttribute('class', 'schedule');

    createScheduleTime.setAttribute('class', 'scheduleTime');
    // createScheduleTime.innerText = 

    createScheduleText.setAttribute('class', 'scheduleText');
    // createScheduleText.innerText = 

    createhiddenSchedule.setAttribute('id', 'hiddenSchedule');//
    createhiddenSchedule.setAttribute('class', 'hiddenSchedule');

    createHourSelect.setAttribute('id', 'modifyHourSelect');//
    createHourSelect.setAttribute('class', 'modifySelect');

    createHourOption.setAttribute('value', '');
    createHourOption.innerText = '시';

    createMinuteSelect.setAttribute('id', 'modifyMinuteSelect');//
    createMinuteSelect.setAttribute('class', 'modifySelect');

    createMinuteOption.setAttribute('value', '');
    createMinuteOption.innerText = '분';

    createModifyTextarea.setAttribute('maxlength', '100');
    createModifyTextarea.setAttribute('id', 'modifyTextarea');//
    createModifyTextarea.setAttribute('class', 'modifyTextarea');

    createModify.setAttribute('class', 'modify');
    // createModify.setAttribute('data-value', '');
    createModify.setAttribute('onclick', 'modifyEvent(event)');
    createModify.innerText = '수정';

    createDelete.setAttribute('class', 'delete');
    createDelete.innerText = '삭제';

    // appendChild

    modalId.appendChild(createScheduleSection);

    createScheduleSection.appendChild(createSchdule);
    createScheduleSection.appendChild(createhiddenSchedule);
    createScheduleSection.appendChild(createModify);
    createScheduleSection.appendChild(createDelete);

    createSchdule.appendChild(createScheduleTime);
    createSchdule.appendChild(createScheduleText);

    createhiddenSchedule.appendChild(createHourSelect);
    createhiddenSchedule.appendChild(createMinuteSelect);
    createhiddenSchedule.appendChild(createModifyTextarea);

    createHourSelect.appendChild(createHourOption);
    createMinuteSelect.appendChild(createMinuteOption);
}

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