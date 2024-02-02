<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    boolean isIdFound = false;

    if(session.getAttribute("id") != null && session.getAttribute("pw") == null){
        isIdFound = true;
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

        if(isIdFound){
            document.getElementById('foundId').innerText = '아이디 : ' + '<%=session.getAttribute("id")%>';
            <%session.invalidate();%>;
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/findPw.html";
        }
    </script>
</body>