function conversionEvent() {
    var userPwId = document.getElementById('userPw');

    if (userPwId.type === "text") {
        userPwId.type = "password";
    } else {
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

        return result.join("-");
    } else if (phoneNumber.length > 3) {
        result.push(phoneNumber.substr(0, 3));
        result.push(phoneNumber.substr(3));

        return result.join("-");
    } else {
        result.push(phoneNumber.substr(0));

        return result.join("-");
    }
}
