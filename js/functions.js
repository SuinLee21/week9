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

function modifyEvent(e) {
    var targetParentElement = e.target.parentElement;
    var childList = targetParentElement.children;

    for (i = 0; i < childList.length; i++) {
        if (i !== 1) {
            childList[i].style.display = "none";
        } else {
            childList[i].style.display = "flex";
        }
    }

    createOption('modifyHourSelect', 'modifyMinuteSelect');
}
