<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>

<script type="text/javascript">
  function mySubmit(index) {
    
    if (index == 2) {
        document.myForm.action='ships.jsp';
      }
    
    document.myForm.submit();
  }
  function myRev(item1) {
	  var submit1 = item1;
	  var lolz = document.getElementById('lolz').value;
      document.myForm.action='bagaction.jsp?item='+submit1+'&ordernum'+submit1+'='+lolz;
      document.myForm.submit();
  }
</script>

<div id="container">
<h1 style="font-family:'Godo';margin-top: 20px;">장바구니</h1>

<div class="bag">
<form name = "myForm" method="post">

<%
ResultSet rs_bag, rs_item;
query1 = "SELECT * FROM SHOPPINGBAG WHERE Custom_Id ='" + session.getAttribute("id").toString()+ "'";
pstmt1 = newConec.getConnection().prepareStatement(query1);
System.out.println(query1);

rs_bag = pstmt1.executeQuery();

while(rs_bag.next()){
	query1 = "SELECT * FROM item WHERE Id = " + rs_bag.getString(2);
	pstmt1 = newConec.getConnection().prepareStatement(query1);
	rs_item = pstmt1.executeQuery();
	rs_item.next();
%>
<div class="bag_content" style="border-bottom: 1px solid gray;">
<div class ="bag_item">
<input type="checkbox" name = "item_check" value = "<%out.println(rs_item.getString(1));%>">
<strong><% out.println(rs_item.getString(2)); %></strong><br>
<% out.println(rs_item.getString(3)); %>원<br>
주문매장: <% out.println(rs_bag.getString(4)); %>

</div>
<div class ="bag_content_rev">
개수: <% out.println(rs_bag.getString(1)); %>
<input id="lolz" name="ordernum<%out.println(rs_item.getString(1));%>" type="text" style="width: 30px; margin-left: 10px; margin-right: 3px;">
<button onclick='myRev(<%out.println(rs_item.getString(1));%>)'>수정</button>
</div>
<div class = "bag_content_del"><a href="bagaction.jsp?delete=<%out.println(rs_bag.getString(2));%>">삭제</a></div>
</div>

<% } %>
</form>
<div class="btn2" onclick='mySubmit(2)'>주문하기</div>
</div>
</div>


<%@ include file="/footer.jsp" %>
