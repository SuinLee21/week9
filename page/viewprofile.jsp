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
    String errMessage = "";
    boolean isLogginIn = true;

    try{
        if(session.getAttribute("idx") == null){
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("idx") != null){
            id = String.valueOf(session.getAttribute("id"));
            pw = String.valueOf(session.getAttribute("pw"));
            name = String.valueOf(session.getAttribute("name"));
            phoneNum = String.valueOf(session.getAttribute("phoneNum"));
        }
    }catch(Exception e){
        errMessage = e.getMessage();
        isLogginIn = false;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="../css/viewprofile.css">

    <style>
        a {
            text-decoration: none;
            color: black;
            display: block;
            width: fit-content;
            margin: 10 auto;
        }
    </style>
</head>

<body>
    <div class="box">
        <h1 id="printId" class="text">아이디 : </h1>
        <h1 id="printPw" class="text">비밀번호 : </h1>
        <h1 id="printName" class="text">이름 : </h1>
        <h1 id="printPhoneNum" class="text">전화번호 : </h1>
    </div>
    <a href="../page/schedule.jsp">스케줄 페이지로 이동</a>

    <script>
        var isLogginIn = <%=isLogginIn%>;
        var errMessage = "<%=errMessage%>";

        if (isLogginIn) {
            var id = "<%=id%>";
            var pw = "<%=pw%>";
            var name = "<%=name%>";
            var phoneNum = "<%=phoneNum%>";

            document.getElementById('printId').innerText = "아이디 : " + id;
            document.getElementById('printPw').innerText = "비밀번호 : " + pw;
            document.getElementById('printName').innerText = "이름 : " + name;
            document.getElementById('printPhoneNum').innerText = "전화번호 : " + phoneNum;
        } else {
            alert(errMessage);
            location.href = "login.html";
        }
    </script>
</body>