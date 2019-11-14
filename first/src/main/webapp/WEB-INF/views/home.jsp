<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>홈 페이지</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
</head>
<body>
</body>
<div class='container'>
	
	<h1><c:out value="${msg }"></c:out></h1>
	<c:choose>
	<c:when test="${loginVO == null }">
	<h1>로그인을 하셔야 이용가능합니다.</h1>

	<form action="/login" method="post">
		<div class="form-group">
			<input type="text" class="form-control" placeholder="Username"
				required="required" name="userId" onkeyup='spaceRemove($(this))'>
		</div>
		<div class="form-group">
			<input type="password" class="form-control" placeholder="Password"
				required="required" name="userPass" onkeyup='spaceRemove($(this))'>
		</div>
		<input type="submit" class="btn btn-primary btn-block" value="Login">
		<div class="form-footer">
			<a href='/MemberJoin'>회원가입</a>
			<a href="#">Forgot Your password?</a>
		</div>
	</form>
	</c:when>
	<c:otherwise>
	<h1>환영합니다.</h1>
	<hr>
	<a href="/logout">로그아웃</a>
	</c:otherwise>
	</c:choose>
</div>
</html>