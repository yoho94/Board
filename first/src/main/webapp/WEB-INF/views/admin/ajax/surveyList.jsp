<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<table class='table table-bordered table-hover'>
	<colgroup>
		<col width="10%">
		<col>
		<col width="25%">
		<col width="10%">
		<col width="10%">
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>조사주관</th>
			<th>날짜</th>
			<th>문항 수</th>
			<th>설문응답 수</th>
			<th>사 용 / 미사용</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="infoVO" varStatus="status">
		<tr>
			<td>${infoVO.survey_seq}</td>
			<td>${infoVO.agency_name}</td>
			<td>
			<fmt:formatDate pattern="yy. MM. dd.(E)" value="${infoVO.start_date}" /> ~ 
			<fmt:formatDate pattern="yy. MM. dd.(E)" value="${infoVO.end_date}" />
			</td>
			<td>${infoVO.question_count }</td>
			<td>${infoVO.answer_people_count}</td>
			<td>
			<c:if test="${infoVO.isUsing == 'Y'.charAt(0)}">사 용</c:if>
			<c:if test="${infoVO.isUsing == 'N'.charAt(0)}">미사용</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<button id='writeBtn' type="button" class="btn btn-info">설문조사 등록</button>

<div id='surveyModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">설문 상세 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="details">
				</div>
				<hr>
				<div class="modify text-center">
					<button id='useBtn' type="button" data-dismiss="modal" class="btn btn-default">사 용</button>
					<button id='unUseBtn' type="button" data-dismiss="modal" class="btn btn-danger">미사용</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id='questionModify'>수정</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>	
	$('table tbody tr').on('click', function() {
		var str = '';
		var tr = $(this);
		var td = tr.children();
		
		$.ajax({
			type : 'POST',
			url : "/admin/survey/surveyDetails.ajax",
			data : "seq=" + td.eq(0).text(),
			async: false,
			dataType : "html",
			success : function(data) {
				$('.modal .modal-body .details').html(data);
				
				$('#questionModify').on('click', function() {
					$.ajax({
						type : 'POST',
						url : "/survey/write",
						data : "seq=" + td.eq(0).text(),
						dataType : "html",
						success : function(data) {
							$(".row").html(data);
							$("#sidebar li").removeAttr('class');
							$("#adminSurveyLi").attr('class', 'active');
							
							hideModal();
						}
					});
				});
				
			}
		});		

		
		$('#useBtn').on('click', function() {
			$.ajax({
				type : 'POST',
				url : "/admin/survey/updateUsing.ajax",
				data : "seq=" + td.eq(0).text(),
				async: false,
				dataType : "text",
				success : function(data) {
					hideModal();
					adminSurvey();
				}
			});
		});
		
		$('#unUseBtn').on('click', function() {
			$.ajax({
				type : 'POST',
				url : "/admin/survey/updateUnUsing.ajax",
				data : "seq=" + td.eq(0).text(),
				async: false,
				dataType : "text",
				success : function(data) {
					hideModal();
					adminSurvey();
				}
			});
		});
		
		
		$('.modal').modal('show');
	});
	
	$('#writeBtn').on('click', function() {
		$.ajax({
			type : 'POST',
			url : "/survey/write",
			dataType : "html",
			success : function(data) {
				$(".row").html(data);
				$("#sidebar li").removeAttr('class');
				$("#adminSurveyLi").attr('class', 'active');
			}
		});
	});
	
	
</script>