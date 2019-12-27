<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<%-- <c:import url="/board/sidenav"></c:import> --%>
<c:import url="/board/navbar"></c:import>
</head>
<script>
//팝업오픈하여 폼데이터 Post 전송
function openPop(form, action){    
    var width = 800;
    var height = 800;
    
    var popupX = (window.screen.width / 2) - (width / 2);
    var popupY= (window.screen.height / 2) - (height / 2);
    
    var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width="+width+", height="+height+", left="+popupX+",top=" + popupY;
    window.open('', 'popup', status);
    var frm = form ;
	frm.attr('action', action);
	frm.attr('method', 'post');
	frm.attr('target', 'popup');	
	frm.submit();
}

function getCookie(name){
    var nameOfCookie = name + "=";
    var x = 0;
    while (x <= document.cookie.length){
        var y = (x + nameOfCookie.length);
        if (document.cookie.substring(x, y) == nameOfCookie){
        if ((endOfCookie = document.cookie.indexOf(";", y)) == -1){
        endOfCookie = document.cookie.length;
        }
        return unescape (document.cookie.substring(y, endOfCookie));
        }
        x = document.cookie.indexOf (" ", x) + 1;
        if (x == 0) break;
    }
    return "";
}

function readSubmit(formObj) {
	formObj.action = "/board/${boardVO.boardType }/${boardVO.url }/readPage";
	formObj.submit();
}

$(document).ready(function(){
	var formObj = $("[id='readForm']");
	
	$("#newBtn").on("click", function(){
		openPop($(this.form), "/board/${boardVO.boardType }/${boardVO.url }/writePage");
// 		formObj.attr("action", "/writePage");
// 		formObj.submit();
	});
	$("[id='readSubmit']").on("click", function(){
		var form = $(this).parent('form');
		var isSecret = form.children("#isSecret").val();
		if(isSecret == 'Y') {
			var pw = prompt("비밀번호를 입력하세요");
			form.children("#pw").val(pw);
		}
		console.log(pw);
		openPop(form, "/board/${boardVO.boardType }/${boardVO.url }/readPage");
// 		formObj.attr("action", "/writePage");
// 		formObj.submit();
	});
	
	// 기존의 모달 팝업
	if('${noticeVO}' && getCookie("noticeBno${noticeVO.bno },id${loginVO.userId}") != "done")
		$('div.modal').modal({remote : '/modal'});
	
});
</script>

<!-- 새창 팝업 -->
<c:forEach items="${popupList}" var="vo" varStatus="status">
<script>
	var url = "/admin/showPopup?seq=${vo.seq}";
	var option = "width=${vo.width}, height=${vo.height + 50}, menubar=no, status=no, toolbar=no";
	
	if(getCookie("popupSeq${vo.seq },id${loginVO.userId}") != "done")
		window.open(url, "${vo.seq}", option);
</script>
</c:forEach>

<body>
	<div class='container'>
	
<div class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
        <!-- remote ajax call이 되는영역 -->
    </div>
  </div>
