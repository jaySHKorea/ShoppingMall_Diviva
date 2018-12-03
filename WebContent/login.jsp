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
        <h2>로그인</h2>
        <form action="login_to.jsp" method="post" style="padding-top: 20px; padding-left: 10px;">
            <label for="userid">아이디</label>
            <input type="text" name="userid"/>
            <label for="password">비밀번호</label>
            <input type="password" name="password"/>
            <button type="button submit" class="btn btn-primary">로그인</button>
        </form>
    </div>
   </div>
		
		
<%@ include file="/footer.jsp" %>