<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    String year = request.getParameter("year");
    String month = request.getParameter("month");

    request.setCharacterEncoding("utf-8");

    session.setAttribute("year", year);
    session.setAttribute("month", month);
%>