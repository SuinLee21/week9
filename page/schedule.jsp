<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<% 
    request.setCharacterEncoding("utf-8");

    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin");

        String sql = "SELECT * FROM schedule";
        PreparedStatement query = conn.prepareStatement(sql); 
        ResultSet result = query.executeQuery();

        ArrayList<ArrayList<String>> scheduleDataList = new ArrayList<ArrayList<String>>();
        while(result.next()){
            String date = result.getString("date"); 
            String contents = result.getString("contents");

            ArrayList<String> temp = new ArrayList<String>();
            temp.add("\"" + date + "\"");
            temp.add("\"" + contents + "\"");

            scheduleDataList.add(temp);
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="../css/schedule.css">
</head>

<body>
    <nav>
        <a class="navLink" href="../jspAction/logoutAction.jsp">로그아웃</a>
        <a class="navLink" href="profileEdit.jsp">내 정보 수정</a>
        <a class="navLink" href="viewprofile.jsp">내 정보 보기</a>
    </nav>

    <main id="main">
        <div class="yearSection">
            <img class="yearButton" src="../img/left.jpg" onclick="yearMinusEvent()">
            <div id="year" class="year"></div>
            <img class="yearButton" src="../img/right.jpg" onclick="yearPlusEvent()">
        </div>

        <div id="monthSection" class="monthSection"></div>
    </main>

    <div id="modal" class="modal">
        <h2 id="clickedDate"></h2>
        <h1>할 일</h1>
        <div class="closeButton" onclick="modalCloseEvent()">X</div>
        <div class="scheduleSection">
            <div id="divSchedule" class="schedule">
                <div class="scheduleTime">14시 39분</div>
                <h2 class="scheduleText">정적데이터입니다.</h2>
            </div>
            <form id="hiddenSchedule" class="hiddenSchedule"
                onsubmit="checkValidityEvent({hour: true, minute: true, text: true},
            {idOfHourSelect: 'modifyHourSelect', idOfMinuteSelect: 'modifyMinuteSelect', idOfTextarea: 'modifyTextarea'})">
                <select id="modifyHourSelect" class="modifySelect">
                    <option value="">시</option>
                </select>
                <select id="modifyMinuteSelect" class="modifySelect">
                    <option value="">분</option>
                </select>
                <textarea maxlength="100" id="modifyTextarea" class="modifyTextarea"></textarea>
            </form>
            <div class="modify" onclick="modifyEvent(event)">수정</div>
            <div class="delete">삭제</div>
        </div>
        <form class="scheduleWritingSection"
            onsubmit="checkValidityEvent({hour: true, minute: true, text: true},
            {idOfHourSelect: 'writeHourSelect', idOfMinuteSelect: 'writeMinuteSelect', idOfTextarea: 'scheduleTextarea'})">
            <select id="writeHourSelect" class="writeSelect">
                <option value="">시</option>
                <option value="1">1</option>
            </select>
            <select id="writeMinuteSelect" class="writeSelect">
                <option value="">분</option>
                <option value="1">1</option>
            </select>
            <textarea maxlength="100" id="scheduleTextarea" class="scheduleInput"
                placeholder="내용을 입력하세요.(100자 이하)"></textarea>
            <input type="submit" class="submitButton" value="작성">
        </form>
    </div>

    <script src="../js/checkValidity.js"></script>
    <script src="../js/createCalendar.js"></script>
    <script src="../js/createSchedule.js"></script>
    <script src="../js/functions.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if(isLogginIn){
            
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/login.html";
        }
    </script>
</body>