<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>


<% 
connection newConec = new connection();
out.println(newConec.IdentifyConnection());

if(request.getParameter("userid")==null)
{
	out.println("<script>alert('로그인정보를 모두 입력하셔야 합니다!');history.back();</script>");
}
else if(request.getParameter("password")==null)
{
	out.println("<script>alert('로그인정보를 모두 입력하셔야 합니다!');history.back();</script>");
}
else if(newConec.InUser(request.getParameter("userid"), request.getParameter("password"))==false)
{
	out.println("<script>alert('아이디 또는 비밀번호가 틀립니다!');history.back();</script>");
}
else
{
	session.setAttribute("id", request.getParameter("userid").toString());
	response.sendRedirect("main.jsp"); 

}







%>

<%@ include file="/footer.jsp" %>