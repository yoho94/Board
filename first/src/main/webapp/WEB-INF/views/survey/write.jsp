<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form method="post" class='form-horizontal' id='writeForm'>
<input type='hidden' name='survey_seq' id='info_survey_seq' value='<c:out value="${info.survey_seq }" default="0"></c:out>'> 
	<div class="box-body">
		<div class="form-group">
			<div class='col-sm-12'>
				<label>조사기관</label> <input type="text" id='agency_name' name="agency_name" value='${info.agency_name }'
					class="form-control" placeholder="조사 기관">
			</div>
		</div>
		<div class='form-group'>
			<div class='col-sm-4'>
				<label>설문 시작일</label> <input id='startDate' name='start_date' value='<fmt:formatDate pattern="MM/dd/yyyy" value="${info.start_date}"/>'
					type='text' class="form-control" placeholder='여기부터' />
			</div>
			<div class='col-sm-4'>
				<label>설문 종료일</label> <input id='endDate' name='end_date' value='<fmt:formatDate pattern="MM/dd/yyyy" value="${info.end_date}"/>'
					type='text' class="form-control" placeholder='여기까지' />
			</div>
			<div class='col-sm-4'>
				<label>설문 발표일</label> <input id='resultDate' name='result_date' value='<fmt:formatDate pattern="MM/dd/yyyy" value="${info.result_date}"/>'
					type='text' class="form-control" placeholder='여기까지' />
			</div>
		</div>
		<div class="form-group">
			<div class='col-sm-12'>
				<label>머리 글</label>
				<textarea id='survey_head' name="survey_head" class="form-control" rows="5"
					placeholder="Enter Contents"><c:if test='${info == null }'>${head}</c:if><c:if test='${info != null }'>${info.survey_head}</c:if></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class='col-sm-12'>
				<label>본문</label>
				<textarea name="survey_content" class="form-control" rows="5" id='survey_content'
					placeholder="Enter Contents">${info.survey_content}</textarea>
			</div>
		</div>
		<div class="form-group">
			<div class='col-sm-12'>
				<label>꼬리 글</label>
				<textarea name="survey_foot" class="form-control" rows="5" id='survey_foot'
					placeholder="Enter Contents"><c:if test='${info == null }'>${tail}</c:if><c:if test='${info != null }'>${info.survey_foot}</c:if></textarea>
			</div>
		</div>
	</div>
</form>

<form class='form-horizontal' id='questionForm' style='display: none;'>
	<input type='hidden' name='survey_seq' id='survey_seq' value='${info.survey_seq }'>
	<div class='box-body'>
		<div class='form-group'>
			<div class='col-sm-4'>
				<label>문제번호(부모번호)</label> <input type='text' value='1' onchange='childTypeChange();'
					name='question_order' id='question_order' class='form-control'
					readonly='readonly'>
			</div>
			<div class='col-sm-4'>
				<label>자식번호</label> <input type='text' value='0' name='question_depth'
					id='question_depth' class='form-control' readonly='readonly'>
			</div>
			<div class='col-sm-4'>
				<label>문항 유형</label> 
				<select id='childType' name='childType' class="form-control" onchange='childTypeChange(true);'>
					<option value='D'>일반문항</option>
					<option value='P'>상위문항</option>
					<option value='C'>하위문항</option>
				</select>
			</div>
		</div>
		<div class='form-group'>
			<div class='col-sm-4'>
				<label>카테고리</label> <select name='category_code' id='category_code'
					class="form-control">
				</select>
			</div>
			<div class='col-sm-8'>
				<label>제목</label> <input id='title' name='title' type='text'
					class='form-control' />
			</div>
		</div>
		<div class='form-group'>
			<div class='col-sm-3'>
				<label>객관식, 주관식</label> <select id='type' name='type'
					class="form-control">
					<option value='a'>객관식</option>
					<option value='b'>객관식 + 기타</option>
					<option value='c'>객관식 + 없음</option>
					<option value='d'>객관식 + 기타 + 없음</option>
					<option value='1'>주관식</option>
				</select>
			</div>
			<div class='col-sm-3'>
				<label>필수, 자율 선택</label> <select id='is_free' name='is_free'
					class="form-control">
					<option value='d'>기본 (필수)</option>
					<option value='n'>필수</option>
					<option value='y'>자율</option>
				</select>
			</div>
			<div class='col-sm-3'>
				<label>객관식 선택 가능 개수</label> <select id='number' name='number'
					class="form-control">
					<option value='1'>1개</option>
					<option value='2'>2개</option>
					<option value='3'>3개</option>
					<option value='4'>4개</option>
					<option value='5'>5개</option>
					<option value='6'>6개</option>
					<option value='7'>7개</option>
					<option value='8'>8개</option>
					<option value='9'>9개</option>
					<option value='10'>10개</option>
				</select>
			</div>
			<div class='col-sm-3'>
				<label>객관식 문항 선택지</label> <select id='question_code'
					name='question_code' class="form-control">
				</select>
			</div>
		</div>
	</div>
