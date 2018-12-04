<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ include file="/Navbar.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

   	ResultSet rs_id, rs_stock;
   	query1 = "SELECT * FROM item WHERE id ='" + request.getParameter("item")+ "'";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_id = pstmt1.executeQuery();
    rs_id.next();
	System.out.println(request.getParameter("retailer"));
	System.out.println(request.getParameter("ordernum"));
	System.out.println(rs_id.getString(1));
	
	query1 = "SELECT * FROM stored_in WHERE Retail_Name = '" + request.getParameter("retailer") + "' and" + " Item_Id = '" + request.getParameter("item") + "'";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_stock = pstmt1.executeQuery();
    rs_stock.next();
    
    int ornum = Integer.parseInt(request.getParameter("ordernum"));
    int stnum = Integer.parseInt(rs_stock.getString(2));


	if(session.getAttribute("id")==null)
	{
   		out.println("<script>alert('로그인 후 이용해주세요!');history.back();</script>");
	}
	else if(request.getParameter("retailer").length() <= 0)
   	{
   		out.println("<script>alert('주문매장 설정을 하지 않으셨습니다!');history.back();</script>");
   	}
   	else if(request.getParameter("ordernum") == null)
   	{
   		out.println("<script>alert('주문개수 설정을 하지 않으셨습니다!');history.back();</script>");
   	}
   	else if(ornum > stnum)
   	{
   		out.println("<script>alert('주문개수가 재고보다 많습니다!');history.back();</script>");
   	}
   	else
   	{
		newConec.addItemOnItem(request.getParameter("ordernum"), rs_id.getString(1), session.getAttribute("id").toString(), request.getParameter("retailer"));
		%>
		<div id = "container" style="text-align: center; padding-top: 100px; font-size: 28px;">
		물품이 장바구니에 성공적으로 담겼습니다!<br><br>
		<a href = "main.jsp"><div class= "btn2">메인으로 가기</div></a>
		<a href = "main.jsp"><div class= "btn2">계속 쇼핑하기</div></a>
		</div>
		<% 
   	}
%>
<%@ include file="/footer.jsp" %>

