<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:forEach items="${list}" var="vo" varStatus="status">
	<div class='row'>
		<form class='form-horizontal'>
			<input type='hidden' name='survey_seq' value='${vo.survey_seq }' />
			<input type='hidden' name='originalOrder' value='${vo.question_order }' />
			<input type='hidden' name='originalDepth' value='${vo.question_depth }' />
			<div class='col-md-12'>
				<select id='question_order' name='question_order'>
					<c:forEach var="i" begin="1" end="${questionMax }">
						<option value='${i }' 
						<c:if test="${vo.question_order == i }"> selected</c:if>
						<c:if test="${vo.question_depth != 0 }"> disabled="disabled"</c:if>
						>${i }번</option>
					</c:forEach>
				</select>
				<select id='question_depth' name='question_depth'>
					<option value='0'
					<c:if test="${vo.question_depth != 0 }"> disabled="disabled"</c:if>>0번
					</option>
					<c:forEach var="i" begin="1" end="${vo.questionDepthMax }">
						<option value='${i }' 
						<c:if test="${vo.question_depth == i }"> selected</c:if>
						<c:if test="${vo.question_depth == 0 }"> disabled="disabled"</c:if>
						>${i }번</option>
					</c:forEach>
				</select>
				<select id='category_code' name='category_code'>
					<c:forEach items="${categoryList}" var="categoryVO" varStatus="status">
						<option value="${categoryVO.category_code }" 
						<c:if test="${vo.category_code == categoryVO.category_code }"> selected</c:if>
						>${categoryVO.category_name }</option>
					</c:forEach>
				</select>
				<input id='title' name='title' type='text' value='${vo.title }'/>
				<select id='type' name='type'>
					<option value='a' <c:if test="${vo.type == 'a'.charAt(0) }"> selected</c:if>>객관식</option>
					<option value='b' <c:if test="${vo.type == 'b'.charAt(0) }"> selected</c:if>>객관식 + 기타</option>
					<option value='c' <c:if test="${vo.type == 'c'.charAt(0) }"> selected</c:if>>객관식 + 없음</option>
					<option value='d' <c:if test="${vo.type == 'd'.charAt(0) }"> selected</c:if>>객관식 + 기타 + 없음</option>
					<option value='1' <c:if test="${vo.type == '1'.charAt(0) }"> selected</c:if>>주관식</option>
					<option value='2' <c:if test="${vo.type == '2'.charAt(0) }"> selected</c:if>>상위문항</option>
				</select>
				<select id='is_free' name='is_free'>
					<option value='d' <c:if test="${vo.is_free == 'd'.charAt(0) }"> selected</c:if>>기본 (필수)</option>
					<option value='n' <c:if test="${vo.is_free == 'n'.charAt(0) }"> selected</c:if>>필수</option>
					<option value='y' <c:if test="${vo.is_free == 'y'.charAt(0) }"> selected</c:if>>자율</option>
				</select>
				<select id='number' name='number'>
					<option value='1' <c:if test='${vo.number == 1}'> selected</c:if>>1개</option>
					<option value='2' <c:if test='${vo.number == 2}'> selected</c:if>>2개</option>
					<option value='3' <c:if test='${vo.number == 3}'> selected</c:if>>3개</option>
					<option value='4' <c:if test='${vo.number == 4}'> selected</c:if>>4개</option>
					<option value='5' <c:if test='${vo.number == 5}'> selected</c:if>>5개</option>
					<option value='6' <c:if test='${vo.number == 6}'> selected</c:if>>6개</option>
					<option value='7' <c:if test='${vo.number == 7}'> selected</c:if>>7개</option>
					<option value='8' <c:if test='${vo.number == 8}'> selected</c:if>>8개</option>
					<option value='9' <c:if test='${vo.number == 9}'> selected</c:if>>9개</option>
					<option value='10' <c:if test='${vo.number == 10}'> selected</c:if>>10개</option>
				</select>
				<select id='question_code' name='question_code'>
					<c:forEach items="${parentCode}" var="parentCodeVO" varStatus="status">
						<option value="${parentCodeVO.question_code }" 
						<c:if test="${vo.question_code == parentCodeVO.question_code }"> selected</c:if>
						>${parentCodeVO.question_name }</option>
					</c:forEach>
				</select>
				<button id='questionModBtn' type="button" class="btn btn-success" onclick='questionMod($(this))'>수정</button>
				<button id='questionDelBtn' type="button" class="btn btn-danger" onclick='questionDel($(this))'>삭제</button>
			</div>
		</form>
	</div>	
</c:forEach>
<script>
	function questionMod(obj) {
		var form = obj.parents('form');
		$('form select option').removeAttr('disabled');
// 		console.log(form.serialize());		
		$.ajax({
			type : 'POST',
			url : '/admin/survey/questionMod.ajax',
			data : form.serialize(),
			async : false,
			success : function(data) {
				getQuestionList();
				childTypeChange(true);
			}
		});
		
	}
	
	function questionDel(obj) {
		var form = obj.parents('form');
		$.ajax({
			type : 'POST',
			url : '/admin/survey/questionDel.ajax',
			data : form.serialize(),
			async : false,
			success : function(data) {
				getQuestionList();
				childTypeChange(true);
			}
		});
	}
</script>
