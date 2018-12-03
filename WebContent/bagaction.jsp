<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ include file="/Navbar.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	ResultSet rs_id, rs_stock;
	if(request.getParameter("delete")!=null)
	{
		query1 = "SELECT Retail_Name FROM shoppingbag WHERE Custom_Id = '" + session.getAttribute("id").toString() + "' and" + " Item_Id = '" + request.getParameter("delete") + "'";
	   	System.out.println(query1);
		pstmt1 = newConec.getConnection().prepareStatement(query1);
	    rs_id = pstmt1.executeQuery();
	    rs_id.next();
		//딜리트 
		newConec.delbag(request.getParameter("delete"), session.getAttribute("id").toString(), rs_id.getString(1));
		response.sendRedirect("bag.jsp"); 

	}
	else if(request.getParameter("item")!=null)
	{
		String order = "ordernum"+request.getParameter("item");

		
		if(request.getParameter(order)!=null)
		{
			query1 = "SELECT Retail_Name FROM shoppingbag WHERE Custom_Id = '" + session.getAttribute("id").toString() + "' and" + " Item_Id = '" + request.getParameter("item") + "'";
		   	System.out.println(query1);

			pstmt1 = newConec.getConnection().prepareStatement(query1);
		    rs_id = pstmt1.executeQuery();
		    rs_id.next();
			newConec.updateItemOnShoppingbag(request.getParameter(order), request.getParameter("item"), session.getAttribute("id").toString(),rs_id.getString(1));
			
		}
		response.sendRedirect("bag.jsp"); 

		
	}
	else
	{
		response.sendRedirect("main.jsp"); 
	}
	
	

 %>

