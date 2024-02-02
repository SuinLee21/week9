<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern" %>

<% 
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("userId");

    String regexId = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isIdDuplicate = false;

    String id = "";

    String aaa = "rkskek";//
    session.setAttribute("aaa", aaa);//

    if(isRegexIdValid){
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "SELECT id FROM user WHERE id=?";
        PreparedStatement query = conn.prepareStatement(sql);

        query.setString(1, idValue);

        ResultSet result = query.executeQuery(); 

        while(result.next()){
            id = result.getString("id");
        }
        if(id != ""){
            isIdDuplicate = true;
            
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>checkDuplicateIdAction</title>
</head>

<body>
    <script>
        var isRegexIdValid = <%=isRegexIdValid%>;
        var isIdDuplicate = <%=isIdDuplicate%>;
        var idValue = "<%=idValue%>";

        console.log(idValue)

        if(!isRegexIdValid){
            alert('아이디를 다시 입력하세요.');
            location.href = "../page/signUp.html";
        }else{
            if(isIdDuplicate){
                alert('중복된 아이디입니다. 다시 입력해주세요.');
                location.href = "../page/signUp.html";
            }else{
                alert('사용 가능한 아이디입니다.');
                location.href = "../page/signUp.html";
            }
        }
    </script>
</body>