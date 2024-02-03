function createSchedule() {
    var modalElement = document.getElementById('modal');
    var newScheduleSectionDiv = document.createElement('div');
    var newSchduleDiv = document.createElement('div');
    var newScheduleTimeDiv = document.createElement('div');
    var newScheduleTextHtwo = document.createElement('h2');
    var newhiddenScheduleForm = document.createElement('form');
    var newModifyHourSelect = document.createElement('select');
    var newModifyMinuteSelect = document.createElement('select');
    var newHourOption = document.createElement('option');
    var newMinuteOption = document.createElement('option');
    var newModifyTextarea = document.createElement('textarea');
    var newModifyDiv = document.createElement('div');
    var newDeleteDiv = document.createElement('div');

    // setAttribute

    newScheduleSectionDiv.setAttribute('id', 'scheduleSection');//
    newScheduleSectionDiv.setAttribute('class', 'scheduleSection');

    newSchduleDiv.setAttribute('id', 'divSchedule');//
    newSchduleDiv.setAttribute('class', 'schedule');

    newScheduleTimeDiv.setAttribute('class', 'scheduleTime');

    newScheduleTextHtwo.setAttribute('class', 'scheduleText');
    // newScheduleTimeDiv.innerText = 
    // newScheduleTextHtwo.innerText = 

    newhiddenScheduleForm.setAttribute('id', 'hiddenSchedule');//
    newhiddenScheduleForm.setAttribute('class', 'hiddenSchedule');
    newhiddenScheduleForm.setAttribute('onsubmit', "checkValidityEvent({hour: true, minute: true, text: true}, {idOfHourSelect: 'modifyHourSelect', idOfMinuteSelect: 'modifyMinuteSelect', idOfTextarea: 'modifyTextarea'})");

    newModifyHourSelect.setAttribute('id', 'modifyHourSelect');//
    newModifyHourSelect.setAttribute('class', 'modifySelect');

    newHourOption.setAttribute('value', '');
    newHourOption.innerText = '시';

    newModifyMinuteSelect.setAttribute('id', 'modifyMinuteSelect');//
    newModifyMinuteSelect.setAttribute('class', 'modifySelect');

    newMinuteOption.setAttribute('value', '');
    newMinuteOption.innerText = '분';

    newModifyTextarea.setAttribute('maxlength', '100');
    newModifyTextarea.setAttribute('id', 'modifyTextarea');//
    newModifyTextarea.setAttribute('class', 'modifyTextarea');

    newModifyDiv.setAttribute('class', 'modify');
    // newModifyDiv.setAttribute('data-value', '');
    newModifyDiv.setAttribute('onclick', 'modifyEvent(event)');
    newModifyDiv.innerText = '수정';

    newDeleteDiv.setAttribute('class', 'delete');
    newDeleteDiv.innerText = '삭제';

    // appendChild

    modalElement.appendChild(newScheduleSectionDiv);

    newScheduleSectionDiv.appendChild(newSchduleDiv);
    newScheduleSectionDiv.appendChild(newhiddenScheduleForm);
    newScheduleSectionDiv.appendChild(newModifyDiv);
    newScheduleSectionDiv.appendChild(newDeleteDiv);

    newSchduleDiv.appendChild(newScheduleTimeDiv);
    newSchduleDiv.appendChild(newScheduleTextHtwo);

    newhiddenScheduleForm.appendChild(newModifyHourSelect);
    newhiddenScheduleForm.appendChild(newModifyMinuteSelect);
    newhiddenScheduleForm.appendChild(newModifyTextarea);

    newModifyHourSelect.appendChild(newHourOption);
    newModifyMinuteSelect.appendChild(newMinuteOption);
}

function createOption(idOfHourSelect, idOfMinuteSelect) {
    var hourSelectElement = document.getElementById(idOfHourSelect);
    var minuteSelectElement = document.getElementById(idOfMinuteSelect);

    for (i = 1; i <= 23; i++) {
        var newOption = document.createElement('option'); //함수랑 변수 중복 ㄴㄴ

        newOption.setAttribute('value', `${i}`);
        newOption.innerText = i;

        hourSelectElement.appendChild(newOption);
    }
    for (i = 1; i <= 59; i++) {
        var newOption = document.createElement('option');

        newOption.setAttribute('value', `${i}`);
        newOption.innerText = i;

        minuteSelectElement.appendChild(newOption);
    }
}
