<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
ResultSet rs_retail;
query1 = "SELECT * FROM retailer";
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_retail = pstmt1.executeQuery();
%>
	 <div class="contain_box">
    <div class="sidenav">
     <a href="manager.jsp"><div class="sidenav_menu">재고 관리</div></a>
     <a href="manager_stat.jsp"><div class="sidenav_menu">통계</div></a>
    </div>
    <div class="sidecontent">
        <h2>매장 선택</h2>
        <form action="manager_stock.jsp" method="post" style="padding-top: 20px; padding-left: 10px;">
            <select name="retail">
            <%while(rs_retail.next()) {%>
            <option value="<%out.println(rs_retail.getString(1));%>"><%out.println(rs_retail.getString(1));%></option>
            <% }%>
            </select><br><br>
            <button type="submit">확인</button>
        </form>
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>