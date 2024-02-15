<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>

<% 
    LocalDate now = LocalDate.now();
    String errMessage = "";
    String year = null;
    String month = null;
    String yearAndMonth = null;
    boolean isLogginIn = true;
    ArrayList<ArrayList<String>> dateList = new ArrayList<ArrayList<String>>();

    try{
        request.setCharacterEncoding("utf-8");

        if(session.getAttribute("idx") == null){
            throw new Exception("접근 권한이 없습니다."); //더 이상 아래 코드 실행 안 되게.
        }

        if(session.getAttribute("idx") != null){
            year = String.valueOf(session.getAttribute("year"));
            month = String.valueOf(session.getAttribute("month"));

            if(year == "null"){
                year = String.valueOf(now.getYear());
            }
            if(month == "null"){
                if(now.getMonthValue() < 10){
                    month = "0" + String.valueOf(now.getMonthValue());
                }else{
                    month = String.valueOf(now.getMonthValue());
                }
            }

            yearAndMonth = year + month;

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin");

            String sql = "SELECT * FROM schedule WHERE user_idx=? AND left(date, 6)=?";
            PreparedStatement query = conn.prepareStatement(sql);
            query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.setString(2, yearAndMonth);
            ResultSet result = query.executeQuery();

            while(result.next()){
                String date = result.getString("date");
                ArrayList<String> temp = new ArrayList<String>();
                temp.add("\"" + date + "\"");
                dateList.add(temp);
            }
            session.removeAttribute("year");
            session.removeAttribute("month");
        }
    } catch (Exception e) {
        errMessage = e.getMessage();
        isLogginIn = false;
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

        <div id="daySection" class="daySection"></div>
    </main>

    <%-- <div class="scheduleSection">
        <div id="divSchedule" class="schedule">
            <div class="scheduleTime">14시 39분</div>
            <h2 class="scheduleText">정적데이터입니다.</h2>
        </div>
        <form id="hiddenSchedule" class="hiddenSchedule"
            onsubmit="return checkValidityEvent({hour: true, minute: true, text: true},
        {idOfHourSelect: 'modifyHourSelect', idOfMinuteSelect: 'modifyMinuteSelect', idOfTextarea: 'modifyTextarea'})">
            <select id="modifyHourSelect" class="modifySelect" name="modifyHourSelect">
                <option value="">시</option>
            </select>
            <select id="modifyMinuteSelect" class="modifySelect" name="modifyMinuteSelect">
                <option value="">분</option>
            </select>
            <textarea maxlength="100" id="modifyTextarea" class="modifyTextarea" name="modifyTextarea"></textarea>
            <input type="hidden" value=''>
            <input type="submit" value="저장">
            <button onclick="cancelEvent(event)">취소</button>
        </form>
        <div id="modify" class="modify" onclick="modifyEvent(event)">수정</div>
        <div id="delete" class="delete" data-value="" onclick="deleteEvent(event)">삭제</div>
    </div> --%>

    <script src="../js/createCalendar.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;
        var errMessage = "<%=errMessage%>";
        var year = "<%=year%>";
        var month = <%=month%>;
        var dateList = <%=dateList%>;

        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }
        
        createYear(year);
        createMonth(month);
        createDay(year, month, dateList);

        function yearMinusEvent() {
            year = parseInt(year) - 1;

            var monthSectionElement = document.getElementById('monthSection');
            var buttonList = monthSectionElement.getElementsByTagName('button');

            for (i = 0; i < buttonList.length; i++) {
                if (buttonList[i].style.backgroundColor === "rgb(218, 227, 243)") {
                    month = parseInt(buttonList[i].innerText);
                }
            }
            
            location.href = `../jspAction/dateSessionAction.jsp?year=\${year}&month=\${month}`;
        }
        function yearPlusEvent() {
            year = parseInt(year) + 1;

            var monthSectionElement = document.getElementById('monthSection');
            var buttonList = monthSectionElement.getElementsByTagName('button');

            for (i = 0; i < buttonList.length; i++) {
                if (buttonList[i].style.backgroundColor === "rgb(218, 227, 243)") {
                    month = parseInt(buttonList[i].innerText);
                }
            }

            location.href = `../jspAction/dateSessionAction.jsp?year=\${year}&month=\${month}`
        }

        function createDayEvent(e) {
            var year = document.getElementById('year').innerText;
            var month = parseInt(e.target.innerText);

            location.href = `../jspAction/dateSessionAction.jsp?year=\${year}&month=\${month}`
        }

        function openModalEvent(e) {
            var daySelectionElement = document.getElementById('daySection');
            var buttonList = daySelectionElement.getElementsByTagName('button');
            var targetDataDate = null;

            if(e.target === e.currentTarget){
                targetDataDate = e.target.getAttribute('data-date');

                //일자 색 변경
                for (i = 0; i < 31; i++) {
                    buttonList[i].style.backgroundColor = "white";
                }
                buttonList[e.target.dataset.value].style.backgroundColor = "rgb(218, 227, 243)";
            }else{
                targetDataDate = e.currentTarget.getAttribute('data-date');

                //일자 색 변경
                for (i = 0; i < 31; i++) {
                    buttonList[i].style.backgroundColor = "white";
                }
                buttonList[e.currentTarget.dataset.value].style.backgroundColor = "rgb(218, 227, 243)";
            }
            
            //모달창 오픈
            window.open(`modal.jsp?date=\${targetDataDate}`, '모달창', 'width=700, height=722');
        }
    </script>
</body>