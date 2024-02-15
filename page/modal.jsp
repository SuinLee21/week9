<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<% 
    String errMessage = "";
    String date = request.getParameter("date");
    boolean isLogginIn = true;
    ArrayList<ArrayList<String>> scheduleDataList = new ArrayList<ArrayList<String>>();

    try{
        request.setCharacterEncoding("utf-8");

        if(session.getAttribute("idx") == null){
            throw new Exception("접근 권한이 없습니다."); //더 이상 아래 코드 실행 안 되게.
        }

        if(session.getAttribute("idx") != null){

            if(year == null){
                throw new Exception("year 값에 문제가 생겼습니다.");
            }
            if(month == null){
                throw new Exception("month 값에 문제가 생겼습니다.");
            }

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin");

            String sql = "SELECT * FROM schedule WHERE user_idx=? AND date=?";
            PreparedStatement query = conn.prepareStatement(sql);
            query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.setInt(2, date);
            ResultSet result = query.executeQuery();

            while(result.next()){
                String scheduleIdx = String.valueOf(result.getInt("idx"));
                String time = String.valueOf(result.getInt("time"));
                String contents = result.getString("contents");

                ArrayList<String> temp = new ArrayList<String>();
                temp.add("\"" + scheduleIdx + "\"");
                temp.add("\"" + time + "\"");
                temp.add("\"" + contents + "\"");

                scheduleDataList.add(temp);
            }
        }
    } catch (Exception e) {
        errMessage = e.getMessage();
        isLogginIn = false;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>modal</title>
    <link rel="stylesheet" type="text/css" href="../css/schedule.css">
</head>

<body>
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

    <div id="modal" class="modal">
        <h2 id="clickedDate"></h2>
        <h1>할 일</h1>
        <div id="allSchedule"></div>
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
    <script>
        var isLogginIn = <%=isLogginIn%>;
        var errMessage = "<%=errMessage%>";
        var scheduleDataList = <%=scheduleDataList%>;
        var month = <%=month%>;

        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }

        function openModalEvent(e) {
            var modalElement = document.getElementById('modal');
            var clickedDateElement = document.getElementById('clickedDate');
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

            //data-date 값 clickedDate에 삽입
            clickedDateElement.innerText = targetDataDate;

            //data-date 값 input type='hidden'에 삽입
            document.getElementById('hiddenDate').value = targetDataDate;

            //option 생성
            createOption(idOfWriteHourSelect, idOfWriteMinuteSelect)

            for(var i = scheduleDataList.length - 1; i >= 0; i--) {
                createSchedule(i, targetDataDate, scheduleDataList);
            }
        }

        function modifyEvent(e) {
            var allScheduleElement = document.getElementById('allSchedule');
            var scheduleSectionList = allScheduleElement.children;
            var scheduleSectionChildList = null;
            var scheduleTime = null;
            var hTwoList = null;
            var textareaList = null;
            var selectList = null;

            for (var i = 0; i < scheduleSectionList.length; i++) {
                scheduleSectionChildList = scheduleSectionList[i].children;

                for (var j = 0; j < scheduleSectionChildList.length; j++) {
                    if (j === 0) {
                        scheduleSectionChildList[j].style.display = "flex";
                    } else if (j === 1) {
                        scheduleSectionChildList[j].style.display = "none";
                    } else {
                        scheduleSectionChildList[j].style.display = "block";
                    }
                }

                if(e.target.parentElement === scheduleSectionList[i]){
                    hTwoList = scheduleSectionList[i].getElementsByTagName('h2');
                    textareaList = scheduleSectionList[i].getElementsByTagName('textarea');
                    selectList = scheduleSectionList[i].getElementsByTagName('select');

                    for (var k = 0; k < scheduleSectionChildList.length; k++) {
                        if (k !== 1) {
                            scheduleSectionChildList[k].style.display = "none";
                        } else {
                            scheduleSectionChildList[k].style.display = "flex";
                        }
                    }

                    textareaList[0].value = hTwoList[0].innerText;
                    createOption(selectList[0].id, selectList[1].id);

                    scheduleTime = scheduleSectionChildList[0].children[0].innerText;

                    selectList[0].options[parseInt(scheduleTime.substr(0, 2)) + 1].selected = true;
                    selectList[1].options[parseInt(scheduleTime.substr(4, 2)) + 1].selected = true;
                }
            }                
        }

        function deleteEvent(e) {
            if (confirm('정말 삭제하겠습니까?')) {
                location.href = '../jspAction/scheduleDeleteAction.jsp?scheduleIdx=' + e.target.getAttribute('data-value');
            }
        }

        function cancelEvent(e) {
            e.preventDefault();

            var scheduleSectionElement = e.target.parentElement.parentElement;
            var childList = scheduleSectionElement.children;

            for (i = 0; i < childList.length; i++) {
                if (i === 0) {
                    childList[i].style.display = "flex";
                } else if (i === 1) {
                    childList[i].style.display = "none";
                } else {
                    childList[i].style.display = "block";
                }
            }
        }

    </script>
</body>