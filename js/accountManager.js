var result = [];

function conversionEvent() {
    var userPwId = document.getElementById('userPw');

    if (userPwId.type === "text") {
        userPwId.type = "password";
    } else {
        userPwId.type = "text";
    }
}

function autoHyphenateEvent(e) {
    e.target.value = e.target.value.replace(/[^0-9]/g, '');

    if (e.target.value.length < 3 && result.length === 1) {
        result.pop();
    } if (e.target.value.length === 3 && result.length === 0) {
        result.push(e.target.value.substr(0, 3));
    } if (3 < e.target.value.length && e.target.value.length < 8) {
        if (result.length === 2) {
            result.pop();
        }
        result.push(e.target.value.substr(3));
        e.target.value = result.join("-");
        result.pop();
    } if (e.target.value.length === 8 && result.length === 1) {
        result.push(e.target.value.substr(4, 4));
    } if (e.target.value.length > 8) {
        result.push(e.target.value.substr(7));
        e.target.value = result.join("-");
        result.pop();
    }
}