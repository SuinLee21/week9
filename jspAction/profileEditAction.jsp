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

    String regexPw = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$";
    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexPwValid = Pattern.matches(regexPw, pwValue);
    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);
    boolean isLogginIn = false;

    if(session.getAttribute("id") != null){
        isLogginIn = true;

        if(isRegexPwValid && isRegexNameValid && isRegexPhoneNumValid){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "UPDATE user SET id=?, pw=?, name=?, phoneNum=? WHERE id=?";
            PreparedStatement query = conn.prepareStatement(sql); 

            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, nameValue);
            query.setString(4, phoneNumValue);
            query.setString(5, idValue);
            query.executeUpdate();

            session.setAttribute("id", idValue);
            session.setAttribute("pw", pwValue);
            session.setAttribute("name", nameValue);
            session.setAttribute("phoneNum", phoneNumValue);
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>profileEditAction</title>
</head>

<body>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if(isLogginIn){
            var isRegexPwValid = <%=isRegexPwValid%>;
            var isRegexNameValid = <%=isRegexNameValid%>;
            var isRegexPhoneNumValid = <%=isRegexPhoneNumValid%>;

            if(!isRegexPwValid){
                alert('비밀번호를 다시 입력하세요.');
                location.href = "../page/profileEdit.jsp";
            }else if(!isRegexNameValid){
                alert('이름을 다시 입력하세요.');
                location.href = "../page/profileEdit.jsp";
            }else if(!isRegexPhoneNumValid){
                alert('전화번호를 다시 입력하세요.');
                location.href = "../page/profileEdit.jsp";
            }else{
                alert('내정보 수정이 완료되었습니다.');
                location.href = "../page/schedule.jsp";
            }
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/schedule.jsp"
        }
    </script>
</body>