function printMatchingDay() {
    var monthSectionElement = document.getElementById('monthSection');
    var buttonList = monthSectionElement.getElementsByTagName('button');
    var month = 0;
    var isMonthEqual = false;

    for (i = 0; i < buttonList.length; i++) {
        if (buttonList[i].style.backgroundColor === "rgb(218, 227, 243)") {
            month = parseInt(buttonList[i].innerText);
        }
    }

    if (month == date.getMonth() + 1) {
        isMonthEqual = true;
    }

    createDay(month, isMonthEqual, scheduleDataList);
}

function yearMinusEvent() {
    var yearElement = document.getElementById('year');
    var yearValue = parseInt(yearElement.innerText) - 1;
    yearElement.innerText = yearValue;

    printMatchingDay();
}

function yearPlusEvent() {
    var yearElement = document.getElementById('year');
    var yearValue = parseInt(yearElement.innerText) + 1;
    yearElement.innerText = yearValue;

    printMatchingDay();
}

function modifyEvent(e) {
    var targetParentElement = e.target.parentElement;
    var childList = targetParentElement.children;
    var hTwoList = targetParentElement.getElementsByTagName('h2');
    var textareaList = targetParentElement.getElementsByTagName('textarea');
    var selectList = targetParentElement.getElementsByTagName('select');

    for (i = 0; i < childList.length; i++) {
        if (i !== 1) {
            childList[i].style.display = "none";
        } else {
            childList[i].style.display = "flex";
        }
    }

    textareaList[0].value = hTwoList[0].innerText;

    createOption(selectList[0].id, selectList[1].id);
}

function deleteEvent(e) {
    if (confirm('정말 삭제하겠습니까?')) {
        location.href = `../jspAction/scheduleDeleteAction.jsp?scheduleIdx=${e.target.getAttribute('data-value')}`;
    }
}

function cancelEvent(e) {
    e.preventDefault();

    var scheduleSectionElement = e.target.parentElement.parentElement;
    var childList = scheduleSectionElement.children;

    for (i = 0; i < childList.length; i++) {
        if (i === 0) {
            childList[i].style.display = "flex";
        } else if (i === 1) {
            childList[i].style.display = "none";
        } else {
            childList[i].style.display = "block";
        }
    }
}
