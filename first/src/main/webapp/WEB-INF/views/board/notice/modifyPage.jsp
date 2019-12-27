<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script type="text/javascript" src="/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/additional-methods.min.js"></script>
<script type="text/javascript" src="/resources/js/messages_ko.min.js"></script>
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
			var isSecret = $('input[name="isSecret"]:checked').val();
			if(isSecret == 'Y') {
				$('#password').attr('required', 'required');
			} else {
				$('#password').removeAttr('required');
			}
			
			if(!$("form").valid())
				return;
			
			formObj.attr("action" , "/board/${boardVO.boardType }/${boardVO.url }/modifyPageAction");
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

	<form role='form' method="post" action='/board/${boardVO.boardType }/${boardVO.url }/modifyPageAction' id='modifyForm' style='margin-top:10px;'>
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
		<input type="hidden" name="boardId" value='${articleVO.boardId}'>
		<input type="hidden" name="url" value='${boardVO.url}'>
		<input type="hidden" name="bno" value="${articleVO.bno}">
	
		<div class="box-body container">
			<%-- <div class="form-group">
				<label for="exampleInputEmail1">번호</label>
				<input type="text" name="bno" class="form-control" value="${articleVO.bno}" readonly>
			</div> --%>
			<div class="form-group">
				<label for="exampleInputEmail1">제목</label>
				<c:if test="${loginVO.isAdmin == '1' && boardVO.isNotice == 'Y'.charAt(0) }">
				<div class='input-group-btn'>
					<select name='isNotice' class='form-control'>
						<option value='N'>일반</option>
  						<option value='Y'>공지</option>
					</select>
					</div>
				</c:if>
				<input type="text" name="title" class="form-control" required="required" value="${articleVO.title}">
			</div>
			<div class="form-group">
				<label for="exampleInputPwd1">본문</label>
				<textarea name="content" class="form-control" rows="3" required="required" id='editor'>${articleVO.content}</textarea>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자</label>
				<input type="text" name="writer" class="form-control" required="required" value="${loginVO.userName}" readonly>
			</div>
			<c:if test="${boardVO.isSecret == 'Y'.charAt(0) }">
				<div class='col-sm-4'>
					<label>비밀글 사용 여부</label>
					<label for='isSecret' class='error'></label>
					<div class="form-check">
					<input type="radio" name="isSecret" id="isSecretY" value="Y" class="form-check-input" required="required"
					<c:if test="${articleVO.isSecret eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
					<label class="form-check-label" for="isSecretY">사용</label>
					<input type="radio" name="isSecret" id="isSecretN" value="N" class="form-check-input"
					<c:if test="${articleVO.isSecret eq 'N'.charAt(0)}"> checked="checked"</c:if>>
					<label class="form-check-label" for="isSecretN">미 사용</label>
					</div>
				</div>
				<div class='col-sm-4'>
					<div class="form-group">
						<label for="password">비밀번호</label>
						<input type="password" id='password'
						name="password" class="form-control" placeholder="Enter Password">
					</div>
				</div>	
			</c:if>
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