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
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="../css/viewprofile.css">
</head>

<body>
    <div class="box">
        <h1 id="printId" class="text">아이디 : </h1>
        <h1 id="printPw" class="text">비밀번호 : </h1>
        <h1 id="printName" class="text">이름 : </h1>
        <h1 id="printPhoneNum" class="text">전화번호 : </h1>
    </div>

    <script>
        var isLogginIn = <%=isLogginIn%>;

        if (isLogginIn) {
            var id = "<%=id%>";
            var pw = "<%=pw%>";
            var name = "<%=name%>";
            var phoneNum = "<%=phoneNum%>";

            console.log(id)

            document.getElementById('printId').innerText = "아이디 : " + id;
            document.getElementById('printPw').innerText = "비밀번호 : " + pw;
            document.getElementById('printName').innerText = "이름 : " + name;
            document.getElementById('printPhoneNum').innerText = "전화번호 : " + phoneNum;
        } else {
            alert('접근 권한이 없습니다.');
            location.href = "login.html";
        }
    </script>
</body>