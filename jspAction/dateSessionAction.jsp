<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    request.setCharacterEncoding("utf-8");

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String errMessage = "";

    boolean isLogginIn = true;

    try{
        if(session.getAttribute("idx") == null){
            isLogginIn = false;
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("idx") != null){
            session.setAttribute("year", year);
            session.setAttribute("month", month);
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>dateSessionAction</title>
</head>

<body>
    <script>
        var isLogginIn = <%=isLogginIn%>;
        var errMessage = "<%=errMessage%>";

        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }else{
            location.href = "../page/schedule.jsp";
        }
    </script>
</body>