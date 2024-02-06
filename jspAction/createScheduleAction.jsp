<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8"); 
    String hourSelectValue = request.getParameter("writeHourSelect"); 
    String minuteSelectValue = request.getParameter("writeMinuteSelect"); 
    String dateValue = request.getParameter("hiddenDate");
    String textValue = request.getParameter("scheduleTextarea");
    String month = "";
    
    boolean isLogginIn = false;
    boolean isContentPresent = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;

        if(hourSelectValue != "" || minuteSelectValue != "" || textValue != ""){
            isContentPresent = true;
            month = dateValue.substring(4, 6);
            textValue = textValue.replaceAll("(\r\n|\r|\n|\n\r)", "");

            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "INSERT INTO schedule(user_idx, hour, minute, date, contents) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement query = conn.prepareStatement(sql);

            query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.setInt(2, Integer.parseInt(hourSelectValue));
            query.setInt(3, Integer.parseInt(minuteSelectValue));
            query.setString(4, dateValue);
            query.setString(5, textValue);
            query.executeUpdate();

            session.setAttribute("month", month);
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if(isLogginIn){
            var isContentPresent = <%=isContentPresent%>;

            if(!isContentPresent){
                alert('값을 입력하세요.');
            }
            location.href = "../page/schedule.jsp"
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/schedule.jsp";
        }
    </script>
</body>