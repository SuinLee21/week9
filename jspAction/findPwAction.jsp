<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern" %>

<% 
    request.setCharacterEncoding("utf-8");
    
    String idValue = request.getParameter("userId");
    String nameValue = request.getParameter("userName");
    String phoneNumValue = request.getParameter("userPhoneNum");

    String regexId = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";
    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);

    String pw = "";

    if(isRegexIdValid && isRegexNameValid && isRegexPhoneNumValid){
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "SELECT * FROM user WHERE id=? AND name=? AND phoneNum=?";
        PreparedStatement query = conn.prepareStatement(sql); 
        
        query.setString(1, idValue);
        query.setString(2, nameValue);
        query.setString(3, phoneNumValue);

        ResultSet result = query.executeQuery(); 

        while(result.next()){
            pw = result.getString("pw");
        }
        if(pw != ""){
            session.setAttribute("pw", pw);
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findPwAction</title>
</head>

<body>
    <script>
        var pw = "<%=pw%>";
        var isRegexIdValid = <%=isRegexIdValid%>;
        var isRegexNameValid = <%=isRegexNameValid%>;
        var isRegexPhoneNumValid = <%=isRegexPhoneNumValid%>;

        if(!isRegexIdValid){
            alert('아이디를 다시 입력해주세요.');
            location.href = "../page/findPw.html";
        }else if(!isRegexNameValid){
            alert('이름을 다시 입력해주세요.');
            location.href = "../page/findPw.html";
        }else if(!isRegexPhoneNumValid){
            alert('전화번호를 다시 입력해주세요.');
            location.href = "../page/findPw.html";
        }else{
            if(pw !== ""){
                location.href = "../page/findPwResult.jsp";
            }else{
                alert('회원정보가 일치하지 않습니다.');
                location.href = "../page/findPw.html";
            }
        }
    </script>
</body>