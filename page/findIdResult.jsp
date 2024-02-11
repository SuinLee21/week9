<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
    boolean isIdFound = true;
    String errMessage = "";
    String sessionPw = "";

    try{
        if(session.getAttribute("id") == null){
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("id") != null && session.getAttribute("pw") == null){
            sessionPw = String.valueOf(session.getAttribute("pw"));
            session.invalidate();
        }
    }catch(Exception e){
        errMessage = e.getMessage();
        isIdFound = false;
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

    <h1 id="foundId"></h1>
    <a href="../page/login.html">로그인 페이지로 이동</a>

    <script>
        var isIdFound = <%=isIdFound%>;
        var errMessage = "<%=errMessage%>";
        var sessionId = "<%=sessionId%>";

        if(isIdFound){
            document.getElementById('foundId').innerText = '아이디 : ' + sessionId;
        }else{
            alert(errMessage);
            location.href = "../page/login.html";
        }
    </script>
</body>