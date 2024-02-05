<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<% 
    request.setCharacterEncoding("utf-8");

    boolean isLogginIn = false;
    ArrayList<ArrayList<String>> scheduleDataList = new ArrayList<ArrayList<String>>();

    if(session.getAttribute("idx") != null){
        isLogginIn = true;

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin");

        String sql = "SELECT * FROM schedule";
        PreparedStatement query = conn.prepareStatement(sql); 
        ResultSet result = query.executeQuery();

        while(result.next()){
            String scheduleIdx = result.getString("idx");
            String userIdx = result.getString("user_idx");
            String hour = String.valueOf(result.getInt("hour"));
            String minute = String.valueOf(result.getInt("minute"));
            String date = result.getString("date"); 
            String contents = result.getString("contents");

            ArrayList<String> temp = new ArrayList<String>();
            temp.add("\"" + scheduleIdx + "\"");
            temp.add("\"" + userIdx + "\"");
            temp.add("\"" + hour + "\"");
            temp.add("\"" + minute + "\"");
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
        <div class="closeButton" onclick="closeModalEvent()">X</div>
        <div id="allSchedule">
            <div class="scheduleSection">
                <div id="divSchedule" class="schedule">
                    <div class="scheduleTime">14시 39분</div>
                    <h2 class="scheduleText">정적데이터입니다.</h2>
                </div>
                <form id="hiddenSchedule" class="hiddenSchedule"
                    onsubmit="checkValidityEvent({hour: true, minute: true, text: true},
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
                </form>
                <div id="modify" class="modify" onclick="modifyEvent(event)">수정</div>
                <a id="delete" class="delete">삭제</a>
            </div>
        </div>
        <form action="../jspAction/createScheduleAction.jsp" class="scheduleWritingSection"
            onsubmit="return checkValidityEvent({hour: true, minute: true, text: true},
            {idOfHourSelect: 'writeHourSelect', idOfMinuteSelect: 'writeMinuteSelect', idOfTextarea: 'scheduleTextarea'})">
            <select id="writeHourSelect" class="writeSelect" name="writeHourSelect">
                <option value="">시</option>
            </select>
            <select id="writeMinuteSelect" class="writeSelect" name="writeMinuteSelect">
                <option value="">분</option>
            </select>
            <textarea maxlength="100" id="scheduleTextarea" class="scheduleInput"
                placeholder="내용을 입력하세요.(100자 이하)" name="scheduleTextarea"></textarea>
            <input type="hidden" id="hiddenDate" name="hiddenDate">
            <input type="submit" class="submitButton" value="작성">
        </form>
    </div>

    <script src="../js/checkValidity.js"></script>
    <script src="../js/createCalendar.js"></script>
    <script src="../js/createSchedule.js"></script>
    <script src="../js/functions.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;
        var scheduleDataList = <%=scheduleDataList%>;

        if(isLogginIn){
            function openModalEvent(e) {
                var modalElement = document.getElementById('modal');
                var daySelectionElement = document.getElementById('daySection');
                var buttonList = daySelectionElement.getElementsByTagName('button');
                var idOfWriteHourSelect = document.getElementById('writeHourSelect').id;
                var idOfWriteMinuteSelect = document.getElementById('writeMinuteSelect').id;
                var hiddenDateElement = document.getElementById('hiddenDate');
                var targetDataDate = null;

                //모달창 자식 생성 및 모달창 diplay: block
                var newAllScheduleDiv = document.createElement('div');
                newAllScheduleDiv.setAttribute('id', 'allSchedule');
                modal.appendChild(newAllScheduleDiv);

                document.getElementById('modal').style.display = "block";

                if(e.target === e.currentTarget){
                    targetDataDate = e.target.getAttribute('data-date');
                    //data-date 값 삽입
                    document.getElementById('hiddenDate').value = targetDataDate;

                    //일자 색 변경
                    for (i = 0; i < 31; i++) {
                        buttonList[i].style.backgroundColor = "white";
                    }
                    buttonList[e.target.dataset.value].style.backgroundColor = "rgb(218, 227, 243)";
                }else{
                    targetDataDate = e.currentTarget.getAttribute('data-date');
                    for (i = 0; i < 31; i++) {
                        buttonList[i].style.backgroundColor = "white";
                    }
                    buttonList[e.currentTarget.dataset.value].style.backgroundColor = "rgb(218, 227, 243)";
                }

                //data-date 값 삽입
                document.getElementById('hiddenDate').value = targetDataDate;

                //option 생성
                createOption(idOfWriteHourSelect, idOfWriteMinuteSelect)

                for(var i = 0; i < scheduleDataList.length; i++) {
                    createSchedule(i, targetDataDate, scheduleDataList);
                }
            }

            function closeModalEvent() {
                document.getElementById('allSchedule').remove();
                document.getElementById('modal').style.display = "none";
            }          
        }else{
            alert('접근 권한이 없습니다.');
            location.href = "../page/login.html";
        }
        createYear();
        createMonth();
        createDay(date.getMonth() + 1, true, scheduleDataList);
    </script>
</body>