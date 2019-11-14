<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<style>
.ck-editor__editable_inline {
    min-height: 400px;
}
</style>
</head>
<body>
<script>
	$(document).ready(function(){
		
		var formObj = $("#modifyForm");
		
		console.log(formObj);
		console.log(opener.window.name);
		
		$("#save").on("click", function(){
			formObj.attr("action" , "/modifyPageAction");
			formObj.attr("target", opener.window.name);
			formObj.submit();
			window.close();
		});
		
		$("#close").on("click", function(){
			self.opener = self;
			window.close();
		});
	});
	
</script>

	<form role='form' method="post" action='/modifyPageAction' id='modifyForm' style='margin-top:10px;'>
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
	
		<div class="box-body container">
			<div class="form-group">
				<label for="exampleInputEmail1">번호</label>
				<input type="text" name="bno" class="form-control" value="${boardVO.bno}" readonly>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">제목</label>
				<input type="text" name="title" class="form-control" value="${boardVO.title}">
			</div>
			<div class="form-group">
				<label for="exampleInputPwd1">본문</label>
				<textarea name="content" class="form-control" rows="3" id='editor'>${boardVO.content}</textarea>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자</label>
				<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly>
			</div>
			<button type="button" class="btn btn-primary" id='save'>수정</button>
			<button type="button" class="btn btn-warning" id='close'>취소</button>
		</div>
	</form>
</body>
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
</html>