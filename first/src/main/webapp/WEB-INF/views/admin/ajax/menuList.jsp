<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id='writeModalShow' class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content" id='writeModal'>
		</div>
	</div>
</div>

<div class='container'>
	<table class='table table-striped'>
		<colgroup>
			<col width="10%">
			<col>
			<col width="15%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>메뉴 번호</th>
				<th>메뉴 이름</th>
				<th>메뉴 URL</th>				
				<th>메뉴 순서</th>
				<th>메뉴 사용</th>
			</tr>
		</thead>
		<tbody id="menuTbody">
		<c:forEach items="${list}" var="menuVO" varStatus="status">
			<tr>
				<td>${menuVO.seq}</td>
				<td><a onclick="fncSelectMenu('${menuVO.seq}');">${menuVO.name }</a></td>
				<td>${menuVO.url}</td>
				<td>${menuVO.order}</td>
				<td>
				<c:if test="${menuVO.isUse eq 'Y'.charAt(0)}">사용</c:if>
				<c:if test="${menuVO.isUse ne 'Y'.charAt(0)}">미 사용</c:if>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${list.size() eq 0}">
			<tr>
				<td colspan="6">조회된 자료가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<hr>
	<form method="post" name='searchForm' id='searchForm'>
		<div class='search row'>
			<div class='col-xs-7 col-sm-7'>
				<div class='input-group'>
				<span	class='input-group-btn'>

						<button type='button' id="newMenuBtn" class='btn btn-light'>메뉴 생성</button>
					</span>

				</div>
			</div>

		</div>
	</form>


</div>

<script type="text/javascript">
  $('#menuTbody').sortable({
	  update : function(e, ui) {
		  
		  var seq = ui.item.children().eq(0).text();
		  var order = (Number(ui.item.index()) + 1);
		  var originalOrder = ui.item.children().eq(3).text();
		  
		  var menuData = "seq=" + seq + "&order=" + order + "&originalOrder=" + originalOrder;
// 		  console.log(boardData);
			$.ajax({
				type : 'POST',
				url : "/admin/ajax/updateMenuOrderSortable.ajax",
				async: false,
				data : menuData,
				success : function(data) {
					adminMenu();
					/* getNavbar(); */
// 					console.log(data);
				}
			});
	  }
  });
</script>