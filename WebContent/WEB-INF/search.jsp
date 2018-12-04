<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>

<div id="container">
	<div class = "search_name">
	<% 
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("searchtext");
		out.println("검색 단어 : \""+name+"\"");
	%>
	</div>
	<%
   	ResultSet rs_category;
	query1 = "SELECT * FROM item WHERE name like '"+"%" + request.getParameter("searchtext")+"%"+"'";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_category = pstmt1.executeQuery();

    while(rs_category.next()){
    	out.println("<a href = \"item.jsp?item=" + rs_category.getString(2)+"\">");
   		out.println("<div class=\"item\">");
   		out.println("<div class=\"item_img\"></div>");
      	out.println("<div class=\"item_content\">");
   		out.println(rs_category.getString(2) +"<br>"+ rs_category.getString(3) +"원</div>");
   		out.println("</div></a>");
    }
	%>
		
</div>

<%@ include file="/footer.jsp" %>