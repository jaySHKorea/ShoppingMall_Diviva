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
      document.myForm.action='bagaction.jsp?item='+submit1+'&ordernum' + submit1+ '=' + document.getElementById('');
      document.myForm.submit();
  }
  function doOpenCheck(chk){
	    var obj = document.getElementsByName("update_check");
	    for(var i=0; i<obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	        }
	    }
	}

</script>

<div id="container">
<h1 style="font-family:'Godo';margin-top: 20px;">장바구니</h1>
<div class="bag">
<form action="bagaction.jsp"name = "myForm" method="post">
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
<input type="checkbox" name = "update_check" onclick="doOpenCheck(this);" value = "<%out.println(rs_item.getString(1));%>">
<strong><% out.println(rs_item.getString(2)); %></strong><br>
<% out.println(rs_item.getString(3)); %>원<br>
주문매장: <% out.println(rs_bag.getString(4)); %>

</div>
<div class ="bag_content_rev">
개수: <% out.println(rs_bag.getString(1)); %>
</div>
<div class = "bag_content_del"><a href="bagaction.jsp?delete=<%out.println(rs_bag.getString(2));%>">삭제</a></div>
</div>

<% } %>
수정할 주문수량: <input id="ordernum" name="ordernum" type="text" style="width: 50px;font-size: 20px; height: auto; border: 1px solid gray; margin-left: 30px; margin-right: 3px;">
<button class="btn2" style="font-size: 18px; margin-left: 20px; height: auto; " type="submit">수정하기</button>
</form>
</div>
<h1 style="font-family:'Godo';margin-top: 20px;">주문하기</h1>

<div class="bag">
<form action="ships.jsp"name = "myForm" method="post">
<%
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
<input id="ordernum<%out.println(rs_item.getString(1));%>" name="ordernum<%out.println(rs_item.getString(1));%>" type="text" style="width: 30px; margin-left: 10px; margin-right: 3px;">
<button type="button" onclick='myRev(<%out.println(rs_item.getString(1));%>)'>수정</button>
</div>
<div class = "bag_content_del"><a href="bagaction.jsp?delete=<%out.println(rs_bag.getString(2));%>">삭제</a></div>
</div>
<% } %>
<button class="btn2" style="font-size: 20px; height: auto; margin-left: 40%;" type="submit">주문하기</button>
</form>
</div>
</div>


<%@ include file="/footer.jsp" %>