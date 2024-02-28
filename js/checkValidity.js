function checkValidityEvent(booleanOptions, htmlOptions) {
    return checkValidity(booleanOptions, htmlOptions);
}

function checkValidity(booleanOptions, htmlOptions) {
    var regexId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/; //영어+숫자, 각 최소 1개 이상 8~12
    var regexPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$/; //영어+숫자, 각 최소 1개 이상 8~16
    var regexName = /^[가-힣]{2,10}$/ //한글만 2~10;
    var regexPhoneNum = /^010-\d{4}-\d{4}$/;

    if (booleanOptions.id === true) {
        var idInputElement = document.getElementById(htmlOptions.idOfIdInput);
        if (!regexId.test(idInputElement.value)) {
            alert('아이디를 다시 입력해주세요.');
            return false;
        }
    }
    if (booleanOptions.checkButton === true) {
        var idInputElement = document.getElementById(htmlOptions.idOfIdInput);
        if (idInputElement.disabled === false) {
            alert('아이디 중복체크를 해주세요.');
            return false;
        }
    }
    if (booleanOptions.pw === true) {
        var pwInputElement = document.getElementById(htmlOptions.idOfPwInput);
        if (!regexPw.test(pwInputElement.value)) {
            alert('비밀번호를 다시 입력해주세요.');
            return false;
        }
    }
    if (booleanOptions.name === true) {
        var nameInputElement = document.getElementById(htmlOptions.idOfNameInput);
        if (!regexName.test(nameInputElement.value)) {
            alert('이름을 다시 입력해주세요.');
            return false;
        }
    }
    if (booleanOptions.phoneNum === true) {
        var phoneNumInputElement = document.getElementById(htmlOptions.idOfPhoneNumInput);
        if (!regexPhoneNum.test(phoneNumInputElement.value)) {
            alert('전화번호를 다시 입력해주세요.');
            return false;
        }
    }

    if (booleanOptions.inputDiabled === true) {
        var idInputElement = document.getElementById(htmlOptions.idOfIdInput);
        if (idInputElement.disabled === true) {
            idInputElement.disabled = false;
        }
    }

    if (booleanOptions.hour === true) {
        var hourSelectElement = document.getElementById(htmlOptions.idOfHourSelect);
        if (!hourSelectElement.options[hourSelectElement.selectedIndex].value) {
            alert('시를 선택해주세요.');
            return false;
        }
    }
    if (booleanOptions.minute === true) {
        var minuteSelectElement = document.getElementById(htmlOptions.idOfMinuteSelect);
        if (!minuteSelectElement.options[minuteSelectElement.selectedIndex].value) {
            alert('분을 선택해주세요.');
            return false;
        }
    }
    if (booleanOptions.text === true) {
        var textValue = document.getElementById(htmlOptions.idOfTextarea).value;
        textValue = textValue.replace(/\n|\r/g, '');
        document.getElementById(htmlOptions.idOfTextarea).value = textValue;

        if (!textValue) {
            alert('내용을 입력해주세요.');
            return false;
        }
    }
    return true;
}