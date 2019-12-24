<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- <div class="modal-dialog" role="document"> -->
<!-- 	<div class="modal-content"> -->
		<div class="modal-header">
			<h5 class="modal-title">
			<c:if test="${vo != null }">
			메뉴 수정
			</c:if>
			<c:if test="${vo == null }">
			메뉴 등록
			</c:if>
			</h5>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<form method="post" class='form-horizontal' id='menuWriteForm' enctype="multipart/form-data">
				<input type='hidden' name='isUpdate' id='isUpdate' value='<c:out value="${vo.seq }" default="0"></c:out>'>
				<input type='hidden' name='originalOrder' id='originalOrder' value='<c:out value="${vo.order }" default="0"></c:out>'>
				<input type='hidden' name='seq' id='seq'
					value='<c:out value="${vo.seq }" default="0"></c:out>'>
				<div class="box-body">
					<div class="form-group">
						<div class='col-sm-6'>
							<label>메뉴 이름</label> <input type="text" id='name' maxlength="25"
								name="name" value='${vo.name }'
								class="form-control" placeholder="이름">
						</div>
						<div class='col-sm-6'>
							<label>메뉴 유형</label> 
							<select name='url' id='menuUrl' class="form-control">
								<option value='/' 
								<c:if test="${vo.url eq '/'.toString() }"> selected="selected"</c:if>
								>홈</option>
								<!-- <option value='survey'></option> -->
								<option value='/board/list'
								<c:if test="${vo.url eq '/board/list'.toString() }"> selected="selected"</c:if>
								>게시판</option>								
								<option value='/chart/home'
								<c:if test="${vo.url eq '/chart/home'.toString() }"> selected="selected"</c:if>
								>차트</option>								
								<option value='/survey/list'
								<c:if test="${vo.url eq '/survey/list'.toString() }"> selected="selected"</c:if>
								>설문조사</option>
							</select>
						</div>
					</div>
					<div class='form-group'>
						<div class='col-sm-6'>
							<label>메뉴 사용 여부</label>
							<div class="form-check">
							<input type="radio" name="isUse" id="isUseY" value="Y" class="form-check-input"
							<c:if test="${vo.isUse eq 'Y'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isUseY">사용</label>
							<input type="radio" name="isUse" id="isUseN" value="N" class="form-check-input"
							<c:if test="${vo.isUse eq 'N'.charAt(0)}"> checked="checked"</c:if>>
							<label class="form-check-label" for="isUseN">미 사용</label>
							</div>
						</div>
						<div class='col-sm-6'>
							<label>메뉴 순서</label> <input type="number" id='order' max="2000000000"
								name="order" value='${vo.order }' min=0
								class="form-control" placeholder="순서">
						</div>
					</div>					
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" id='menuSaveBtn'>저장</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		</div>
<!-- 	</div> -->
<!-- </div> -->