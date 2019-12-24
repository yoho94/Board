  <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <c:forEach items="${list}" var="boardVO" varStatus="status">
  <a href="/board/${boardVO.boardType }/${boardVO.url }/list">${boardVO.name}</a>
  </c:forEach>
  
  <!-- <a href="#">About</a>
  <a href="#">Services</a>
  <a href="#">Clients</a>
  <a href="#">Contact</a> -->
  
  	<hr>
	<form method="post" name='sidenavSearchForm' id='sidenavSearchForm'>
		<input type="hidden" name="page" id="page" value='<c:out default="1" value="${pageMaker.pvo.page }"/>'/>
		<div class='search row'>
			<div class='col-xs-3 col-sm-3'>
				<select name='perPageNum' class='form-control' id="perPageNum"
				onchange="sidenavList(1);">
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
			<div class='col-xs3 col-sm-3'>
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

			<div class='col-xs-6 col-sm-6'>
				<div class='input-group'>
					<input type="text" name="keyword" id="listKeywordInput"
						class='form-control' value="${pvo.keyword}"> <span
						class='input-group-btn'>
						<button type='button' id="searchBoardBtn" class='btn btn-primary'>검색</button>
					</span>

				</div>
			</div>

		</div>
	</form>

	<hr>
  
  	<div class='col-md-offset-3'>
		<ul class="pagination pagination-sm">
			<c:if test="${pageMaker.prev}">
				<li class='page-item'><a class='page-link'
					onclick="sidenavList(1);">처음</a></li>
				<li class='page-item'><a class='page-link'
					onclick="sidenavList('${pageMaker.startPage-1}');">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
				<li
					class='page-item 
						<c:if test="${pageMaker.pvo.page == idx}"> active</c:if>
						'>
					<%-- 						<c:out value="${pageMaker.pvo.page == idx?'class=page-item active':'' }"/>> --%>
					<a class='page-link' onclick="sidenavList('${idx}');">${idx}</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class='page-item'><a class='page-link'
					onclick="sidenavList('${pageMaker.endPage+1}');">다음</a></li>
				<li class='page-item'><a class='page-link'
					onclick="sidenavList('${pageMaker.totalPage}');">마지막</a></li>
			</c:if>

		</ul>
	</div>