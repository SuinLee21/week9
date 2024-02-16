<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    boolean isPwFound = true;
    String errMessage = "";
    String sessionPw = "";

    try{
        if(session.getAttribute("pw") == null){
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("pw") != null && session.getAttribute("id") == null){
            sessionPw = String.valueOf(session.getAttribute("pw"));
            session.invalidate();
        }
    }catch(Exception e){
        errMessage = e.getMessage();
        isPwFound = false;
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
    <h2>새로고침 시, 비밀번호를 더 이상 볼 수 없습니다.</h2>
    <a href="../page/login.html">로그인 페이지로 이동</a>

    <script>
        var isPwFound = <%=isPwFound%>;
        var errMessage = "<%=errMessage%>";
        var sessionPw = "<%=sessionPw%>";

        if(isPwFound){
            document.getElementById('foundPw').innerText = '비밀번호 : ' + sessionPw;
        }else{
            alert(errMessage);
            location.href = "../page/login.html";
        }
    </script>
</body>