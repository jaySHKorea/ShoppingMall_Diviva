<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<!-- import JDBC package -->
<!-- [IMPORTANT] Complete your scripting. -->\
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<!--<jsp:useBean id="phase3" class="phase3.connection" scope="page" />-->
<html>
<head>
<meta charset="UTF-8">
<title>Connection</title>
</head>
<body>
<%
	connection newConec = new connection();
	out.println(newConec.IdentifyConnection());
%>
</body>
</html>