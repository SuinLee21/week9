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
    String errMessage = "";

    String regexId = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";
    String regexPw = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$";

    String idx = "";
    String id = "";
    String pw = "";
    String name = "";
    String phoneNum = "";

    boolean isRegexIdValid = Pattern.matches(regexId, idValue);
    boolean isRegexPwValid = Pattern.matches(regexPw, pwValue);
    boolean isValidData = false;
    boolean isInfoMatching = false;

    try{
        if(!isRegexIdValid){
            throw new Exception("아이디를 다시 입력해주세요.");
        }else if(!isRegexPwValid){
            throw new Exception("비밀번호를 다시 입력해주세요.");
        }

        if(isRegexIdValid && isRegexPwValid){
            isValidData = true;

            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin"); 

            String sql = "SELECT * FROM user WHERE id=? AND pw=?";
            PreparedStatement query = conn.prepareStatement(sql); 

            query.setString(1, idValue);
            query.setString(2, pwValue);

            ResultSet result = query.executeQuery(); 

            while(result.next()){
                idx = String.valueOf(result.getInt("idx"));
                id = result.getString("id");
                pw = result.getString("pw");
                name = result.getString("name");
                phoneNum = result.getString("phoneNum");
            }
            if(id == "" || pw == ""){
                throw new Exception("회원정보가 일치하지 않습니다.");
            }
            if(id != "" && pw != ""){
                isInfoMatching = true;

                session.setAttribute("idx", idx);
                session.setAttribute("id", id);
                session.setAttribute("pw", pw);
                session.setAttribute("name", name);
                session.setAttribute("phoneNum", phoneNum);
            }
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>loginAction</title>
</head>

<body>
    <script>
        var errMessage = "<%=errMessage%>";
        var isValidData = <%=isValidData%>;
        var isInfoMatching = <%=isInfoMatching%>;

        if(!isValidData){
            alert(errMessage);
            location.href = "../page/login.html";
        }else{
            if(isInfoMatching){                
                location.href = '../page/schedule.jsp';
            }else{
                alert(errMessage);
                location.href = '../page/login.html';
            }
        }
    </script>
</body>