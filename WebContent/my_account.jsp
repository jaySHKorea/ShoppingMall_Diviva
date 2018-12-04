<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
<% 
ResultSet rs_user;
query1 = "SELECT * FROM customer WHERE Id = '" + session.getAttribute("id").toString() + "'";
pstmt1 = newConec.getConnection().prepareStatement(query1);
rs_user = pstmt1.executeQuery();
rs_user.next();
%>
	   <div class="contain_box">
    <div class="sidenav">
     <a href="my_account.jsp"><div class="sidenav_menu">내 계정</div></a>
    <a href="my_order.jsp"><div class="sidenav_menu">주문목록</div></a>
    </div>
    <div class="sidecontent">
        <h2>내 계정</h2>
        <form action="my_account_action.jsp" method="post" style="padding-top: 20px; padding-left: 10px;">
            <label for="userid">아이디</label>
           <%out.println(rs_user.getString(1));%><br><br>
            <label for="password">비밀번호 변경</label>
            <input type="password" name="password"/>
            <span style="font-size: 9px; color:gray;">비밀번호를 변경하시려면 변경할 비밀번호를 넣어주세요!</span>
            <br><br>
            <label for="name">이름</label>
            <input type="text" value="<%out.println(rs_user.getString(3));%>" name="name"/><br><br>
            <label for="address">주소</label>
            <input type="text" value="<%out.println(rs_user.getString(4));%>" name="address"/><br><br>
            <label for="age">나이</label>
            <input type="text" value="<%out.println(rs_user.getString(7));%>" name="age"/><br><br>
            <label for="phone">휴대폰번호</label>
            <input type="text" value="<%out.println(rs_user.getString(5));%>" name="phone"/><br><br>
            <label for="sex">성별</label>
            <%
            if(rs_user.getString(6).equals("M"))
            {
                %>
                <select name="sex">
                <option value="M">남</option>
                <option value="F">여</option>
                </select>
                <% 
  
            }
            else if(rs_user.getString(6).equals("F"))
            {
            	 %>
                 <select name="sex">
                 <option value="F">여</option>
                 <option value="M">남</option>
                 </select>
                 <% 
            }
            
            %>
            <br><br>
            <label for="job">직업</label>
            <input type="text" value=<%out.println(rs_user.getString(8));%> name="job"/><br><br>
            <input type="submit" value="수정하기"/>
        </form>
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>