<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
</head>
<script>
//팝업오픈하여 폼데이터 Post 전송
function openPop(form, action){    
    var width = 800;
    var height = 800;
    
    var popupX = (window.screen.width / 2) - (width / 2);
    var popupY= (window.screen.height / 2) - (height / 2);
    
    var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width="+width+", height="+height+", left="+popupX+",top=" + popupY;
    
    var frm = form ;
	frm.attr('action', action);
	frm.attr('method', 'post');
	frm.attr('target', 'popup');
	window.open('', 'popup', status);
	frm.submit();
}

function del(formObj){
	
	if(confirm("정말 삭제하시겠습니까?")) {
		formObj.action = "/adminRemoveAction";
		formObj.submit();
	}
	
}

function realDel(formObj){
	
	if(confirm("정말 완전삭제하시겠습니까? 답글까지 전부 삭제됩니다.")) {
		formObj.action = "/realRemoveAction";
		formObj.submit();
	}
	
}

function restoreBtn(formObj){
	
	if(confirm("정말 복구 하시겠습니까?")) {
		formObj.action = "/restore";
		formObj.submit();
	}
	
}


$(document).ready(function(){
	var formObj = $("[id='readForm']");
	
// 	$("#newBtn").on("click", function(){
// 		openPop(formObj, "/writePage");
// // 		formObj.attr("action", "/writePage");
// // 		formObj.submit();
// 	});
	$("[id='readSubmit']").on("click", function(){
		openPop(formObj, "/readPage");
// 		formObj.attr("action", "/writePage");
// 		formObj.submit();
	});
	
// 	$("[id='deleteBtn']").on("click", function(){
// 		if(confirm("정말 삭제하시겠습니까?")) {
// 			formObj.attr("action", "/removeAction");
// 			formObj.submit();
// 			location.reload();
// 		}
// 	});
	
// 	$("[id='realDeleteBtn']").on("click", function(){
// 		if(confirm("정말 완전삭제하시겠습니까? 답글까지 전부 삭제됩니다.")) {
// 			formObj.attr("action", "/realRemoveAction");
// 			formObj.submit();
// 			location.reload();
// 		}
// 	});
	
// 	if(getCookie("noticeCookie${noticeVO.bno }") != "done")
// 		$('div.modal').modal({remote : '/modal'});
	
	
});


</script>
<body>
	<div class='container'>
	
<div class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
        <!-- remote ajax call이 되는영역 -->
    </div>
  </div>
</div>
		<table class='table table-striped'>
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col>
				<col width="10%">
				<col width="15%">
				<col width="7%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>복구, 삭제, 완전삭제</th>
				</tr>
			</thead>
			<c:forEach items="${list}" var="boardVO" varStatus="status">
				<tr>
					<td>${(pageMaker.totalCount - status.index) - ( (pageMaker.pvo.page - 1)  *  pageMaker.pvo.perPageNum ) }</td>
					<td>${boardVO.bno}</td>
					<td>
						<form name='readForm' action='/readPage' method='post'
							id='readForm'>
							<input type='hidden' name='bno' value="<c:out value='${boardVO.bno}'/>">
							<input type="hidden" name="page" value="${pageMaker.pvo.page}">
							<input type="hidden" name="perPageNum"
								value="${pageMaker.pvo.perPageNum}"> 
							<input type="hidden" name="searchType" value="${pvo.searchType}">
							<input type="hidden" name="keyword" value="${pvo.keyword}">
							<c:choose>
							<c:when test="${boardVO.isDelete == 0 }">
							<c:forEach begin="1" end="${boardVO.re_depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
						<c:if test="${boardVO.re_depth > 0}">
							<img src='/resources/img/icon_re.gif' alt='' />						
						</c:if>
							<input type='submit' id='readSubmit'
								<c:choose>
									<c:when test="${boardVO.isNotice == 0 }">									
									style="border: solid 0px black; text-align: left; background-color: transparent;"
									</c:when>
									<c:otherwise>
									style="bordr-width: 1px; border-color:blue; text-align: left; background-color: transparent;"
									</c:otherwise>
								</c:choose>
								value="<c:out value='${boardVO.title}'/>">
							</c:when>
							<c:otherwise>
							<input type='submit' id='readSubmit' value='${boardVO.title}' 
							style="bordr-width: 1px; border-color:red; text-align: left;"/>
							</c:otherwise>
							</c:choose>
						</form>
					</td>
					<td>${boardVO.writer}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${boardVO.regdate}" /></td>
					<td>${boardVO.viewcnt}</td>
					<td>
					<form name='delForm' method='post'
							id='delForm'>
							<input type='hidden' name='bno' value="<c:out value='${boardVO.bno}'/>">
							<input type='hidden' name='re_group' value="<c:out value='${boardVO.re_group}'/>">
							<input type="hidden" name="page" value="${pageMaker.pvo.page}">
							<input type="hidden" name="perPageNum"
								value="${pageMaker.pvo.perPageNum}"> 
							<input type="hidden" name="searchType" value="${pvo.searchType}">
							<input type="hidden" name="keyword" value="${pvo.keyword}">
					<button type='button' id="restore" class='btn btn-primary' onclick="restoreBtn(this.form)">복구</button>
					<button type='button' id="deleteBtn" class='btn btn-info' onclick="del(this.form)">삭제</button>
					<button type='button' id="realDeleteBtn" class='btn btn-danger' onclick="realDel(this.form)">완전삭제</button>		
					</form>
					</td>
				</tr>
			</c:forEach>
		</table>

		<hr>
	<form action="/adminPage" method="post" name='searchForm' id='searchForm'>
		<div class='search row'>
			<div class='col-xs-2 col-sm-2'>
					<select name='perPageNum' class='form-control'
						onchange='this.form.submit()'>
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
					<option value="del"
						<c:out value="${pvo.searchType eq 'del'?'selected':''}"/>>삭제글 + 제목</option>
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
							<button type='submit' id="searchBtn" class='btn btn-primary'>검색</button>

<!-- 							<button type='button' id="newBtn" class='btn btn-light'>글쓰기</button> -->
						</span>

					</div>
				</div>
			
		</div>
	</form>

		<hr>

		<div class='col-md-offset-3'>
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class='page-item'><a class='page-link' href="adminPage${pageMaker.makeSearch(1)}">처음</a></li>
					<li class='page-item'><a class='page-link'
						href="adminPage${pageMaker.makeSearch(pageMaker.startPage-1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }" var="idx">
					<li class='page-item 
						<c:if test="${pageMaker.pvo.page == idx}"> active</c:if>
						'>
<%-- 						<c:out value="${pageMaker.pvo.page == idx?'class=page-item active':'' }"/>> --%>
						<a class='page-link' href="adminPage${pageMaker.makeSearch(idx)}">${idx}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class='page-item'><a class='page-link' href="adminPage${pageMaker.makeSearch(pageMaker.endPage+1)}">다음</a></li>
					<li class='page-item'><a class='page-link' href="adminPage${pageMaker.makeSearch(pageMaker.totalPage)}">마지막</a></li>
				</c:if>

			</ul>
		</div>
	</div>
</body>

</html>