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
			<col width="15%">
			<col>
			<col>
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>게시판 번호</th>
				<th>게시판 유형</th>
				<th>게시판 이름</th>				
				<th>게시판 설명</th>
				<th>게시판 URL</th>
				<th>게시판 순서</th>
				<th>게시판 사용</th>
			</tr>
		</thead>
		<tbody id="boardTbody">
		<c:forEach items="${list}" var="boardVO" varStatus="status">
			<tr>
				<td>${boardVO.boardId}</td>
				<td>
				<c:if test="${boardVO.boardType eq 'basic'.toString() }">
					기본 게시판
				</c:if>
				<c:if test="${boardVO.boardType eq 'survey'.toString() }">
					설문 게시판
				</c:if>
				<c:if test="${boardVO.boardType eq 'notice'.toString() }">
					알림 게시판
				</c:if>				
				</td>
				<td>
					<a href="#none" onclick="fncSelectBoard('${boardVO.boardId}');">${boardVO.name}</a>
				</td>
				<td>${boardVO.note}</td>
				<td>${boardVO.url}</td>
				<td>${boardVO.order}</td>
				<td>
				<c:if test="${boardVO.isUse eq 'Y'.charAt(0)}">사용</c:if>
				<c:if test="${boardVO.isUse ne 'Y'.charAt(0)}">미 사용</c:if>
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
		<input type="hidden" name="page" id="page" value='<c:out default="1" value="${pageMaker.pvo.page }"/>'/>
		<div class='search row'>
			<div class='col-xs-2 col-sm-2'>
				<select name='perPageNum' class='form-control' id="perPageNum"
				onchange="boardList(1);">
					<option value="3"
						<c:if test="${pageMaker.pvo.perPageNum == '3'}">selected="selected"</c:if>>3개</option>
					<option value="5"
						<c:if test="${pageMaker.pvo.perPageNum == '5'}">selected="selected"</c:if>>5개</option>
					<option value="10"
						<c:if test="${pageMaker.pvo.perPageNum == '10'}">selected="selected"</c:if>>10개</option>
					<option value="15"
						<c:if test="${pageMaker.pvo.perPageNum == '15'}">selected="selected"</c:if>>15개</option>
					<option value="20"
						<c:if test="${pageMaker.pvo.perPageNum == '20'}">selected="selected"</c:if>>20개</option>
					<option value="50"
						<c:if test="${pageMaker.pvo.perPageNum == '50'}">selected="selected"</c:if>>50개</option>
				</select>
			</div>
			<div class='col-xs-2 col-sm-2'>
				<select name="searchType" class='form-control' id='type'>
					<option value="n"
						<c:out value="${pvo.searchType == null?'selected':''}"/>>---</option>
					<option value="t"
						<c:out value="${pvo.searchType eq 't'?'selected':''}"/>>제목</option>
					<option value="c"
						<c:out value="${pvo.searchType eq 'c'?'selected':''}"/>>본문</option>
					<option value="w"
						<c:out value="${pvo.searchType eq 'w'?'selected':''}"/>>작성자</option>
					<option value="tc"
						<c:out value="${pvo.searchType eq 'tc'?'selected':''}"/>>제목
						+ 본문</option>
					<option value="cw"
						<c:out value="${pvo.searchType eq 'cw'?'selected':''}"/>>본문
						+ 작성자</option>
					<option value="tcw"
						<c:out value="${pvo.searchType eq 'tcw'?'selected':''}"/>>제목
						+ 본문 + 작성자</option>
				</select>
			</div>

			<div class='col-xs-7 col-sm-7'>
				<div class='input-group'>
					<input type="text" name="keyword" id="listKeywordInput"
						class='form-control' value="${pvo.keyword}"> <span
						class='input-group-btn'>
						<button type='button' id="searchBoardBtn" class='btn btn-primary'>검색</button>

						<button type='button' id="newBoardBtn" class='btn btn-light'>게시판 작성</button>
					</span>

				</div>
			</div>

		</div>
	</form>

	<hr>

	<div class='col-md-offset-3'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class='page-item'><a class='page-link'
					onclick="boardList('1');">처음</a></li>
				<li class='page-item'><a class='page-link'
					onclick="boardList('${pageMaker.startPage-1}');">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
				<li
					class='page-item 
						<c:if test="${pageMaker.pvo.page == idx}"> active</c:if>
						'>
					<%-- 						<c:out value="${pageMaker.pvo.page == idx?'class=page-item active':'' }"/>> --%>
					<a class='page-link' onclick="boardList('${idx}');">${idx}</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class='page-item'><a class='page-link'
					onclick="boardList('${pageMaker.endPage+1}');">다음</a></li>
				<li class='page-item'><a class='page-link'
					onclick="boardList('${pageMaker.totalPage}');">마지막</a></li>
			</c:if>

		</ul>
	</div>
</div>

<script type="text/javascript">
  $('#boardTbody').sortable({
	  update : function(e, ui) {
		  var page = Number($('#page').val());
		  var perPageNum = Number($('#perPageNum option:selected').val());
		  
		  var boardId = ui.item.children().eq(0).text();
		  var order = (Number(ui.item.index()) + 1) + ((page-1) * perPageNum);
		  var originalOrder = ui.item.children().eq(5).text();
		  
		  var boardData = "boardId=" + boardId + "&order=" + order + "&originalOrder=" + originalOrder;
// 		  console.log(boardData);
			$.ajax({
				type : 'POST',
				url : "/admin/ajax/updateBoardOrderSortable.ajax",
				async: false,
				data : boardData,
				success : function(data) {
					boardList(page);
// 					console.log(data);
				}
			});
	  }
  });
</script>