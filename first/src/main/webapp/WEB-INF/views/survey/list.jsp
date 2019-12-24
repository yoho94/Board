<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<%-- <jsp:include page="/resources/include/navbar.jsp"></jsp:include> --%>
<c:import url="/board/navbar"></c:import>
</head>
<c:if test="${list.size() == 0}">
	<script>
		alert('진행중인 설문이 없습니다.');
	</script>
</c:if>
<body>
	<div class='container'>

		<table class='table table-striped'>
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
				</tr>
			</thead>
			<c:forEach items="${list}" var="infoVO" varStatus="status">
				<tr>
					<td>${infoVO.survey_seq}</td>
					<td>
						<form name='infoForm' action='/survey/info' method='post' id='infoForm'>
							<input type='hidden' name='survey_seq'	value="${infoVO.survey_seq}">
							<input type='submit' id='infoSubmit' value="${infoVO.agency_name}"
							style="bordr-width: 1px; text-align: left; background-color: transparent;">								
						</form>
					</td>
					<td>
					<fmt:formatDate pattern="yy. MM. dd.(E)" value="${infoVO.start_date}" /> ~ 
					<fmt:formatDate pattern="yy. MM. dd.(E)" value="${infoVO.end_date}" />
					</td>
					<td>${infoVO.question_count }</td>
					<td>${infoVO.answer_people_count}</td>
				</tr>
			</c:forEach>
		</table>

		<hr>
<%-- 		<c:if test="${loginVO.isAdmin == '1'}"> 
			<form action="/survey/write" method="post" name='searchForm' id='searchForm'>
				<div class='col-xs-7 col-sm-7'>
					<div class='input-group'>
						<button type='submit' id="newBtn" class='btn btn-light'>설문 등록</button>
					</div>
				</div>
			</form>
			</c:if> --%>
		<hr>

	</div>
</body>

</html>