<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phase3.connection" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
    
<!DOCTYPE html>
<!-- Template by quackit.com -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href='//cdn.rawgit.com/young-ha/webfont-archive/master/css/Godo.css' rel='stylesheet' type = 'text/css'>
	<title>Diviva.com</title>
	<link href='./static/style.css' rel='stylesheet' type = 'text/css'>


	<!--
	<script type="text/javascript">
		/* =============================
		This script generates sample text for the body content. 
		You can remove this script and any reference to it. 
		 ============================= */
		var bodyText=["The smaller your reality, the more convinced you are that you know everything.", "If the facts don't fit the theory, change the facts.", "The past has no power over the present moment.", "This, too, will pass.", "</p><p>You will not be punished for your anger, you will be punished by your anger.", "Peace comes from within. Do not seek it without.", "<h3>Heading</h3><p>The most important moment of your life is now. The most important person in your life is the one you are with now, and the most important activity in your life is the one you are involved with now."]
		function generateText(sentenceCount){
			for (var i=0; i<sentenceCount; i++)
			document.write(bodyText[Math.floor(Math.random()*7)]+" ")
		}
	</script>	
	-->
</head>

<body>
<%
	connection newConec = new connection();
	out.println(newConec.IdentifyConnection());
   	PreparedStatement pstmt1;
   	ResultSet rs_main, rs_sub;
%>
	<a href="main.jsp"><header id="header"><p>Diviva.com</p></header></a>
	
	<div id=menu class="menubar">
   <ul>
   	<%
   	String query1 = "SELECT DISTINCT Main_category FROM category";
   	pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_main = pstmt1.executeQuery();
    
    while(rs_main.next()){
    	String temp = rs_main.getString(1);
    	out.println("<li>");
    	out.println("<a href=\"#\" id= \"current\">" + temp + "</a>");
   		out.println("<ul>");
   		query1 = "SELECT DISTINCT * FROM category WHERE main_category='" + rs_main.getString(1) +"'" ;
   	    pstmt1 = newConec.getConnection().prepareStatement(query1);
   	    rs_sub = pstmt1.executeQuery();
   		while(rs_sub.next()){

   				out.println("<li><a href=\"category.jsp?category=" + rs_sub.getString(1)+ "\">");
   	   	   		out.println(rs_sub.getString(1) + "</a></li>");
   			
   		}
   		out.println("</ul>");
   		out.println("</li>");
    }
   	%>
     
      <li><a href="#">Event</a></li>
      <% 
      if(session.getAttribute("id") == null)
      {
    	out.println("<li><a href=\"login.jsp\">로그인</a></li>");
    	out.println("<li><a href=\"register.jsp\">회원가입</a></li>");
      }
      else
      {
      	out.println("<li><a href=\"logout.jsp\">로그아웃</a></li>");
      }
    %>
   </ul>
</div>