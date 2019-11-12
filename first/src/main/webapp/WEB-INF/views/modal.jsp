<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
	$("#closeBtn").click(function() {
		if ($("#oneDay").prop("checked"))
			setCookie("noticeCookie${noticeVO.bno }", "done", 1);

		$(".modal").hide();
	});

	function setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expires="
				+ todayDate.toGMTString() + ";"
	}
</script>

</head>
<body>
	<!-- header -->
	<div class="modal-header">
		<!-- 닫기(x) 버튼 -->
		<button type="button" class="close" data-dismiss="modal">×</button>
		<!-- header title -->
		<h4 class="modal-title">${noticeVO.title }</h4>
	</div>
	<!-- body -->
	<div class="modal-body">${noticeVO.content }</div>
	<!-- Footer -->
	<div class="modal-footer">
		<input type='checkbox' id='oneDay' name='oneDay'><label
			for='oneDay'>오늘하루 보지 않기</label>
		<button type="button" class="btn btn-default" data-dismiss="modal"
			id='closeBtn'>닫기</button>
	</div>
</body>
</html>