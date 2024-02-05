function createSchedule(scheduleNum, targetDataDate, scheduleDataList) {
    if (targetDataDate === scheduleDataList[scheduleNum][4]) {
        var newAllScheduleDiv = document.getElementById('allSchedule');

        var newScheduleSectionDiv = document.createElement('div');
        var newSchduleDiv = document.createElement('div');
        var newScheduleTimeDiv = document.createElement('div');
        var newScheduleTextHtwo = document.createElement('h2');
        var newHiddenScheduleForm = document.createElement('form');
        var newModifyHourSelect = document.createElement('select');
        var newModifyMinuteSelect = document.createElement('select');
        var newHourOption = document.createElement('option');
        var newMinuteOption = document.createElement('option');
        var newModifyTextarea = document.createElement('textarea');
        var newHiddenInput = document.createElement('input');
        var newSubmitButton = document.createElement('input');
        var newCancelButton = document.createElement('button');
        var newModifyDiv = document.createElement('div');
        var newDeleteDiv = document.createElement('a');

        // setAttribute

        newScheduleSectionDiv.setAttribute('id', `scheduleSection${scheduleNum}`);
        newScheduleSectionDiv.setAttribute('class', 'scheduleSection');

        newSchduleDiv.setAttribute('id', `divSchedule${scheduleNum}`);
        newSchduleDiv.setAttribute('class', 'schedule');

        newScheduleTimeDiv.setAttribute('class', 'scheduleTime');
        newScheduleTimeDiv.innerText = `${scheduleDataList[scheduleNum][2]}시 ${scheduleDataList[scheduleNum][3]}분`;

        newScheduleTextHtwo.setAttribute('class', 'scheduleText');
        newScheduleTextHtwo.innerText = scheduleDataList[scheduleNum][5];

        newHiddenScheduleForm.setAttribute('action', '../jspAction/scheduleEditAction.jsp');
        newHiddenScheduleForm.setAttribute('id', `hiddenSchedule${scheduleNum}`);
        newHiddenScheduleForm.setAttribute('class', 'hiddenSchedule');
        newHiddenScheduleForm.setAttribute
            ('onsubmit', `return checkValidityEvent({hour: true, minute: true, text: true}, {idOfHourSelect: 'modifyHourSelect${scheduleNum}', idOfMinuteSelect: 'modifyMinuteSelect${scheduleNum}', idOfTextarea: 'modifyTextarea${scheduleNum}'})`);
        //
        newModifyHourSelect.setAttribute('id', `modifyHourSelect${scheduleNum}`);
        newModifyHourSelect.setAttribute('class', 'modifySelect');
        newModifyHourSelect.setAttribute('name', 'modifyHourSelect');

        newHourOption.setAttribute('value', '');
        newHourOption.innerText = '시';

        newModifyMinuteSelect.setAttribute('id', `modifyMinuteSelect${scheduleNum}`);
        newModifyMinuteSelect.setAttribute('class', 'modifySelect');
        newModifyMinuteSelect.setAttribute('name', 'modifyMinuteSelect');

        newMinuteOption.setAttribute('value', '');
        newMinuteOption.innerText = '분';

        newModifyTextarea.setAttribute('maxlength', '100');
        newModifyTextarea.setAttribute('id', `modifyTextarea${scheduleNum}`);
        newModifyTextarea.setAttribute('class', 'modifyTextarea');
        newModifyTextarea.setAttribute('name', 'modifyTextarea');

        newHiddenInput.setAttribute('type', 'hidden');
        newHiddenInput.setAttribute('name', 'scheduleIdx');
        newHiddenInput.setAttribute('value', scheduleDataList[scheduleNum][0]);

        newSubmitButton.setAttribute('type', 'submit');
        newSubmitButton.setAttribute('value', '저장');

        newCancelButton.setAttribute('onclick', 'cancelEvent(event)');
        newCancelButton.innerText = '취소';

        newModifyDiv.setAttribute('class', 'modify');
        newModifyDiv.setAttribute('onclick', 'modifyEvent(event)');
        newModifyDiv.innerText = '수정';

        newDeleteDiv.setAttribute
            ('href', `../jspAction/scheduleDeleteAction.jsp?scheduleIdx=${scheduleDataList[scheduleNum][0]}`);
        newDeleteDiv.setAttribute('class', 'delete');
        newDeleteDiv.innerText = '삭제';

        // appendChild

        newAllScheduleDiv.appendChild(newScheduleSectionDiv);

        newScheduleSectionDiv.appendChild(newSchduleDiv);
        newScheduleSectionDiv.appendChild(newHiddenScheduleForm);
        newScheduleSectionDiv.appendChild(newModifyDiv);
        newScheduleSectionDiv.appendChild(newDeleteDiv);

        newSchduleDiv.appendChild(newScheduleTimeDiv);
        newSchduleDiv.appendChild(newScheduleTextHtwo);

        newHiddenScheduleForm.appendChild(newModifyHourSelect);
        newHiddenScheduleForm.appendChild(newModifyMinuteSelect);
        newHiddenScheduleForm.appendChild(newModifyTextarea);
        newHiddenScheduleForm.appendChild(newHiddenInput);
        newHiddenScheduleForm.appendChild(newSubmitButton);
        newHiddenScheduleForm.appendChild(newCancelButton);

        newModifyHourSelect.appendChild(newHourOption);
        newModifyMinuteSelect.appendChild(newMinuteOption);
    }
}

function createOption(idOfHourSelect, idOfMinuteSelect) {
    var hourSelectElement = document.getElementById(idOfHourSelect);
    var minuteSelectElement = document.getElementById(idOfMinuteSelect);

    for (i = 0; i <= 23; i++) {
        var newOption = document.createElement('option');

        newOption.setAttribute('value', `${i}`);
        newOption.innerText = i;

        hourSelectElement.appendChild(newOption);
    }
    for (i = 0; i <= 59; i++) {
        var newOption = document.createElement('option');

        newOption.setAttribute('value', `${i}`);
        newOption.innerText = i;

        minuteSelectElement.appendChild(newOption);
    }
}