</form>

<div class="box-footer">
	<div class="pull-left">
		<button id='nextBtn' type="button" class="btn btn-default"
			onclick='nextClick()'>다음</button>
		<button id='finishBtn' type="button" class="btn btn-success">완료</button>
	</div>

	<div class="pull-right">
		<button id='categoryModalBtn' type="button" class="btn btn-default"
			onclick='categoryModal()'>카테고리 추가</button>
		<button id='codeModalBtn' type="button" class="btn btn-default"
			onclick='codeModal()'>문항 선택지 추가</button>
		<button id='codeListModalBtn' type="button" class="btn btn-default"
			onclick='codeListModal()'>문항 선택지 목록 보기</button>
		<button id='questionListModalBtn' type="button"
			class="btn btn-default">현재 추가한
			문항 보기</button>
	</div>
	<div class="clearfix"></div>
</div>

<div id='categoryModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">카테고리 추가</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			<div class='row'>
				<form id="categoryForm">
					<label>카테고리 이름 : <input type='text' name='category_name'
						id='category_name'></label>
						<button type="button" class="btn btn-primary" id='categoryAddBtn'
					onclick='putCategory();'>추가</button>
				</form>
			</div>
			<div class='row'>
				<form id="categoryDelForm">
					<label>카테고리 이름 : 
					<select name='category_code' id='category_code_del'>
				    </select>
				    <button type="button" class="btn btn-danger" onclick='delCategory();'>삭제</button>
					</label>
				</form>
			</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>				
			</div>
		</div>
	</div>
</div>

<div id='codeModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">문항 선택지 추가</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			<div class='row'>
				<form id="codeForm">
					<label>유형 : <select id='parent_code' name='parent_code'>
							<option value='0'>부모 코드 생성</option>
					</select></label> <label>문항 선택지 이름 : <input type='text' name='question_name'
						id='question_name'></label>
						<button type="button" class="btn btn-primary" id='codeAddBtn' onclick='putQuestionCode();'>추가</button>
				</form>
			</div>
			<div class='row'>
				<form id='codeDelForm'>
					<label>유형 : 
						<select id='parent_code_del' name='question_code'> 
						</select>
					</label>
					<button type="button" class="btn btn-danger" onclick='delParentCode();'>삭제</button>
				</form>
			</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
		</div>
	</div>
</div>

