<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;
        session.invalidate();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>logoutAction</title>
</head>

<body>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if(isLogginIn){
            alert('로그아웃 되었습니다.');
        }else{
            alert('접근 권한이 없습니다.');
        }
        location.href = "../page/login.html";
    </script>
</body>