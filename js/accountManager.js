function conversionEvent() {
    var userPwId = document.getElementById('userPw');

    if (userPwId.type === "text") {
        userPwId.type = "password";
    }
    {
        userPwId.type = "text";
    }
}

function phoneNumberInputEvent(e) {
    var phonNumber = e.target.value.replace(/[^0-9]/g, '');

    e.target.value = generateHypen(phonNumber);
}

function generateHypen(phoneNumber) {
    var result = [];

    if (phoneNumber.length > 7) {
        result.push(phoneNumber.substr(0, 3));
        result.push(phoneNumber.substr(3, 4));
        result.push(phoneNumber.substr(7));
    }

    if (phoneNumber.length > 3) {
        result.push(phoneNumber.substr(0, 3));
        result.push(phoneNumber.substr(3));
    }

    if (phoneNumber.length <= 3) {
        result.push(phoneNumber.substr(0));
    }

    return result.join("-");
}

function openPopUpEvent() {
    window.open('../page/login.html', '네이버팝업', 'width=500, height=500, resizeable=no')
}