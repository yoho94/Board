<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- <div class="modal-dialog" role="document"> -->
<!-- 	<div class="modal-content"> -->
		<div class="modal-header">
			<h5 class="modal-title">
			<c:if test="${vo != null }">
			게시판 수정
			</c:if>
			<c:if test="${vo == null }">
			게시판 등록
			</c:if>
			</h5>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<form method="post" class='form-horizontal' id='boardWriteForm' enctype="multipart/form-data">
				<input type='hidden' name='isUpdate' id='isUpdate' value='<c:out value="${vo.boardId }" default="0"></c:out>'>
				<input type='hidden' name='originalOrder' id='originalOrder' value='<c:out value="${vo.order }" default="0"></c:out>'>
				<input type='hidden' name='boardId' id='boardId'
					value='<c:out value="${vo.boardId }" default="0"></c:out>'>
				<div class="box-body">
					<div class="form-group">
						<div class='col-sm-6'>
							<label>게시판 이름</label> <input type="text" id='name'
								name="name" value='${vo.name }'
								class="form-control" placeholder="이름">
						</div>
						<div class='col-sm-6'>
							<label>게시판 유형</label> 
							<select name='boardType' id='boardType' class="form-control">
								<option value='basic' 
								<c:if test="${vo.boardType eq 'basic'.toString() }"> selected="selected"</c:if>
								>기본 게시판</option>
								<!-- <option value='survey'></option> -->
								<option value='notice'
								<c:if test="${vo.boardType eq 'notice'.toString() }"> selected="selected"</c:if>
								>알림 게시판</option>
							</select>
						</div>
					</div>
					<div class='form-group'>
						<div class='col-sm-9'>
							<label>게시판 설명</label> <input type="text" id='note'
								name="note" value='${vo.note }'
								class="form-control" placeholder="설명">
						</div>
						<div class='col-sm-3'>
							<label>게시판 순서</label> <input type="number" id='order'
								name="order" value='${vo.order }' min=0
								class="form-control" placeholder="순서">
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-4'>
							<label>게시판 답글 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isRpy" id="isRpyY" value="Y" class="form-check-input"
							<c:if test="${vo.isRpy eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isRpyY">사용</label>
							<input type="radio" name="isRpy" id="isRpyN" value="N" class="form-check-input"
							<c:if test="${vo.isRpy eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isRpyN">미 사용</label>
							</div>
						</div>
						<div class='col-sm-4'>
							<label>게시판 덧글 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isComment" id="isCommentY" value="Y" class="form-check-input"
							<c:if test="${vo.isComment eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isCommentY">사용</label>
							<input type="radio" name="isComment" id="isCommentN" value="N" class="form-check-input"
							<c:if test="${vo.isComment eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isCommentN">미 사용</label>
							</div>
						</div>
						<div class='col-sm-4'>
							<label>게시판 비밀글 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isSecret" id="isSecretY" value="Y" class="form-check-input"
							<c:if test="${vo.isSecret eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isSecretY">사용</label>
							<input type="radio" name="isSecret" id="isSecretN" value="N" class="form-check-input"
							<c:if test="${vo.isSecret eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isSecretN">미 사용</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-4'>
							<label>게시판 공지 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isNotice" id="isNoticeY" value="Y" class="form-check-input"
							<c:if test="${vo.isNotice eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isNoticeY">사용</label>
							<input type="radio" name="isNotice" id="isNoticeN" value="N" class="form-check-input"
							<c:if test="${vo.isNotice eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isNoticeN">미 사용</label>
							</div>
						</div>
						<div class='col-sm-3'>
							<label>게시판 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isUse" id="isUseY" value="Y" class="form-check-input"
							<c:if test="${vo.isUse eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isUseY">사용</label>
							<input type="radio" name="isUse" id="isUseN" value="N" class="form-check-input"
							<c:if test="${vo.isUse eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isUseN">미 사용</label>
							</div>
						</div>
						<div class='col-sm-5'>
							<label>게시판 URL</label>
							<div class="input-group">
								<input type="text" name="url" id="url" value="${vo.url }" class="form-control">
								<span class="input-group-btn">
									<button type="button" id="urlCheckBtn" class="btn btn-default">중복 확인</button>
								</span>
							</div>
							<input type="hidden" name="urlCheck" id="urlCheck" value="N">
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" id='boardSaveBtn'>저장</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		</div>
<!-- 	</div> -->
<!-- </div> -->
<c:if test="${vo ne null }">
<script>
$("#urlCheck").val("Y");
$("#url").css("background-color", "rgb(200,255,200)");
</script>
</c:if>