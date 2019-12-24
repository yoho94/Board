<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>홈 페이지</title>
<%-- <jsp:include page="/resources/include/navbar.jsp"></jsp:include> --%>
<c:import url="/board/navbar"></c:import>
</head>
<body>
<script>
var msg = '${msg}';
if(msg)
	alert(msg);
</script>
<div class='container'>
	${info.survey_head }
	<br>
	${info.survey_content }
	<br>
	<ul>
		<li>조사주관 : ${info.agency_name }</li>
		<li>참여대상 : 회원(로그인 필요)</li>
		<li>참여기간 : '<fmt:formatDate pattern="yy. MM. dd.(E)"
							value="${info.start_date}" /> ~ '<fmt:formatDate pattern="yy. MM. dd.(E)"
							value="${info.end_date}" />, 총 ${info.period}일간</li>
		<li>참여방법 : 하단의 설문시작 버튼을 클릭하여 총 ${info.question_count }개의 문항에 답변을 마치면 응모완료!</li>
		<li>당첨자발표 : '<fmt:formatDate pattern="yy. MM. dd.(E)"
							value="${info.result_date}" />, 퓨전소프트 공지사항 게시판</li>
	</ul>
	<br>
	${info.survey_foot }
	<hr>
	<form action="/survey/question" method="post">
		<input type='hidden' name='seq' value='${info.survey_seq }'>
		<input type='hidden' name='survey_seq' value='${info.survey_seq }'>
		<button type='submit' class='btn btn-default'>시작</button>
	</form>
	
	<c:if test="${loginVO.isAdmin == '1'}">
		<form action="/survey/chart" method="post">
				<input type='hidden' name='seq' value='${info.survey_seq }'>
				<input type='hidden' name='survey_seq' value='${info.survey_seq }'>
				<button type='submit' class='btn btn-light'>통계</button>
		</form>
	</c:if>
</div>
</body>
</html>