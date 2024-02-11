<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
    String sessionId = "";
    String sessionPw = "";
    String sessionName = "";
    String sessionPhoneNum = "";

    if(session.getAttribute("id") != null){
        sessionId = String.valueOf(session.getAttribute("id"));
        sessionPw = String.valueOf(session.getAttribute("pw"));
        sessionName = String.valueOf(session.getAttribute("name"));
        sessionPhoneNum = String.valueOf(session.getAttribute("phoneNum"));
        session.invalidate();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SignUp</title>
    <link rel="stylesheet" type="text/css" href="../css/accountManager.css">
</head>

<body>
    <form action="../jspAction/signUpAction.jsp" class="accountForm" onsubmit="return checkValidityEvent({id:true, checkButton: true, pw:true, name:true, phoneNum:true, inputDiabled: true}, 
        {idOfIdInput: 'userId', idOfPwInput: 'userPw', idOfNameInput: 'userName', idOfPhoneNumInput: 'userPhoneNum'})">
        <div class="idInputParent">
            <input maxlength="12" type="text" id="userId" class="accountFormChild" name="userId"
                placeholder="아이디(영어+숫자, 각 최소 1개 이상, 8~12 글자)">
            <button class="duplicateCheck" onclick="openPopUpEvent(event)">중복체크</button>
        </div>
        <div class="pwInputParent">
            <input maxlength="16" type="password" id="userPw" class="accountFormChild" name="userPw"
                placeholder="비밀번호(영어+숫자+특수문자, 각 최소 1개 이상, 8~16글자)">
            <img id="viewImg" class="viewImg" src="../img/view.jpg" onclick="conversionEvent()">
        </div>
        <div>
            <input maxlength="10" type="text" id="userName" class="accountFormChild" name="userName"
                placeholder="이름(2~10글자)">
        </div>
        <div>
            <input type="text" maxlength="13" id="userPhoneNum" class="accountFormChild" name="userPhoneNum"
                placeholder="전화번호" oninput="phoneNumberInputEvent(event)">
        </div>
        <input type="submit" class="accountFormChild accountFormSubmit" value="회원가입">
        <a href="login.html">로그인 페이지로 이동</a>
    </form>

    <script src="../js/utill.js"></script>
    <script>
        var idInputElement = document.getElementById('userId');
        var pwInputElement = document.getElementById('userPw');
        var nameInputElement = document.getElementById('userName');
        var phoneNumInputElement = document.getElementById('userPhoneNum');

        var sessionId = "<%=sessionId%>";
        var sessionPw = "<%=sessionPw%>";
        var sessionName = "<%=sessionName%>";
        var sessionPhoneNum = "<%=sessionPhoneNum%>";
        
        if(sessionId){
            idInputElement.value = sessionId;
            idInputElement.disabled = true;
        }
        if(sessionPw){
            pwInputElement.value = sessionPw;
        }
        if(sessionName){
            nameInputElement.value = sessionName;
        }
        if(sessionPhoneNum){
            phoneNumInputElement.value = sessionPhoneNum;
        }

        function openPopUpEvent(e) {
            e.preventDefault();

            var idOfIdInput = idInputElement.id;

            if (checkValidity({ id: true }, { idOfIdInput: idOfIdInput })) {
                window.open("../jspAction/checkDuplicateIdAction.jsp\?userId=" + idInputElement.value 
                + "&userPw=" + pwInputElement.value 
                + "&userName=" + nameInputElement.value 
                + "&userPhoneNum=" + phoneNumInputElement.value
                , '네이버팝업', 'width=500, height=500')
            }

            setTimeout(function(){
                location.reload();
            }, 100);
        }
    </script>
</body>