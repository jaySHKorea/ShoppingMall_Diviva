<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ include file="/Navbar.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	ResultSet rs_id, rs_stock;
	StringBuffer return_str = new StringBuffer();
	return_str.append("manager_stock.jsp?retail=");
	return_str.append(request.getParameter("retail"));
	return_str.append("%0D%0A");

	if(request.getParameter("update_check")!=null)
	{
		String order = "ordernum";
		System.out.println(return_str.toString());

		if(request.getParameter(order)!=null)
		{
			boolean i = newConec.addStock(request.getParameter("retail"), request.getParameter("update_check"), request.getParameter(order));
			if(i == true)
			{
				out.println("<script>alert('상품 주문이 성공했습니다!'); </script>");
				response.sendRedirect("manager.jsp"); 

			}
			else
			{
				out.println("<script>alert('상품 주문이 실패했습니다!');history.back();</script>");

			}
		}

	}
	else
	{
		response.sendRedirect("manager.jsp"); 
	}
	
	

 %>

