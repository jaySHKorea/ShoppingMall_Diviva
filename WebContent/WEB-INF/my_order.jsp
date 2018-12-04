<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
ResultSet rs_user, rs_order, rs_item;
query1 = "SELECT * FROM customer WHERE Id = '" + session.getAttribute("id").toString() + "'";
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_user = pstmt1.executeQuery();
rs_user.next();

query1 = "SELECT * FROM ships WHERE Custom_Id = '" + session.getAttribute("id").toString() + "'";
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_order = pstmt1.executeQuery();
%>
	  <div class="contain_box">
    <div class="sidenav">
     <a href="my_account.jsp"><div class="sidenav_menu">내 계정</div></a>
    <a href="my_order.jsp"><div class="sidenav_menu">주문목록</div></a>
    </div>
    <div class="sidecontent">
            <h2>주문목록</h2>
    
    <div class="bag" style="overflow: auto; height: 300px;">

        <%
        while(rs_order.next()){
        	query1 = "SELECT * FROM item WHERE Id = " + rs_order.getString(1);
        	pstmt1 = newConec.getConnection().prepareStatement(query1);
        	rs_item = pstmt1.executeQuery();
        	rs_item.next();
        %>
        <div class="bag_content" style="border-bottom: 1px solid gray; max-height: 400px;">
		<div class ="bag_item">
		<strong><% out.println(rs_item.getString(2)); %></strong><br>
		<% out.println(rs_item.getString(3)); %>원<br>
		주문매장: <% out.println(rs_order.getString(7)); %>
		/ <% out.println(rs_order.getString(6)); %>
		</div>
		<div class ="bag_content_rev">
		개수: <% out.println(rs_order.getString(3)); %>
		</div>
		</div>
		<% } %>
        
    </div>
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>