<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%
connection newConec = new connection();
out.println(newConec.IdentifyConnection());
request.setCharacterEncoding("UTF-8");


if(request.getParameter("userid") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");
}
else if(request.getParameter("password") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("name") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("sex") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("job") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("address") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("age") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else if(request.getParameter("phone") == null)
{
	out.println("<script>alert('회원정보를 모두 입력하셔야 합니다!');history.back();</script>");

}
else
{
	boolean i = newConec.InsertUser(request.getParameter("userid"), request.getParameter("password"), request.getParameter("name"), request.getParameter("address"), request.getParameter("phone"), request.getParameter("sex"), request.getParameter("age"), request.getParameter("job"));
	if(i == false)
	{
		out.println("<script>alert('아이디가 중복됩니다!');history.back();</script>");
	}
	else
	{
		response.sendRedirect("login.jsp");

	}
}


%>