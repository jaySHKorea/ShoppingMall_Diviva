<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>

<div id="container">
<div class = "item_info">
	<div class = "item_infoA">
	<% String name = request.getParameter("item");
		out.println(name);
	%>
	</div>
	<!-- Id INT NOT NULL,
Name VARCHAR(15) NOT NULL,
Price INT NOT NULL,
Exp INT,
Import VARCHAR(15),
PL_Id INT NOT NULL ,
Sub_category VARCHAR(15) NOT NULL ,
PRIMARY KEY (Id) -->
<div class="item_infoB">
	<%
   	ResultSet rs_item, rs_stock, rs_stock2;
	query1 = "SELECT * FROM item WHERE name ='" + request.getParameter("item")+ "'";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_item = pstmt1.executeQuery();
    rs_item.next();
    query1 = "SELECT * FROM stored_in WHERE item_Id = " + rs_item.getString(1);
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_stock = pstmt1.executeQuery();
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_stock2 = pstmt1.executeQuery();

   		out.println("가격:  " + rs_item.getString(3) +"원<br>");
   		out.println("유통기한:  구매일로부터 " + rs_item.getString(4) +"일<br>");
   		if(rs_item.getString(5).length() != 0)
   		{
   	   		out.println("수입처:  " + rs_item.getString(5) +"<br>");
   		}
   		out.println("매장별 재고");
   		out.println("<div style=\"display: flex; width: 100%; padding-bottom: 30px;\">");
   		out.println("<div style=\"overflow:auto; font-size: 12px; flex: 1; height: 200px; border: 1px solid lightgray; margin-top: 10px;\">");
   		while(rs_stock.next()){
   	   		out.println(rs_stock.getString(3) +" : "+ rs_stock.getString(2) +"개<br>" );
   		}
   		out.println("</div>");
   		out.println("<div style=\"flex: 3; \">");%>
        <form action="insertBag.jsp?item=<%=request.getParameter("item")%>" method="post" style="padding-top: 20px; padding-left: 10px; margin-left: 10px;">
        <label for="ordernum">주문개수</label>
        <input type="text" id="ordernum"/><br>
        <label for="retailer">주문매장</label>
            <select name="retailer">
            <%
            while(rs_stock2.next()){
            	if(!rs_stock2.getString(2).equals("0"))
            	{
                	out.println("<option value=\""+ rs_stock2.getString(3) +"\">"+rs_stock2.getString(3) + "</option>");
            	}
            }
            %>
            </select><br><br>
        <button type="button submit" class="btn btn-primary">장바구니에 넣기</button>
    	</form>
    	<% 
   		out.println("</div>");

	
	%>
</div>
		
</div>
</div>

<%@ include file="/footer.jsp" %>
