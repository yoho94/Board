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
<script type="text/javascript">
	
	function adminMember() {
		$("#adminLists").html('');
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/memberList",
			dataType : "html",
			async : false,
			success : function(data) {
				$("#adminLists").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminMemberLi").attr('class', 'active');
			}
		});
	}
	
	function adminSurvey() {
		$("#adminLists").html('');
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/surveyList",
			dataType : "html",
			async : false,
			success : function(data) {
				$("#adminLists").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminSurveyLi").attr('class', 'active');
			}
		});
	}
	
	function adminPopup() {
		$("#adminLists").html('');
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/popupList",
			dataType : "html",
			async : false,
			success : function(data) {
				$("#adminLists").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminPopupLi").attr('class', 'active');
			}
		});
	}
	
	function hideModal() {
		  $(".modal").removeClass("in");
		  $(".modal-backdrop").remove();
		  $('body').removeClass('modal-open');
		  $('body').css('padding-right', '');
		  $(".modal").hide();
	}
	
	$(document).ready(function() {
		adminMember();
	});
</script>
</head>
<body>
	<div class=container>
		<ul id="sidebar" class="nav nav-pills">
			<li id="adminMemberLi"><a onclick="adminMember();">회원 관리</a></li>
			<li id="adminSurveyLi"><a onclick="adminSurvey();">설문조사 관리</a></li>
			<li id="adminPopupLi"><a onclick="adminPopup();">팝업 관리</a></li>
		</ul>
		<div class="row" id="adminLists">
		
		</div>
	</div>
</body>
</html>