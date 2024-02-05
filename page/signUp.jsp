<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
    String sessionId = "";

    if(session.getAttribute("id") != null){
        sessionId = String.valueOf(session.getAttribute("id"));
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
    <form action="../jspAction/signUpAction.jsp" class="accountForm" onsubmit="return checkValidityEvent({id:true, pw:true, name:true, phoneNum:true, inputDiabled: true}, 
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

    <script src="../js/checkValidity.js"></script>
    <script src="../js/utill.js"></script>
    <script>
        var inputElement = document.getElementById('userId');
        var sessionId = "<%=sessionId%>";
        
        if(sessionId){
            inputElement.value = sessionId;
            inputElement.disabled = true;
        }

        function openPopUpEvent(e) {
            e.preventDefault();

            var idOfIdInput = inputElement.id;

            if (checkValidity({ id: true }, { idOfIdInput: idOfIdInput })) {
                window.open('../jspAction/checkDuplicateIdAction.jsp?userId=' + inputElement.value, '네이버팝업', 'width=500, height=500')
            }

            setTimeout(function(){
                location.reload();
            }, 100);
        }
    </script>
</body>