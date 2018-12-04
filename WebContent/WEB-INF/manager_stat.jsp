<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
request.setCharacterEncoding("UTF-8");
int i = 1;
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
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>