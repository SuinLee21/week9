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
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "suin", "suin");

            String sql = "SELECT * FROM schedule WHERE user_idx=? AND date=?";
            PreparedStatement query = conn.prepareStatement(sql);
            query.setInt(1, Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
            query.setString(2, date);
            ResultSet result = query.executeQuery();

            while(result.next()){
                String scheduleIdx = String.valueOf(result.getInt("idx"));
                String time = result.getString("time");
                String contents = result.getString("contents");

                ArrayList<String> temp = new ArrayList<String>();
                temp.add("\"" + scheduleIdx + "\"");
                temp.add("\"" + time + "\"");
                temp.add("\"" + date + "\"");
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
    <script src="../js/createSchedule.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;
        var errMessage = "<%=errMessage%>";
        var scheduleDataList = <%=scheduleDataList%>;
        var date = "<%=date%>";
        var idOfWriteHourSelect = document.getElementById('writeHourSelect').id;
        var idOfWriteMinuteSelect = document.getElementById('writeMinuteSelect').id;

        scheduleDataList.sort((a, b) => a[1] - b[1]);
        if(!isLogginIn){
            alert(errMessage);
            location.href = "../page/login.html";
        }

        for(var i = 0; i < scheduleDataList.length; i++) {
            createSchedule(i, scheduleDataList);
        }

        document.getElementById('clickedDate').innerText = date;
        document.getElementById('hiddenDate').value = date;

        createOption(idOfWriteHourSelect, idOfWriteMinuteSelect)

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
                location.href = `../jspAction/scheduleDeleteAction.jsp?scheduleIdx=\${e.target.getAttribute('data-value')}&date=\${date}`;
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