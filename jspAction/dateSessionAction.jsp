<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    String year = request.getParameter("year");
    String month = request.getParameter("month");

    request.setCharacterEncoding("utf-8");

    session.setAttribute("year", year);
    session.setAttribute("month", month);
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>dateSessionAction</title>
</head>

<body>
    <script>
        location.href = "../page/schedule.jsp";
    </script>
</body>