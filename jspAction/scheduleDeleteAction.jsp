<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    int scheduleIdxValue = Integer.parseInt(request.getParameter("scheduleIdx"));
    String month = "";

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

    String sql = "SELECT date from schedule WHERE idx=?";
    PreparedStatement query = conn.prepareStatement(sql); 

    query.setInt(1, scheduleIdxValue);

    ResultSet result = query.executeQuery();

    while(result.next()){
        month = result.getString("date").substring(4, 6);
    }

    sql = "Delete FROM schedule WHERE idx=? AND user_idx=?";
    query = conn.prepareStatement(sql);

    query.setInt(1, scheduleIdxValue);
    query.setInt(2, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
    query.executeUpdate();

    session.setAttribute("month", month);
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>scheduleDeleteAction</title>
</head>

<body>
    <script>
        location.href = "../page/schedule.jsp";
    </script>
</body>