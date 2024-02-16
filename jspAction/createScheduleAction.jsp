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
    String errMessage = "";
    
    boolean isLogginIn = true;
    boolean isValidData = false;

    try{
        if(session.getAttribute("idx") == null){
            isLogginIn = false;
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("idx") != null){
            if(hourSelectValue == "" || hourSelectValue == null){
                throw new Exception("시를 선택해주세요.");
            }else if(minuteSelectValue == "" || minuteSelectValue == null){
                throw new Exception("분을 선택해주세요.");
            }else if(textValue == "" || textValue == null){
                throw new Exception("값을 입력해주세요.");
            }

            if(hourSelectValue != "" || minuteSelectValue != "" || textValue != ""){
                isValidData = true;
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
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>createSchduleAction</title>
</head>

<body>
    <script>
        var dateValue = <%=dateValue%>;
        var errMessage = "<%=errMessage%>";
        var isValidData = <%=isValidData%>;
        var isLogginIn = <%=isLogginIn%>;

        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }else{
            if(!isValidData){
                alert(errMessage);
            }
            location.href = `../page/modal.jsp?date=\${dateValue}`;
        }
    </script>
</body>