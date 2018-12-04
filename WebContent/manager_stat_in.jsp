<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
request.setCharacterEncoding("UTF-8");
System.out.println("request: "+ request.getParameter("stat"));
String [] items = newConec.sell(request.getParameter("stat"));
int i;
int n = 0;
%>
	 <div class="contain_box">
    <div class="sidenav">
     <a href="manager_stock.jsp"><div class="sidenav_menu">재고 관리</div></a>
     <a href="manager_stat.jsp"><div class="sidenav_menu">통계</div></a>
    </div>
    <div class="sidecontent">
        <h2>통계 보기</h2>
        <div style="width: 80%; height: 120px; background-color: lightgray;">
   		<button style="margin-left: 20px;"onclick="location.href='manager_stat_in.jsp?stat=y' ">전체 통계</button>
   		<button style="margin-left: 20px;"onclick="location.href='manager_stat_in.jsp?stat=m' ">월별 통계</button>
		<form action="manager_stat_in.jsp" method="post" style="padding-top: 20px; padding-left: 10px;">
            <select name="stat">
            <% for(i= 1 ; i<=12;i++) {%>
            <option value="<%out.println(String.valueOf(i));%>"><%out.println(String.valueOf(i));%>월</option>
             <% }%>
            </select>
            <button type="submit">일별 통계</button>
        </form>
        </form>
        </div>
        <div class="bag">
        
        <%
        if(request.getParameter("stat").equals("y"))
        {
        	%>
        	<h3>전체 매출: <% out.println(items[0]); %> 원</h3>
        	
        	<% 
        }
        else if(request.getParameter("stat").equals("m"))
        {
        	%><h3>월별 매출</h3><% 

        	for(i= 1 ; i<=12;i++) {%>
           <h5> <%out.println(String.valueOf(i));%>월 : <%out.println(items[i-1]);%></h5>
             <% }
        }
        else
        {
        	 try{
             	%><h3><% out.println(request.getParameter("stat")); %>월 일별 매출</h3><% 

        	        while(items[n]!= null)
        	        {%>
        	            <h6> <%out.println(String.valueOf(n+1));%>일 : <%out.println(items[n]);n++;%></h6>
        	        		
        	        <%}
       	        }catch(ArrayIndexOutOfBoundsException e)
       	        {
       	        	%><hr><% 
       	        }
        }
        %>

        
        
        </div>

		
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>