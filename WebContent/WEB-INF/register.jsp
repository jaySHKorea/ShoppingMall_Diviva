<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Navbar.jsp" %>
<%@ page import="phase3.connection" %>
	   <div class="contain_box">
    <div class="sidenav">
     <a href="login.jsp"><div class="sidenav_menu">로그인</div></a>
    <a href="register.jsp"><div class="sidenav_menu">회원가입</div></a>
    </div>
    <div class="sidecontent">
        <h2>회원가입</h2>
        <form action="registration.jsp" method="post" style="padding-top: 20px; padding-left: 10px;">
            <label for="userid">아이디</label>
            <input type="text" name="userid"/><br><br>
            <label for="password">비밀번호</label>
            <input type="password" name="password"/><br><br>
            <label for="name">이름</label>
            <input type="text" name="name"/><br><br>
            <label for="address">주소</label>
            <input type="text" name="address"/><br><br>
            <label for="age">나이</label>
            <input type="text" name="age"/><br><br>
            <label for="phone">휴대폰번호</label>
            <input type="text" name="phone"/><br><br>
            <label for="sex">성별</label>
            <select name="sex">
            <option value="M">남</option>
            <option value="F">여</option>
            </select><br><br>
            <label for="job">직업</label>
            <input type="text" name="job"/><br><br>
            <input type="submit" value="회원가입"/>
        </form>
    </div>
    </div>
		
<%@ include file="/footer.jsp" %>