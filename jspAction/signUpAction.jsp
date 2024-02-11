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
    String errMessage = "";

    String regexId = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";
    String regexPw = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$";
    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isRegexPwValid = Pattern.matches(regexPw, pwValue);
    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);

    String id = "";

    try{
        if(!isRegexIdValid){
            throw new Exception("아이디를 다시 입력해주세요.");
        }else if(!isRegexPwValid){
            throw new Exception("비밀번호를 다시 입력해주세요.");
        }else if(!isRegexNameValid){
            throw new Exception("이름을 다시 입력해주세요.");
        }else if(!isRegexPhoneNumValid){
            throw new Exception("전화번호를 다시 입력해주세요.");
        }

        if(isRegexIdValid && isRegexPwValid && isRegexNameValid && isRegexPhoneNumValid){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "INSERT INTO user(id, pw, name, phoneNum) VALUES(?, ?, ?, ?)";
            PreparedStatement query = conn.prepareStatement(sql);

            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, nameValue);
            query.setString(4, phoneNumValue);
            query.executeUpdate();
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>signUpAction</title>
</head>

<body>
    <script>
        var isRegexIdValid = <%=isRegexIdValid%>;
        var isRegexPwValid = <%=isRegexPwValid%>;
        var isRegexNameValid = <%=isRegexNameValid%>;
        var isRegexPhoneNumValid = <%=isRegexPhoneNumValid%>;
        var errMessage = "<%=errMessage%>";

        if(!isRegexIdValid){
            alert(errMessage);
            location.href = "../page/signUp.jsp";
        }else if(!isRegexPwValid){
            alert(errMessage);
            location.href = "../page/signUp.jsp";
        }else if(!isRegexNameValid){
            alert(errMessage);
            location.href = "../page/signUp.jsp";
        }else if(!isRegexPhoneNumValid){
            alert(errMessage);
            location.href = "../page/signUp.jsp";
        }else{
            alert('정상적으로 가입되었습니다.')
            location.href = "../page/login.html";
        }
    </script>
</body>