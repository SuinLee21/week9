<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern" %>

<% 
    request.setCharacterEncoding("utf-8");
    
    String nameValue = request.getParameter("userName");
    String phoneNumValue = request.getParameter("userPhoneNum");

    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);

    String id = "";

    if(isRegexNameValid && isRegexPhoneNumValid){
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "SELECT * FROM user WHERE name=? AND phoneNum=?";
        PreparedStatement query = conn.prepareStatement(sql); 
        
        query.setString(1, nameValue);
        query.setString(2, phoneNumValue);

        ResultSet result = query.executeQuery(); 

        while(result.next()){
            id = result.getString("id");
        }
        if(id != ""){
            session.setAttribute("id", id);
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findIdAction</title>
</head>

<body>
    <script>
        var id = "<%=id%>";
        var isRegexNameValid = <%=isRegexNameValid%>;
        var isRegexPhoneNumValid = <%=isRegexPhoneNumValid%>;

        if(!isRegexNameValid){
            alert('이름을 다시 입력해주세요.');
            location.href = "../page/findId.html";
        }else if(!isRegexPhoneNumValid){
            alert('전화번호를 다시 입력해주세요.');
            location.href = "../page/findId.html";
        }else{
            if(id !== ""){
                location.href = "../page/findIdResult.jsp";
            }else{
                alert('회원정보가 일치하지 않습니다.');
                location.href = "../page/findId.html";
            }
        }
    </script>
</body>