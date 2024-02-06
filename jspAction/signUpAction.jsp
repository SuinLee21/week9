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
    String regexPw = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$";
    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isRegexPwValid = Pattern.matches(regexPw, pwValue);
    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);
    boolean isIdDuplicate = false;

    String id = "";

    if(isRegexIdValid && isRegexPwValid && isRegexNameValid && isRegexPhoneNumValid){
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

        String sql = "SELECT id FROM user WHERE id=?";//
        PreparedStatement query = conn.prepareStatement(sql);

        query.setString(1, idValue);

        ResultSet result = query.executeQuery(); 

        while(result.next()){
            id = result.getString("id");
        }
        if(id != ""){//
            isIdDuplicate = true;
        }else{
            sql = "INSERT INTO user(id, pw, name, phoneNum) VALUES(?, ?, ?, ?)";
            query = conn.prepareStatement(sql);

            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, nameValue);
            query.setString(4, phoneNumValue);
            query.executeUpdate();
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>signUpAction</title>
</head>

<body>
    <script>
        var isIdDuplicate = <%=isIdDuplicate%>;

        if(isIdDuplicate){
            alert('중복된 아이디입니다. 다시 입력해주세요.');
            location.href = "../page/signUp.jsp";
        }else{
            var isRegexIdValid = <%=isRegexIdValid%>;
            var isRegexPwValid = <%=isRegexPwValid%>;
            var isRegexNameValid = <%=isRegexNameValid%>;
            var isRegexPhoneNumValid = <%=isRegexPhoneNumValid%>;

            if(!isRegexIdValid){
                alert('아이디를 다시 입력해주세요.');
                location.href = "../page/signUp.html";
            }else if(!isRegexPwValid){
                alert('비밀번호를 다시 입력해주세요.');
                location.href = "../page/signUp.html";
            }else if(!isRegexNameValid){
                alert('이름을 다시 입력해주세요.');
                location.href = "../page/signUp.html";
            }else if(!isRegexPhoneNumValid){
                alert('전화번호를 다시 입력해주세요.');
                location.href = "../page/signUp.html";
            }else{
                alert('정상적으로 가입되었습니다.')
                location.href = "../page/login.html";
            }
        }
    </script>
</body>