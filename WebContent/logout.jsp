<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>


<% 
connection newConec = new connection();
out.println(newConec.IdentifyConnection());


session.removeAttribute("id");

response.sendRedirect("main.jsp"); 

%>

<%@ include file="/footer.jsp" %>