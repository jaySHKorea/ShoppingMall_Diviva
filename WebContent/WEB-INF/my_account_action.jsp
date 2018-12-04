<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/Navbar.jsp" %>
    
<%@ page import="phase3.connection" %>
<%
ResultSet rs_user;
query1 = "SELECT * FROM customer WHERE Id = '" + session.getAttribute("id").toString() + "'";
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_user = pstmt1.executeQuery();
rs_user.next();

	if(request.getParameter("password").length() > 0)
	{
		//비밀번호 변경
		 newConec.setPasswd(rs_user.getString(1), request.getParameter("password"));
		out.println("<script>alert('회원정보 및 패스워드가 변경되었습니다!');history.back();</script>");
	}
	else
	{
		boolean re = newConec.UpdateUser(request.getParameter("userid"), request.getParameter("name"), request.getParameter("address"), request.getParameter("phone"), request.getParameter("sex"), request.getParameter("age"), request.getParameter("job"));
		if(re == true)
		{
			out.println("<script>alert('회원정보가 변경되었습니다!');history.back();</script>");
		}
		else
		{
			out.println("<script>alert('회원정보가 변경되지 않았습니다!');history.back();</script>");
		}
	}



%>