<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<%-- <jsp:include page="/resources/include/navbar.jsp"></jsp:include> --%>
<div id="navbarDiv">
<c:import url="/board/navbar"></c:import>
</div>
<script src="/resources/js/jquery-ui-1.12.1/jquery-ui.js"></script>
<script src="/resources/js/jquery.form.min.js"></script>
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
	
	function adminBoard() {
		var pageData = $("#searchForm").serialize();
		$("#adminLists").html('');
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/boardList",
			data : pageData,
			dataType : "html",			
			async : false,
			success : function(data) {
				$("#adminLists").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminBoardLi").attr('class', 'active');				
			}
		});
	}
	
	function adminMenu() {
		$("#adminLists").html('');
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/menuList",
			dataType : "html",			
			async : false,
			success : function(data) {
				$("#adminLists").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminMenuLi").attr('class', 'active');				
			}
		});
	}
	
	function boardList(page) {
		$("#page").val(page);
		adminBoard();
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
	
	$(document).on("click", "#newBoardBtn", function() {
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/boardWrite",
			async: false,
			dataType : "html",
			success : function(data) {
				$('#writeModal').html(data);
				$('#writeModalShow').modal('show');
			}
		});
	});
	
	$(document).on("click", "#newMenuBtn", function() {
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/menuWrite",
			async: false,
			dataType : "html",
			success : function(data) {
				$('#writeModal').html(data);
				$('#writeModalShow').modal('show');
			}
		});
	});
	
	function fncSelectBoard(boardId) {
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/boardWrite",
			data : "boardId=" + boardId,
			async: false,
			dataType : "html",
			success : function(data) {
				$('#writeModal').html(data);
				$('#writeModalShow').modal('show');
			}
		});
	}
	
	function fncSelectMenu(seq) {
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/menuWrite",
			data : "seq=" + seq,
			async: false,
			dataType : "html",
			success : function(data) {
				$('#writeModal').html(data);
				$('#writeModalShow').modal('show');
			}
		});
	}
	
	function boardUrlCheck() {
		var urlValid = /^[A-Za-z0-9+]*$/;
		var urlVal = $("#url").val();
		
		if(!urlValid.test(urlVal)) {
			alert('URL은 영문 및 숫자만 입력 가능합니다.');
			$("#urlCheck").val("N");
			$("#url").css("background-color", "rgb(255,200,200)");
			return;
		}
		
		var boardFormData = $("#boardWriteForm").serialize();
		$.ajax({
			type : 'POST',
			url : "/admin/ajax/urlCheck",
			async: false,
			data : boardFormData,
			success : function(data) {
				if(data == true) {
					$("#urlCheck").val("Y");
					$("#url").css("background-color", "rgb(200,255,200)");
				} else {
					$("#urlCheck").val("N");
					$("#url").css("background-color", "rgb(255,200,200)");
				}
			}
		});
	}
	
	$(document).on("click", "#urlCheckBtn", function() {
		boardUrlCheck();
	});
	
	$(document).on("change", "#url", function() {
		boardUrlCheck();
	});
	
	function boardValidCheck() {
		var boardType = $('#boardType').val();
		if(!boardType)
			return '게시판 유형이 없습니다.';
		
		var name = $('#name').val();
		if(!name)
			return '게시판 이름이 없습니다.';
		
		var isRpy = $('input[name="isRpy"]:checked').val();
		if(!isRpy)
			return '게시판 답글 여부를 선택하세요.';
		
		var isComment = $('input[name="isComment"]:checked').val();
		if(!isComment)
			return '게시판 덧글 여부를 선택하세요.';
		
		var isSecret = $('input[name="isSecret"]:checked').val();
		if(!isSecret)
			return '게시판 비밀글 여부를 선택하세요.';
		
		var isNotice = $('input[name="isNotice"]:checked').val();
		if(!isNotice)
			return '게시판 공지 여부를 선택하세요.';
		
		var isUse = $('input[name="isUse"]:checked').val();
		if(!isUse)
			return '게시판 사용 여부를 선택하세요.';
		
		var url = $('#url').val();
		if(!url)
			return '게시판 URL이 없습니다.';
		
		var urlCheck = $("#urlCheck").val();
		if(urlCheck != "Y")
			return '게시판 URL 중복 확인을 해주세요.';
		
		return 'PASS';
	}
	
	function menuValidCheck() {		
		var name = $('#name').val();
		if(!name)
			return '메뉴 이름이 없습니다.';			
		
		var isUse = $('input[name="isUse"]:checked').val();
		if(!isUse)
			return '메뉴 사용 여부를 선택하세요.';
		
		var url = $('#menuUrl').val();
		if(!url)
			return '메뉴 URL이 없습니다.';
		
		var order = $('#order').val();		
		if(order.length > 10)
			return '순서가 너무 큽니다.';
		
		if(isNaN(order))
			return '순서에는 번호만 써주세요';
		
		
		return 'PASS';
	}
	
	$(document).on("click", "#boardSaveBtn", function() {
		var valid = boardValidCheck();
		
		if(valid != 'PASS') {
			alert(valid);
			return;
		}
		
		var boardFormData = $("#boardWriteForm").serialize();		
		$.ajax({
			type : 'POST',
			data : boardFormData,
			url : "/admin/ajax/boardWrite.action",
			success : function(data) {
				alert("게시판 등록 성공 !");
				hideModal();
				adminBoard();
			}
		});
	});
	
	$(document).on("click", "#menuSaveBtn", function() {
		 var valid = menuValidCheck();
		
		if(valid != 'PASS') {
			alert(valid);
			return;
		}
		
		var menuFormData = $("#menuWriteForm").serialize();		
		$.ajax({
			type : 'POST',
			data : menuFormData,
			url : "/admin/ajax/menuWrite.action",
			success : function(data) {
				alert("메뉴 등록 성공 !");
				hideModal();
				adminMenu();
				/* getNavbar(); */
			}
		});
	});
	
	function getNavbar() {		
		$("#navbarDiv").html('');
		$.ajax({
			type : 'POST',
			url : "/board/navbar",
			dataType : "html",			
			async : false,
			success : function(data) {
				$("#navbarDiv").html(data);		
			}
		});
	}
	
</script>
</head>
<body>
	<div class=container>
		<ul id="sidebar" class="nav nav-pills">
			<li id="adminMemberLi"><a onclick="adminMember();">회원 관리</a></li>
			<li id="adminSurveyLi"><a onclick="adminSurvey();">설문조사 관리</a></li>
			<li id="adminPopupLi"><a onclick="adminPopup();">팝업 관리</a></li>
			<li id="adminBoardLi"><a onclick="adminBoard();">게시판 관리</a></li>
			<li id="adminMenuLi"><a onclick="adminMenu();">메뉴 관리</a></li>
		</ul>
		<div class="row" id="adminLists">
		
		</div>
	</div>
</body>
</html>