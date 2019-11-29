<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- <div class="modal-dialog" role="document"> -->
<!-- 	<div class="modal-content"> -->
		<div class="modal-header">
			<h5 class="modal-title">
			<c:if test="${vo != null }">
			팝업 수정
			</c:if>
			<c:if test="${vo == null }">
			팝업 등록
			</c:if>
			</h5>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<form method="post" class='form-horizontal' id='writeForm' enctype="multipart/form-data">
				<input type='hidden' name='isUpdate' id='isUpdate' value='<c:out value="${vo.seq }" default="0"></c:out>'>
				<input type='hidden' name='seq' id='seq'
					value='<c:out value="${vo.seq }" default="0"></c:out>'>
				<div class="box-body">
					<div class="form-group">
						<div class='col-sm-12'>
							<label>제목</label> <input type="text" id='title'
								name="title" value='${vo.title }'
								class="form-control" placeholder="제목">
						</div>
					</div>
					<div class='form-group'>
						<div class='col-sm-6'>
							<label>팝업 시작일</label> <input id='startDate' name='start_date'
								value='<fmt:formatDate pattern="MM/dd/yyyy" value="${vo.start_date}"/>'
								type='text' class="form-control" placeholder='여기부터' />
						</div>
						<div class='col-sm-6'>
							<label>팝업 종료일</label> <input id='endDate' name='end_date'
								value='<fmt:formatDate pattern="MM/dd/yyyy" value="${vo.end_date}"/>'
								type='text' class="form-control" placeholder='여기까지' />
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-12'>
							<label>본문</label>
							<textarea id='text' name="text"
								class="form-control" rows="5" placeholder="Enter Contents">${vo.text }</textarea>
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-12'>
							<label>이미지</label>
							<input type="file" class="form-control" id="imageUp" name="imageUp"/>
							<input type="hidden" id="image" name="image" value="${vo.image }"/>
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-12'>
							<label>링크</label>
							<input name="link" class="form-control" type="url" value="${vo.link }"
								id='link' placeholder="Enter URL">
						</div>
					</div>
					<div class="form-group">
						<div class='col-sm-6'>
							<label>높이</label>
							<input name="height" class="form-control" type="number" value="${vo.height }"
								id='height' placeholder="Enter Height">
						</div>
						<div class='col-sm-6'>
							<label>넓이</label>
							<input name="width" class="form-control" type="number" value="${vo.width }"
								id='width' placeholder="Enter Width">
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" id='popupSaveBtn'>저장</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		</div>
<!-- 	</div> -->
<!-- </div> -->

<script>
	$('#popupSaveBtn').on('click', function() {
		// TODO 유효성 검사.		
		imgUpload();
		var valid = validCheck();
		
		if(valid != 'PASS') {
			alert(valid);
			return;
		}
		

		
		$.ajax({
			type : 'POST',
			data : $('#writeForm').serialize(),
			url : "/admin/ajax/popupWrite.ajax",
			success : function(data) {
				alert("팝업 등록 성공 !");
				hideModal();
				adminPopup();
			}
		});
	});
	
	function validCheck() {
		var title = $('#title').val();
		if(!title)
			return '제목이 없습니다.';
		
		var startDate = $('#startDate').val();
		if(!startDate)
			return '시작일이 없습니다.';
		
		var endDate = $('#endDate').val();
		if(!endDate)
			return '종료일이 없습니다.';
		
		
		var text = $('#text').val();		
		var image = $('#image').val();		
		
		if(!text && !image)
			return "본문, 이미지 값이 둘다 비어있습니다.";
		
		var link = $('#link').val();
		if(!link)
			return "링크의 값이 비어있습니다.";
		
		var height = $('#height').val();
		if(!height)
			return "높이 값이 비어있습니다.";
		
		var width = $('#width').val();
		if(!width)
			return "넓이 값이 비어있습니다.";
		
		if(isNaN(height))
			return "높이 값이 숫자가 아닙니다.";
		
		if(isNaN(width))
			return "넓이 값이 숫자가 아닙니다.";
		
		$('#height').val(parseInt(height));
		$('#width').val(parseInt(width));		
		
		var startTime = new Date(startDate).getTime();
		var endTime = new Date(endDate).getTime();
		
		if(startTime > endTime)
			return '종료일이 시작일보다 빠릅니다.';		
		
		
		return 'PASS';
	}
	
	function imgUpload() {
		///imgUp
		var form = new FormData(document.getElementById('writeForm'));
		$.ajax({
			type : 'POST',
			data : form,
			dataType : 'json',
			async: false,
			url : "/admin/imgUp",
			processData: false,
		    contentType: false,
			success : function(data) {
				if(data.uploaded) {
// 					alert("이미지 등록 성공");
// 					console.log(data);
					$('#image').val(data.url);
// 					console.log($('#image').val());
				}
			}
		});
	}
	
	$('#startDate').datetimepicker({
		format : 'L'
	});
	$('#endDate').datetimepicker({
		format : 'L',
		useCurrent : false
	});
	
	$("#startDate").on("dp.change", function(e) {
		$('#endDate').data("DateTimePicker").minDate(e.date);
	});
	
	$("#endDate").on("dp.change", function(e) {
		$('#startDate').data("DateTimePicker").maxDate(e.date);
	});
</script>