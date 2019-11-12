<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/15.0.0/classic/ckeditor.js"></script>
<script>
	$(document).ready(function(){
		
		var formObj = $("#boardForm");
		
		console.log(formObj);
		console.log(opener.window.name);
		
		$("#reWrite").on("click", function(){
			formObj.attr("action", "/reRegister");
			formObj.submit();
		});		
		$("#modify").on("click", function(){
			formObj.attr("action", "/modifyPage");
			if('${loginVO.isAdmin}' == '1' || '${boardVO.writer}' == '${loginVO.userName}')
				formObj.submit();
			else
				alert('작성자 본인만 수정이 가능합니다.');
		});
		
		$("#remove").on("click", function(){
			formObj.attr("action", "/removeAction");
			if('${loginVO.isAdmin}' == '1' || '${boardVO.writer}' == '${loginVO.userName}'){
				if(confirm("정말 삭제하시겠습니까?")){
					formObj.attr("target", opener.window.name);
					formObj.submit();
					self.opener = self;
					window.close();
				}
			}				
			else
				alert('작성자 본인만 삭제가 가능합니다.');
		});
		
		$("#list").on("click", function(){
			self.opener = self;
			window.close();
// 			formObj.attr("action", "/list");
// 			formObj.submit();
		});
	});
	
</script>
</head>
<body>
	<form role="form" method="post" action="modifyPage" id='boardForm'>
		<input type="hidden" name="bno" value="${boardVO.bno}">
		<input type="hidden" name="title" value='${boardVO.title}'>
		<input type="hidden" name="content" value='${boardVO.content}'>
		<input type="hidden" name="writer" value="${boardVO.writer}">
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
	</form>
	
	<div class="container" style="margin-top:50px;">
			<div class="form-group">
				<label for="exampleInputEmail1">제목 : </label>
				${boardVO.title }
			</div>
			<div class="form-group">
				<hr>
				${boardVO.content}
				<hr>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자 : </label>
				${boardVO.writer}
			</div>
		
		
		<div>
			<button type="submit" class="btn btn-default" id='modify'>수정</button>
			<button type="submit" class="btn btn-default" id='remove'>삭제</button>	
			<c:if test="${boardVO.isNotice == 0 }">
			<button type="submit" class="btn btn-default" id='reWrite'>답글</button>
			</c:if>
			<button type="button" class="btn btn-default" id='list'>닫기</button>
		</div>
		
		</div>
</body>
</html>