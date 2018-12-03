<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>

<%
	connection newConec = new connection();
	out.println(newConec.IdentifyConnection());
   	PreparedStatement pstmt1;
   	ResultSet rs_id;
   	String query1 = "SELECT * FROM item WHERE name ='" + request.getParameter("item")+ "'";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_id = pstmt1.executeQuery();
	System.out.println(request.getParameter("retailer").length());

   	if(request.getParameter("retailer").length() < 0)
   	{
   		out.println("<script>alert('주문매장 설정을 하지 않으셨습니다!');history.back();</script>");
   		}
   	else
   	{
/*    		newConec.addItemOnItem(request.getParameter("ordernum"), rs_id.getString(1), session.getId());
 */   }
%>

