<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<%
if(session.getAttribute("id") != null)
{
	ResultSet rs_user;
	query1 = "SELECT * FROM Customer WHERE id = '" + session.getAttribute("id") + "'";
	System.out.println(query1);
	pstmt1 = newConec.getConnection().prepareStatement(query1);
	rs_user = pstmt1.executeQuery();
	rs_user.next();
	int num = Integer.parseInt(rs_user.getString(9));
	if(num < 1)
	{%>
		<div class ="newcome">
		<div class="newcomeA">
		<div class="newcomeA_1">신규 고객을 위한<br>추천상품!!</div>
		</div>
		<div class="newcomeB">
		<a href = "item.jsp?item=실속 산지 사과 5KG"><img src = "photo/1.jpg" width= "200px" height="200px"><h3>실속 산지 사과 5KG</h3></a>
		<a href = "item.jsp?item=감말랭이 1KG"><img src = "photo/10.jpg" width= "200px" height="200px"><h3 style="left:30px">감말랭이 1KG</h3></a>
		<a href = "item.jsp?item=익산 부추 300G"><img src = "photo/20.jpg" width= "200px" height="200px"><h3 >익산 부추 300G</h3></a>
		<a href = "item.jsp?item=구이용 버섯 모둠"><img src = "photo/30.jpg" width= "200px" height="200px"><h3 >구이용 버섯 모둠</h3></a>
		</div>
		</div><% 
	}
}

%>
<div style="width: 100%;min-height: 300px;display:flex;">
	<div style="flex: 1; height: auto;"><img src = "photo/12.jpg" width= "100%" height="auto"></div>
	<div style="flex: 1; height: auto;"><img src = "photo/18.jpg" width= "100%" height="auto"></div>
	<div style="flex: 1; height: auto;"><img src = "photo/40.jpg" width= "100%" height="auto"></div>
	<div style="flex: 1; height: auto;"><img src = "photo/44.jpg" width= "100%" height="auto"></div>
	
</div>
<%@ include file="/footer.jsp" %>