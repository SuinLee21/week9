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
    String errMessage = "";

    String regexName = "^[가-힣]{2,10}$";
    String regexPhoneNum = "^010-\\d{4}-\\d{4}$";

    boolean isRegexNameValid = Pattern.matches(regexName, nameValue);
    boolean isRegexPhoneNumValid = Pattern.matches(regexPhoneNum, phoneNumValue);
    boolean isValidData = false;
    boolean isInfoMatching = false;

    String id = "";

    try{
        if(!isRegexNameValid){
            throw new Exception("이름을 다시 입력해주세요.");
        }else if(!isRegexPhoneNumValid){
            throw new Exception("전화번호를 다시 입력해주세요.");
        }

        if(isRegexNameValid && isRegexPhoneNumValid){
            isValidData = true;

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
            if(id == ""){
                throw new Exception("회원정보가 일치하지 않습니다.");
            }
            if(id != ""){
                isInfoMatching = true;
                session.setAttribute("id", id);
            }
        }
    }catch(Exception e){
        errMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findIdAction</title>
</head>

<body>
    <script>
        var errMessage = "<%=errMessage%>";
        var isValidData = <%=isValidData%>;
        var isInfoMatching = <%=isInfoMatching%>;

        if(!isValidData){
            alert(errMessage);
            location.href = "../page/findId.html";
        }else{
            if(isInfoMatching){
                location.href = "../page/findIdResult.jsp";
            }else{
                alert(errMessage);
                location.href = "../page/findId.html";
            }
        }
    </script>
</body>