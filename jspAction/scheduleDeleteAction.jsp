<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    int scheduleIdxValue = Integer.parseInt(request.getParameter("scheduleIdx"));
    String dateValue = request.getParameter("date");
    String errMessage = "";

    boolean isLoginIn = true; 

    try{
        if(session.getAttribute("idx") == null){
            isLoginIn = false;
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("idx") != null){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "DELETE FROM schedule WHERE idx=? AND user_idx=?";
            PreparedStatement query = conn.prepareStatement(sql); 

            query.setInt(1, scheduleIdxValue);
            query.setInt(2, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.executeUpdate();
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>scheduleDeleteAction</title>
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
            location.href = `../page/modal.jsp?date=\${dateValue}`;
        }
    </script>
</body>