<div id='codeListModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">문항 선택지 목록 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<select
					onchange="getChildCodeList($('#parentCodeList option:selected').val())"
					id='parentCodeList'>
				</select>
				<ol id='childCodeList'>

				</ol>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div id='questionListModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="width: 65%;margin: 20;padding:20;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">추가한 문항 목록 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id='questionListModalBody' class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript">
	var infoSeq;
	var question_order = 1;
	var question_depth = [];
	function nextClick() {
		var valid = validCheck();
		
		if(valid != 'PASS'){
			alert(valid);
			return;
		}
		
		$('#writeForm').attr('style', 'display:none;');
		$('#questionForm').removeAttr('style');
		infoSeq = putInfo();
		$('#questionListModalBtn').attr('onclick','questionListModal();');
		$('#survey_seq').val(infoSeq);
		getParentCode();
		getCategory();

		$('#nextBtn').attr('onclick', 'putQuestion();');
		$('#nextBtn').html('문항추가');
		childTypeChange(true);
	}
	
	function validCheck() {
		var agency_name = $('#agency_name').val();
		if(!agency_name)
			return '조사기관이 없습니다.';
		
		var startDate = $('#startDate').val();
		if(!startDate)
			return '시작일이 없습니다.';
		
		var endDate = $('#endDate').val();
		if(!endDate)
			return '종료일이 없습니다.';
		
		var resultDate = $('#resultDate').val();
		if(!resultDate)
			return '발표일이 없습니다.';
		
		var survey_head = $('#survey_head').val();
		if(!survey_head)
			return '머리 글이 없습니다.';
		
		var survey_foot = $('#survey_foot').val();
		if(!survey_foot)
			return '꼬리 글이 없습니다.';
		
		var startTime = new Date(startDate).getTime();
		var endTime = new Date(endDate).getTime();
		var resultTime = new Date(resultDate).getTime();
		
		if(startTime > endTime)
			return '종료일이 시작일보다 빠릅니다.';
		
		if(endTime > resultTime)
			return '발표일이 종료일보다 빠릅니다.';
		
		
		return 'PASS';
	}

	function categoryModal() {
		$("#categoryModal").modal();
	}

	function codeModal() {
		$("#codeModal").modal();
		getParentCode();
	}

	function codeListModal() {
		$("#codeListModal").modal();
		$('#childCodeList').html("");
		getParentCode();
	}
	
	function questionListModal() {
		getQuestionList();
		$("#questionListModal").modal();		
// 		$('#childCodeList').html("");
// 		getParentCode();
	}
	
	function getQuestionList() {
		$.ajax({
			type : 'POST',
			url : '/admin/ajax/questionList.ajax',
			dataType : 'html',
			data : "seq="+infoSeq,
			async : false,
			success : function(data) {
				$("#questionListModalBody").html(data);
			}
		});
	}

	function getParentCode() {
		var html = '';
		var parentHtml = "<option value='0'>부모 코드 생성</option>";
		var listHtml = "<option value='-1'>선택해주세요</option>";

		$.ajax({
			type : 'POST',
			url : '/survey/getParentCode.ajax',
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);

				$.each(data, function(i, obj) {
					html += '<option value=' + obj.question_code + '>'
							+ obj.question_name + '</option>';
				});

				$('#question_code').html(html);
				$('#parentCodeList').html(listHtml + html);
				$('#parent_code').html(parentHtml + html);
				$('#parent_code_del').html(listHtml + html);
			}
		});
	}

	function getChildCodeList(code) {
		var html = '';

		$.ajax({
			type : 'POST',
			url : '/survey/questionCode.ajax',
			dataType : 'json',
			data : 'code=' + code,
			async : false,
			success : function(data) {
				console.log(data);

				$.each(data, function(i, obj) {
					html += '<li>' + obj.question_name + '</li>';
				});

				$('#childCodeList').html(html);
			}
		});
	}

	function getCategory() {
		var html = '';
		var listHtml = "<option value='-1'>선택해주세요</option>";
		
		$.ajax({
			type : 'POST',
			url : '/survey/getCategory.ajax',
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);

				$.each(data, function(i, obj) {
					html += '<option value=' + obj.category_code + '>'
							+ obj.category_name + '</option>';
				});

				$('#category_code').html(html);
				$('#category_code_del').html(listHtml + html);
			}
		});
	}

	function putInfo() {
		var seq;
		var url;
		if(${info != null})
			url = '/survey/updateInfo.ajax';
		else
			url = '/survey/putInfo.ajax';
		
		$.ajax({
			type : 'POST',
			url : url,
			dataType : 'json',
			data : $('#writeForm').serialize(),
			async : false,
			success : function(data) {
				console.log(data);
				seq = data.survey_seq;				
			}
		});
		return seq;
	}

	function putQuestion() {
		
		if(!$('#title').val()){
			alert('문항 제목이 없습니다.');
			return;
		}
			
			
		$.ajax({
			type : 'POST',
			url : '/survey/putQuestion.ajax',
			dataType : 'text',
			data : $('#questionForm').serialize(),
			async : false,
			success : function(data) {
				var type = $('#type').val();

				// 				if(type == '2') {
				// 					$('#question_depth').removeAttr('readonly');
				// 					$('#question_depth').attr('min', '1');
				// 					$('#question_depth').val('1');
				// 				} else {
				// 					$('#question_order').val(++question_order);
				// 				}

// 				$('#question_order').val(++question_order);
				$('#questionForm')[0].reset();

				alert('문항 추가 완료');
			}
		});
		
		$.ajax({
			type : 'POST',
			url : '/survey/getQuestionMax.ajax',
			data : 'seq='+infoSeq,
			async : false,
			success : function(data) {
				$('#question_order').val(data);
			}
		});
		
		childTypeChange();
	}	

	function putCategory() {
		$.ajax({
			type : 'POST',
			url : '/survey/putCategory.ajax',
			dataType : 'json',
			data : $('#categoryForm').serialize(),
			async : false,
			success : function(data) {
				console.log(data);
			}
		});
// 		$('.modal').modal("hide");
		getParentCode();
		getCategory();
	}
	
	function delCategory() {
		if(!confirm("정말 삭제하시겠습니까?"))
			return;
		$.ajax({
			type : 'POST',
			url : '/admin/survey/deleteCategory.ajax',
			data : $('#categoryDelForm').serialize(),
			async : false,
			success : function(data) {
			}
		});
// 		$('.modal').modal("hide");
		getParentCode();
		getCategory();
	}
	
	function delParentCode() {
		if(!confirm("정말 삭제하시겠습니까?"))
			return;
		$.ajax({
			type : 'POST',
			url : '/admin/survey/deleteParentCode.ajax',
			data : $('#codeDelForm').serialize(),
			async : false,
			success : function(data) {
			}
		});
// 		$('.modal').modal("hide");
		getParentCode();
		getCategory();
	}

	function putQuestionCode() {
		$.ajax({
			type : 'POST',
			url : '/survey/putQuestionCode.ajax',
			dataType : 'json',
			data : $('#codeForm').serialize(),
			async : false,
			success : function(data) {
				console.log(data);
			}
		});
// 		$('.modal').modal("hide");
		getParentCode();
		getCategory();
	}
	
	function childTypeChange(bool) {
		var childType = $("#childType option:selected").val();
		
		if(childType == 'C') {
			$.ajax({
				type : 'POST',
				url : '/survey/getQuestionMax.ajax',
				data : 'seq='+infoSeq,
				async : false,
				success : function(data) {
					$('#question_order').attr('max', data-1);
					if(bool)
						$('#question_order').val(data-1);	
				}
			});
			
			$.ajax({
				type : 'POST',
				url : '/survey/getQuestionDepthMax.ajax',
				data : $('#questionForm').serialize(),
				async : false,
				success : function(data) {
					$('#question_depth').val(data);
				}
			});
			
			$('#question_order').attr('type', 'number');					
			$('#question_order').attr('min', '1');
			$('#question_order').removeAttr('readonly');
		} else {
			$.ajax({
				type : 'POST',
				url : '/survey/getQuestionMax.ajax',
				data : 'seq='+infoSeq,
				async : false,
				success : function(data) {
					$('#question_order').val(data);
				}
			});
			
			
			$('#question_depth').val(0);
			$('#question_order').attr('readonly', 'readonly');
		}
	}

	$('#startDate').datetimepicker({
		format : 'L'
	});
	$('#endDate').datetimepicker({
		format : 'L',
		useCurrent : false
	});
	$('#resultDate').datetimepicker({
		format : 'L',
		useCurrent : false
	});
	$("#startDate").on("dp.change", function(e) {
		$('#endDate').data("DateTimePicker").minDate(e.date);
	});
	$("#endDate").on("dp.change", function(e) {
		$('#startDate').data("DateTimePicker").maxDate(e.date);
		$('#resultDate').data("DateTimePicker").minDate(e.date);
	});
	$("#resultDate").on("dp.change", function(e) {
		$('#endDate').data("DateTimePicker").maxDate(e.date);
	});
	$("#finishBtn").on("click", function() {
		if(confirm("완료 하시겠습니까?")) {
			var valid = validCheck();
			
			if(valid != 'PASS'){
				alert(valid);
				return;
			}
			
			putInfo();
			adminSurvey();
		}
	});
</script>
