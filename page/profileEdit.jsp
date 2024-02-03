<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
    
<%
    String id = "";
    String pw = "";
    String name = "";
    String phoneNum = "";
    
    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;

        id = String.valueOf(session.getAttribute("id"));
        pw = String.valueOf(session.getAttribute("pw"));
        name = String.valueOf(session.getAttribute("name"));
        phoneNum = String.valueOf(session.getAttribute("phoneNum"));
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>profileEdit</title>
    <link rel="stylesheet" type="text/css" href="../css/accountManager.css">
</head>

<body>
    <form action="../jspAction/profileEditAction.jsp" class="accountForm" onsubmit="return checkValidityEvent({pw:true, name:true, phoneNum:true, inputDiabled:true}, 
        {idOfIdInput: 'userId', idOfPwInput: 'userPw', idOfNameInput: 'userName', idOfPhoneNumInput: 'userPhoneNum'})">
        <div>
            <input type="text" id="userId" class="accountFormChild" name="userId">
        </div>
        <div class="pwInputParent">
            <input maxlength="16" type="password" id="userPw" class="accountFormChild" name="userPw">
            <img id="viewImg" class="viewImg" src="../img/view.jpg" onclick="conversionEvent()">
        </div>
        <div>
            <input maxlength="10" type="text" id="userName" class="accountFormChild" name="userName">
        </div>
        <div>
            <input maxlength="13" type="text" id="userPhoneNum" class="accountFormChild" name="userPhoneNum" oninput="phoneNumberInputEvent(event)">
        </div>
        <div>
            <input type="submit" class="accountFormChild accountFormSubmit" value="내 정보 수정">
        </div>
        <button class="accountFormChild withdrawalButton" onclick="confirmWithdrawalEvent(event)">회원탈퇴</button>
        <a href="schedule.jsp">스케줄 페이지로 이동</a>
    </form>

    <script src="../js/checkValidity.js"></script>
    <script src="../js/utill.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if (isLogginIn) {
            var id = "<%=id%>";
            var pw = "<%=pw%>";
            var name = "<%=name%>";
            var phoneNum = "<%=phoneNum%>";

            console.log(document.getElementById('userId').disabled === true)

            document.getElementById('userId').value = id;
            document.getElementById('userId').disabled = true;
            document.getElementById('userPw').value = pw;
            document.getElementById('userName').value = name;
            document.getElementById('userPhoneNum').value = phoneNum;
        } else {
            alert('접근 권한이 없습니다.');
            location.href = "login.html";
        }

        function confirmWithdrawalEvent(e) {
            e.preventDefault();

            if (confirm("정말 탈퇴하겠습니까?")) {
                location.href = "../jspAction/withdrawalAction.jsp";
            }
        }       
    </script>
</body>