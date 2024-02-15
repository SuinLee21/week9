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
    String time = null;
    
    boolean isLogginIn = false;
    boolean isHourSelected = false;
    boolean isMinuteSelected = false;
    boolean isContentPresent = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;

        if(hourSelectValue != "" || minuteSelectValue != "" || textValue != ""){
            isHourSelected = true;
            isMinuteSelected = true;
            isContentPresent = true;

            time = hourSelectValue + minuteSelectValue;
            textValue = textValue.replaceAll("(\r\n|\r|\n|\n\r)", "");

            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "INSERT INTO schedule(user_idx, time, date, contents) VALUES(?, ?, ?, ?)";
            PreparedStatement query = conn.prepareStatement(sql);

            query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.setString(2, time);
            query.setString(3, dateValue);
            query.setString(4, textValue);
            query.executeUpdate();
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>createSchduleAction</title>
</head>

<body>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if(isLogginIn){
            var isHourSelected = <%=isHourSelected%>;
            var isMinuteSelected = <%=isMinuteSelected%>;
            var isContentPresent = <%=isContentPresent%>;
            var dateValue = <%=dateValue%>;

            if(!isHourSelected){
                alert('시를 선택해주세요.')
            }else if(!isMinuteSelected){
                alert('분을 선택해주세요.')
            }else if(!isContentPresent){
                alert('값을 입력해주세요.');
            }
            location.href = `../page/modal.jsp?date=\${dateValue}`;
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/login.html";
        }
    </script>
</body>