<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    if(session.getAttribute("idx") != null){

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "Delete FROM user WHERE idx=?";
        PreparedStatement query = conn.prepareStatement(sql);

        query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
        query.executeUpdate();
        session.invalidate();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>withdrawalAction</title>
</head>

<body>
    <script>
        location.href = "../page/login.html";
    </script>
</body>