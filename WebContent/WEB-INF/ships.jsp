<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ include file="/Navbar.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	if(request.getParameterValues("item_check") == null)
	{
		out.println("<script>alert('상품을 체크하셔야 합니다!');history.back();</script>");
		response.sendRedirect("bag.jsp"); 
	}

	String[] items= request.getParameterValues("item_check");
	ResultSet rs_id, rs_user, rs_stock;
	/* addship delbag delstock */
	int i = 0;
	try{
		if(items[i] == null)
		{
			response.sendRedirect("bag.jsp"); 
		}
		while(items[i] !=null)
		{
			System.out.println(items[i]);
			
			query1 = "SELECT * FROM shoppingbag WHERE Custom_Id = '" + session.getAttribute("id").toString() + "' and" + " Item_Id = '" + items[i] + "'";
		   	System.out.println("ships1: " + query1);
			pstmt1 = newConec.getConnection().prepareStatement(query1);
		    rs_id = pstmt1.executeQuery();
		    rs_id.next();
		    
		    query1 = "SELECT * FROM customer WHERE Id = '" + session.getAttribute("id").toString() + "'";
		   	System.out.println("ships2: " + query1);
			pstmt1 = newConec.getConnection().prepareStatement(query1);
		    rs_user = pstmt1.executeQuery();
		    rs_user.next();
		    
		    query1 = "SELECT * FROM stored_in WHERE Retail_Name = '" + rs_id.getString(4) + "' and" + " Item_Id = '" + rs_id.getString(2) + "'";
		   	System.out.println("ships3: " + query1);
		    pstmt1 = newConec.getConnection().prepareStatement(query1);
		  	rs_stock = pstmt1.executeQuery();
		    rs_stock.next();
		    
		    int ornum = Integer.parseInt(rs_id.getString(1));
		    int stnum = Integer.parseInt(rs_stock.getString(2));
		    if(ornum > stnum)
		   	{
		   		out.println("<script>alert('주문개수가 재고보다 많습니다!');history.back();</script>");
		   	}
		    else
		    {
		    	/*  addship */
				boolean i1 = newConec.addship(rs_id.getString(2),rs_id.getString(1),rs_id.getString(3),rs_user.getString(4), rs_user.getString(3), rs_id.getString(4));
			   	System.out.println("add item to ship: " + i1);
			   	if(i1 == true)
			   	{
			   		/*  delbag */
					i1 = newConec.delbag(rs_id.getString(2), rs_user.getString(1), rs_id.getString(4));
				   	System.out.println("delete item from bag: " + i1);
				   	
				   	if(i1 == true)
				   	{
				   		i1 = newConec.delstock(rs_id.getString(4), rs_id.getString(2), rs_id.getString(1));
					   	System.out.println("delete item from stock: " + i1);
				   	}
			   	}
				
				/*  delstock */
				
				System.out.println("end!");
				i++;

		    }
		    
			
		}
	}catch(ArrayIndexOutOfBoundsException e)
	{
		%>
		
		<div id = "container" style="text-align: center; padding-top: 100px; font-size: 28px;">
		구매해 주셔서 감사합니다<br><br>
		<a href = "main.jsp"><div class= "btn2">메인으로 가기</div></a>
		</div>
		
		<% 
		
	}
	

 %>
 
 <%@ include file="/footer.jsp" %>
 

