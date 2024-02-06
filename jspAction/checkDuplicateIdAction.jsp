<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern" %>

<% 
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("userId");
    String pwValue = request.getParameter("userPw");
    String nameValue = request.getParameter("userName");
    String phoneNumValue = request.getParameter("userPhoneNum");

    String regexId = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isIdDuplicate = false;

    String id = "";

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

        session.setAttribute("id", idValue);
        session.setAttribute("pw", pwValue);
        session.setAttribute("name", nameValue);
        session.setAttribute("phoneNum", phoneNumValue);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>checkDuplicateIdAction</title>

    <style>
        h1{
            display: inline;
        }
        .isEnabled{
            color: green;
        }
        .isDisabled{
            color: red;
        }
    </style>
</head>

<body>
    <h1 id="id" class="id"></h1>
    <h1 id="isEnabled" class="isEnabled"></h1>
    <h1 id="isDisabled" class="isDisabled"></h1>

    <script>
        var isRegexIdValid = <%=isRegexIdValid%>;
        var isIdDuplicate = <%=isIdDuplicate%>;
        var idValue = "<%=idValue%>";

        console.log(idValue)

        if(!isRegexIdValid){
            alert('아이디를 다시 입력하세요.');
        }else{
            if(isIdDuplicate){
                document.getElementById('isDisabled').innerText = "사용할 수 없는 아이디입니다.";
            }else{
                document.getElementById('isEnabled').innerText = "사용가능한 아이디입니다.";
            }
            document.getElementById('id').innerText = idValue + "은 ";
        }
    </script>
</body>