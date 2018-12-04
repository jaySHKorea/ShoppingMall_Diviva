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
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
   

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
      PreparedStatement pstmt1;
      ResultSet rs_main, rs_sub;
%>
   <header id="header">
   <a href="main.jsp">
   <p>Diviva.com</p></a>
   
   </header>
   
   <div id=menu class="menubar">
   <ul>
      <%
      String query1 = "SELECT DISTINCT Main_category FROM category";
      pstmt1 = newConec.getConnection().prepareStatement(query1);
    rs_main = pstmt1.executeQuery();
  
       while(rs_main.next()){
           String temp = rs_main.getString(1);
           out.println("<li>");
           if(session.getAttribute("id") != null)
          {
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
             }
             else
             {
                 out.println("<a href=\"login.jsp\" id= \"current\">" + temp + "</a>");

             }
             out.println("</li>");
        
    }
      %>
      
      <% 
      if(session.getAttribute("id") == null)
      {
       out.println("<li><a href=\"login.jsp\">로그인</a></li>");
       out.println("<li><a href=\"register.jsp\">회원가입</a></li>");
      }
      else if(session.getAttribute("id").equals("admin"))
      {
         out.println("<li><a href=\"manager.jsp\">관리페이지</a></li>");
        out.println("<li><a href=\"logout.jsp\">로그아웃</a></li>");
      }
      else
      {
         out.println("<li><a href=\"bag.jsp\">장바구니</a></li>");
       out.println("<li><a href=\"my_account.jsp\">마이페이지</a></li>");
         out.println("<li><a href=\"logout.jsp\">로그아웃</a></li>");
      }
      if(session.getAttribute("id") != null)
      {
    %>
    <li>
     <form action="search.jsp" method="post">
       <div id = "search">
         <input type = "text" name = "searchtext" placeholder = "검색어 입력">
         <button type="button submit">검색</button>
      </div>
   </form></li><%} %>
   </ul>
</div>