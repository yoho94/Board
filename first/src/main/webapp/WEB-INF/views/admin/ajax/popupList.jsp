<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<table class='table table-bordered table-hover'>
	<colgroup>
		<col width="15%">
		<col>
		<col width="30%">
		<col width="15%">
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>사용 / 미사용</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="popupVO" varStatus="status">
		<tr>
			<td>${popupVO.seq}</td>
			<td>${popupVO.title}</td>
			<td>
			<fmt:formatDate pattern="yy. MM. dd.(E)" value="${popupVO.start_date}" /> ~ 
			<fmt:formatDate pattern="yy. MM. dd.(E)" value="${popupVO.end_date}" />
			</td>
			<td>
			<c:if test="${popupVO.isUsing == 'Y'.charAt(0)}">사 용</c:if>
			<c:if test="${popupVO.isUsing == 'N'.charAt(0)}">미사용</c:if>						
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<button id='writeBtn' type="button" class="btn btn-info">팝업 등록</button>

<div id='popupModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">팝업 상세 보기</h5>
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
					<button id='useBtn' type="button" class="btn btn-default">사 용</button>
					<button id='unUseBtn' type="button" class="btn btn-danger">미사용</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id='showPopupBtn'>팝업 보기</button>
				<button type="button" class="btn btn-success" id='popupModifyBtn'>수정</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div id='writeModalShow' class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content" id='writeModal'>
		</div>
	</div>
</div>

<script>
	$('table tbody tr').off().on('click', function() {
		var str = '';
		var tr = $(this);
		var td = tr.children();

		$.ajax({
			type : 'POST',
			url : "/admin/ajax/popupDetails",
			data : "seq=" + td.eq(0).text(),
			async: false,
			dataType : "html",
			success : function(data) {
				$('#popupModal .modal-body .details').html(data);
				
				$('#popupModifyBtn').on('click', function() {
// 					hideModal();
// 					$('#writeModal').modal({
// 						remote : "/admin/ajax/popupMod?seq="+td.eq(0).text(),
								
// 					});

					$.ajax({
						type : 'POST',
						url : "/admin/ajax/popupMod",
						data : "seq="+td.eq(0).text(),
						async: false,
						dataType : "html",
						success : function(data) {
							$('#writeModal').html(data);
							$('#writeModalShow').modal('show');
						}
					});
					
				});
				
			}
		});		

		$('#useBtn').on('click', function() {
			$.ajax({
				type : 'POST',
				url : "/admin/ajax/popupUsingUpdate.ajax",
				data : "seq=" + td.eq(0).text() + "&isUsing=Y",
				async : false,
				success : function(data) {
					hideModal();
					adminPopup();
				}
			});
		});

		$('#unUseBtn').on('click', function() {
			$.ajax({
				type : 'POST',
				url : "/admin/ajax/popupUsingUpdate.ajax",
				data : "seq=" + td.eq(0).text() + "&isUsing=N",
				async : false,
				success : function(data) {
					hideModal();
					adminPopup();
				}
			});
		});
		
		$('#showPopupBtn').off().on('click', function() {
			var url = "/admin/showPopup?seq=" + td.eq(0).text();
			var option = "width=" + $('#width').val() + ", height=" + $('#height').val() + ", menubar=no, status=no, toolbar=no";
			
			window.open(url, td.eq(0).text(), option);
		});
		
		$('#popupModal').modal('show');
	});

	$('#writeBtn').on('click', function() {		
// 		$('#writeModal').modal({
// 			remote : "/admin/ajax/popupWrite"
// 		});

		$.ajax({
			type : 'POST',
			url : "/admin/ajax/popupWrite",
			async: false,
			dataType : "html",
			success : function(data) {
				$('#writeModal').html(data);
				$('#writeModalShow').modal('show');
			}
		});
		
	});
	
</script>