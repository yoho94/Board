<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
	<ul>
		<li>작성자 ID : ${info.admin_id }</li>
		<li>생성일 : 
		<fmt:formatDate pattern="yy. MM. dd.(E)" value="${info.reg_date}" />
		</li>
		<li>수정일 : 
		<fmt:formatDate pattern="yy. MM. dd.(E)" value="${info.mod_date}" />
		</li>
		<li>사용여부 : 
		<c:if test="${info.isUsing == 'Y'.charAt(0)}">사 용</c:if>
		<c:if test="${info.isUsing == 'N'.charAt(0)}">미사용</c:if>
		</li>
	</ul>
	
	