</div>
	<div class="text-center"><h1>${boardVO.name }</h1></div>
		<table class='table table-striped'>
			<colgroup>
				<col width="10%">
				<col>
				<col width="15%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:forEach items="${noticeVOList }" var="articleVO" varStatus="status">
				<tr>
					<td>${(pageMaker.totalCount - status.index) - ( (pageMaker.pvo.page - 1)  *  pageMaker.pvo.perPageNum ) }</td>
					<td>
						<form name='readForm' action='/board/${boardVO.boardType }/${boardVO.url }/readPage' method='post'
							id='readForm'>							
							<input type='hidden' name='boardId' value="<c:out value='${boardVO.boardId}'/>">
							<input type='hidden' name='url' value="<c:out value='${boardVO.url}'/>">
							<input type='hidden' name='bno' value="<c:out value='${articleVO.bno}'/>">
							<input type="hidden" name="page" value="${pageMaker.pvo.page}">
							<input type="hidden" name="perPageNum"
								value="${pageMaker.pvo.perPageNum}"> 
							<input type="hidden" name="searchType" value="${pvo.searchType}">
							<input type="hidden" name="keyword" value="${pvo.keyword}">
							<c:choose>
							<c:when test="${articleVO.isDelete == 'N'.charAt(0) }">
							<c:forEach begin="1" end="${articleVO.re_depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
						<c:if test="${articleVO.re_depth > 0}">
							<img src='/resources/img/icon_re.gif' alt='' />						
						</c:if>
							<input type='submit' id='readSubmit' class="btn btn-default"
									style="text-align: left; background-color: transparent;"
								value="<c:out value='[공지] ${articleVO.title}'/>">
							</c:when>
							<c:otherwise>
							삭제된 게시글 입니다.
							</c:otherwise>
							</c:choose>
						</form>
					</td>
					<td>${articleVO.writer}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${articleVO.regDate}" /></td>
					<td>${articleVO.viewcnt}</td>
				</tr>
			</c:forEach>
			<c:forEach items="${list}" var="articleVO" varStatus="status">
				<tr>
					<td>${(pageMaker.totalCount - status.index) - ( (pageMaker.pvo.page - 1)  *  pageMaker.pvo.perPageNum ) }</td>
					<td>
						<form name='readForm' action='/board/${boardVO.boardType }/${boardVO.url }/readPage' method='post'
							id='readForm'>
							<input type='hidden' name='pw' id='pw'>
							<input type='hidden' id='isSecret' name='isSecret' value="<c:out value='${articleVO.isSecret}'/>">
							<input type='hidden' name='boardId' value="<c:out value='${boardVO.boardId}'/>">
							<input type='hidden' name='url' value="<c:out value='${boardVO.url}'/>">
							<input type='hidden' name='bno' value="<c:out value='${articleVO.bno}'/>">
							<input type="hidden" name="page" value="${pageMaker.pvo.page}">
							<input type="hidden" name="perPageNum"
								value="${pageMaker.pvo.perPageNum}"> 
							<input type="hidden" name="searchType" value="${pvo.searchType}">
							<input type="hidden" name="keyword" value="${pvo.keyword}">
							<c:choose>
							<c:when test="${articleVO.isDelete == 'N'.charAt(0) }">
							<c:forEach begin="1" end="${articleVO.re_depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
						<c:if test="${articleVO.re_depth > 0}">
							<img src='/resources/img/icon_re.gif' alt='' />						
						</c:if>							
								<c:choose>
									<c:when test="${articleVO.isSecret != 'Y'.charAt(0) }">									
									<input type='submit' id='readSubmit' style="border: solid 0px black; text-align: left; background-color: transparent;"
									value="<c:out value='${articleVO.title}'/>">
									</c:when>
									<c:otherwise>
									<input type='submit' id='readSubmit' class='btn btn-default' style="border: solid 1px black; text-align: left; background-color: transparent;"
									value="<c:out value='[비밀글] ${articleVO.title}'/>">
									</c:otherwise>
								</c:choose>
								
							</c:when>
							<c:otherwise>
							삭제된 게시글 입니다.
							</c:otherwise>
							</c:choose>
						</form>
					</td>
					<td>${articleVO.writer}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${articleVO.regDate}" /></td>
					<td>${articleVO.viewcnt}</td>
				</tr>
			</c:forEach>
		</table>

		<hr>
	<form action="/board/${boardVO.boardType }/${boardVO.url }/list" method="post" name='searchForm' id='searchForm'>
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

							<button type='button' id="newBtn" class='btn btn-light'>글쓰기</button>
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
						href="/board/${boardVO.boardType }/${boardVO.url }/list${pageMaker.makeSearch(1)}">처음</a></li>
					<li class='page-item'><a class='page-link'
						href="/board/${boardVO.boardType }/${boardVO.url }/list${pageMaker.makeSearch(pageMaker.startPage-1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }" var="idx">
					<li class='page-item 
						<c:if test="${pageMaker.pvo.page == idx}"> active</c:if>
						'>
<%-- 						<c:out value="${pageMaker.pvo.page == idx?'class=page-item active':'' }"/>> --%>
						<a class='page-link' href="/board/${boardVO.boardType }/${boardVO.url }/list${pageMaker.makeSearch(idx)}">${idx}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class='page-item'><a class='page-link' href="/board/${boardVO.boardType }/${boardVO.url }/list${pageMaker.makeSearch(pageMaker.endPage+1)}">다음</a></li>
					<li class='page-item'><a class='page-link' href="/board/${boardVO.boardType }/${boardVO.url }/list${pageMaker.makeSearch(pageMaker.totalPage)}">마지막</a></li>
				</c:if>

			</ul>
		</div>
	</div>
</body>

</html>