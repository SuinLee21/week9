<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    String scheduleIdxValue = request.getParameter("scheduleIdx"); 
    String hourSelectValue = request.getParameter("modifyHourSelect"); 
    String minuteSelectValue = request.getParameter("modifyMinuteSelect"); 
    String textValue = request.getParameter("modifyTextarea"); 

    boolean isContentPresent = false;
    
    if(textValue != ""){
        isContentPresent = true;

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "UPDATE schedule SET hour=?, minute=?, contents=? WHERE idx=? AND user_idx=?";
        PreparedStatement query = conn.prepareStatement(sql);

        query.setInt(1, Integer.parseInt(hourSelectValue));
        query.setInt(2, Integer.parseInt(minuteSelectValue));
        query.setString(3, textValue);
        query.setInt(4, Integer.parseInt(scheduleIdxValue));
        query.setInt(5, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
        query.executeUpdate();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        var isContentPresent = <%=isContentPresent%>;

        if(isContentPresent){
            alert('수정이 완료되었습니다.');
        }else{
            alert('값을 입력하세요.')
        }
        location.href = "../page/schedule.jsp";
    </script>
</body>