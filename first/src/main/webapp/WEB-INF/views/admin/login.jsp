<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
</head>
<body>
	<div class='container'>
		<form action="/admin/login.action" method="post">
			<div class="form-group">
				<input type="password" class="form-control" placeholder="Password"
					required="required" name="pass" onkeyup='spaceRemove($(this))'>
			</div>
			<input type="submit" class="btn btn-primary btn-block" value="Login">
			<div class="form-footer">
				<a href="#">${msg}</a>
			</div>
		</form>	
	</div>
</body>
</html>