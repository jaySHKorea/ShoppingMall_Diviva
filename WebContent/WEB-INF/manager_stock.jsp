<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
request.setCharacterEncoding("UTF-8");
ResultSet rs_stock, rs_item;
System.out.println(request.getParameter("retail"));
String retail1 = request.getParameter("retail").substring(0, request.getParameter("retail").length()-2);
System.out.println(retail1);
query1 = "SELECT * FROM STORED_IN WHERE Retail_Name = '" + retail1 + "'";
System.out.println(query1);
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_stock = pstmt1.executeQuery();
rs_stock.next();
%>
<script type="text/javascript">
  
  function doOpenCheck(chk){
	    var obj = document.getElementsByName("update_check");
	    for(var i=0; i<obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	        }
	    }
	}

</script>
	 <div class="contain_box">
    <div class="sidenav">
      <a href="manager.jsp"><div class="sidenav_menu">재고 관리</div></a>
     <a href="manager_stat.jsp"><div class="sidenav_menu">통계</div></a>
    </div>
    <div class="sidecontent">
        <h2>재고 관리</h2><hr>
        <h3>모든 상품 재고</h3>
   
        <form action="stock_action.jsp?retail=<%out.println(request.getParameter("retail"));%>"name = "myForm" method="post">
        <div class="bag" style="overflow: auto; height: 200px;">
        <%
        while(rs_stock.next()){
        	query1 = "SELECT * FROM item WHERE Id  = " + rs_stock.getString(1);
        	System.out.println(query1);
        	pstmt1 = newConec.getConnection().prepareStatement(query1);
        	rs_item = pstmt1.executeQuery();
        	rs_item.next();
        %>
        <div class="bag_content" style="border-bottom: 1px solid gray; height: 30px;">
		<div class ="bag_item" style="height: 30px; padding-top: 8px;">		
		<input type="checkbox" name = "update_check" onclick="doOpenCheck(this);" value = "<%out.println(rs_item.getString(1));%>">
		<strong><% out.println(rs_item.getString(2)); %></strong><br>
		</div>
		<div class ="bag_content_rev" style="height: 30px;padding-top: 8px;">
		개수: <% out.println(rs_stock.getString(2)); %>
		</div>
		</div>
		<% } %>
      	</div>
      	<h3>재고가 모자란 상품</h3>
      	<div class="bag" style="overflow: auto; height: 200px;">
        <%
        query1 = "SELECT * FROM STORED_IN WHERE Retail_Name = '" + retail1 + "' and num = 0";
        System.out.println(query1);
        pstmt1 = newConec.getConnection().prepareStatement(query1);
        rs_stock = pstmt1.executeQuery();
        rs_stock.next();
        while(rs_stock.next()){
        	query1 = "SELECT * FROM item WHERE Id  = " + rs_stock.getString(1);
        	System.out.println(query1);
        	pstmt1 = newConec.getConnection().prepareStatement(query1);
        	rs_item = pstmt1.executeQuery();
        	rs_item.next();
        %>
        <div class="bag_content" style="border-bottom: 1px solid gray; height: 30px;">
		<div class ="bag_item" style="height: 30px; padding-top: 8px;">		
		<input type="checkbox" name = "update_check" onclick="doOpenCheck(this);" value = "<%out.println(rs_item.getString(1));%>">
		<strong><% out.println(rs_item.getString(2)); %></strong><br>
		</div>
		<div class ="bag_content_rev" style="height: 30px;padding-top: 8px;">
		개수: <% out.println(rs_stock.getString(2)); %>
		</div>
		</div>
		<% } %>
      	</div>
      	<div style="position: fixed; top: 400px; left: 20px;">
      	<hr>
      	주문수량: <input id="ordernum" name="ordernum" type="text" style="width: 50px;font-size: 20px; height: auto; border: 1px solid gray; margin-left: 30px; margin-right: 3px;">
		<br><button class="btn2" style="font-size: 18px; margin-left: 20px; height: auto; " type="submit">주문하기</button>
		</div>
		</form>
		
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>