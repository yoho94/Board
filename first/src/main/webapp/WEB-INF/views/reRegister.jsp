<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title><link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
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
<style>
.ck-editor__editable_inline {
    min-height: 400px;
}
</style>
</head>
<body>
<script>
	$(document).ready(function(){
		
		var formObj = $("#reRegisterForm");
		
		console.log(formObj);
		console.log(opener.window.name);
		
		$("#reSave").on("click", function(){
			formObj.attr("action" , "/reRegisterAction");
			formObj.attr("target", opener.window.name);
			formObj.submit();
			window.close();
		});
		
		$("#reClose").on("click", function(){
			window.close();
		});
	});
	
</script>
	<div class='container'>
		<form method="post" class='form-horizontal' action='/reRegisterAction' id='reRegisterForm'>
			<input type="hidden" name="page" value="${pvo.page}">
			<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
			<input type="hidden" name="searchType" value="${pvo.searchType}">
			<input type="hidden" name="keyword" value="${pvo.keyword}">
			<input type="hidden" value="${oBoardVO.bno}" name='obno' id='obno' readonly="readonly">
			<div class="box-body">
				<div class="form-group">
					<label for="exampleInputEmail1">제목</label> <input type="text" value='RE: ${oBoardVO.title}'
						name="title" class="form-control" placeholder="Enter Title" required="required">
				</div>
				<div class="form-group">
					<label for="exampleInputPwd1">본문</label>
					<textarea name="content" class="form-control" rows="3"
						placeholder="Enter Contents" id='editor'></textarea>
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">작성자</label> <input type="text" id='writer' value='${loginVO.userName}'
						name="writer" class="form-control" placeholder="Enter Writer" required="required" readonly>
				</div>				
			</div>

			<div class="box-footer">
				<button type="button" class="btn btn-default" id='reSave'>확인</button>
				<button type="button" class="btn btn-warning" id='reClose'>취소</button>
			</div>
		</form>
	</div>
		
	<script>
	ClassicEditor

	.create( document.querySelector( '#editor' ), {

		language:"ko",
		ckfinder: {
			uploadUrl: '/imgUp'
		}

	})
	.catch(function (error) {

		console.log( error );


	} );
	</script>
</body>
</html>