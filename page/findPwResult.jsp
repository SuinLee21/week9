<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    boolean isPwFound = false;

    String sessionPw = "";

    if(session.getAttribute("pw") != null && session.getAttribute("id") == null){
        isPwFound = true;
        sessionPw = String.valueOf(session.getAttribute("pw"));
        session.invalidate();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findIdResult</title>

    <style>
        a {
            text-decoration: none;
            color: black;
        }
    </style>
</head>

<body>
    <h1 id="foundPw"></h1>
    <a href="../page/login.html">로그인 페이지로 이동</a>

    <script>
        var isPwFound = <%=isPwFound%>;
        var sessionPw = "<%=sessionPw%>";

        if(isPwFound){
            document.getElementById('foundPw').innerText = '비밀번호 : ' + sessionPw;
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/login.html";
        }
    </script>
</body>