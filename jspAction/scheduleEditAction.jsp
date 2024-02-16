<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    int scheduleIdxValue = Integer.parseInt(request.getParameter("scheduleIdx"));
    String dateValue = request.getParameter("date");
    String hourSelectValue = request.getParameter("modifyHourSelect"); 
    String minuteSelectValue = request.getParameter("modifyMinuteSelect"); 
    String textValue = request.getParameter("modifyTextarea");
    String time = null;
    String errMessage = "";

    boolean isLoginIn = true;

    try{
        if(session.getAttribute("idx") == null){
            isLoginIn = false;
            throw new Exception("접근 권한이 없습니다.");
        }

        if(hourSelectValue == "" || hourSelectValue == null){
            throw new Exception("시를 선택해주세요.");
        }else if(minuteSelectValue == "" || minuteSelectValue == null){
            throw new Exception("분을 선택해주세요.");
        }else if(textValue == "" || textValue == null){
            throw new Exception("값을 입력해주세요.");
        }

        if(hourSelectValue != "" || minuteSelectValue != "" || textValue != ""){
            time = hourSelectValue + minuteSelectValue;
            textValue = textValue.replaceAll("(\r\n|\r|\n|\n\r)", "");

            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "UPDATE schedule SET time=?, contents=? WHERE idx=? AND user_idx=?";
            PreparedStatement query = conn.prepareStatement(sql); 

            query.setString(1, time);
            query.setString(2, textValue);
            query.setInt(3, scheduleIdxValue);
            query.setInt(4, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.executeUpdate();
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
    
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>scheduleEditAction</title>
</head>

<body>
    <script>
        var dateValue = <%=dateValue%>;
        var errMessage = "<%=errMessage%>";
        var isLoginIn = <%=isLoginIn%>;

        if(!isLoginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }else{
            //값이 없을 때 체크
            if(errMessage){
                alert(errMessage);
            }
            location.href = `../page/modal.jsp?date=\${dateValue}`;
        }
    </script>
</body>