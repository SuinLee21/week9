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
    boolean isLogginIn = true;
    boolean isValidData = false;

    try{
        if(session.getAttribute("idx") == null){
            isLogginIn = false;
            throw new Exception("접근 권한이 없습니다.");
        }

        if(session.getAttribute("idx") != null){
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
                isValidData = true;

                Class.forName("com.mysql.jdbc.Driver"); 
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

                String sql = "UPDATE user SET pw=?, name=?, phoneNum=? WHERE id=?";
                PreparedStatement query = conn.prepareStatement(sql); 

                query.setString(1, pwValue);
                query.setString(2, nameValue);
                query.setString(3, phoneNumValue);
                query.setString(4, idValue);
                query.executeUpdate();

                session.setAttribute("id", idValue);
                session.setAttribute("pw", pwValue);
                session.setAttribute("name", nameValue);
                session.setAttribute("phoneNum", phoneNumValue);
            }
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>profileEditAction</title>
</head>

<body>
    <script>
        var errMessage = "<%=errMessage%>";
        var isValidData = <%=isValidData%>;
        var isLogginIn = <%=isLogginIn%>;

        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }else{
            if(!isValidData){
                alert(errMessage);
                location.href = "../page/profileEdit.jsp";
            }else{
                alert('회원정보가 수정되었습니다.');
                location.href = "../page/schedule.jsp";
            }
        }
    </script>
</body>