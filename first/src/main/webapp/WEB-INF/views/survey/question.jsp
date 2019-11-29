<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>홈 페이지</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/card.css">
</head>
<body>
	<script type="text/javascript">
		var seq = ${seq};
		var page = ${page};
		var maxPage = ${maxPage};
		var answerCount = ${answerCount};
		var questionCount = ${questionCount};
		var list_data, answer_data, code_data;
		var msg = '${msg}';
		var pageFirstQuestion;
		var pageLastQuestion;
		var per;

		function prevPage() {
			if(page > 1) {
				getList(seq, page - 1);			
				getAnswer(seq, page - 1);
				checkboxInit();
				getProgress(seq);
				
				page--;
			}
			btnDisabledCheck();
		}
		function nextPage() {	
			if(!validityCheck()) // 유효성 검사.
				return;
			
			if(page < maxPage) {
				$.each(list_data, function(i, obj) {
					var form = $('form[name='+i+']');
					sendAnswer(form);
				});				
				getList(seq, page + 1);
				getAnswer(seq, page + 1);	
				getProgress(seq);
				checkboxInit();
				
				page++;				
				
			}
			btnDisabledCheck();
			// 완료 기능. 완료 버튼을 따로 만들어 주석처리.
// 			else {
// 				$.each(list_data, function(i, obj) {
// 					var form = $('form[name='+i+']');
// 					sendAnswer(form);
// 				});
				
// 				window.location.href = '/survey/info';
// 				alert("수고하셨습니다.");
// 			}
			
		}

		function getQuestionCode(code) {
			$.ajax({
				type : 'POST',
				url : '/survey/questionCode.ajax',
				dataType : 'json',
				data : 'code=' + code,
				async: false,
				success : function(data) {
					console.log(data);
					code_data = data;
				}
			});
		}

		function getList(seq, page) {
			var html = '';
			var cnt = 0;
			$("#rowDiv").html(html);
			$.ajax({
				type : 'POST',
				url : '/survey/questionList.ajax',
				dataType : 'json',
				data : 'seq=' + seq + '&page=' + page,
				async: false,
				success : function(data) {
					list_data = data;
					console.log(data);

					$.each(data, function(i, obj) {
						html = '';
						html += "<div class='col-12'>";
						html += "<div class='card card-default'>";
						html += "<div class='card-header'>";
						html += "<b>";
						html += "문항 " + obj.question_order;
						if (obj.question_depth > 0) {
							html += "-" + obj.question_depth;
						}
						html += ". ";
						if (obj.category_name) {
							html += "[";
							html += obj.category_name;
							html += "] ";
						}
						html += "</b>"
						html += obj.title;
						if (obj.number > 1) {
							html += " (";
							html += obj.number;
							html += "개 선택)";
						}
						if (obj.is_free == 'y') {
							html += " (자율)";
						} else if (obj.is_free == 'n') {
							html += " (필수)";
						}
							
						html += "</div>";
						html += "<div class='card-body'>";
						html += "<form class='form' name="+cnt+">";
						html += "<input type='hidden' name='survey_seq' value=" + seq + ">";
						html += "<input type='hidden' name='question_order' value=" + obj.question_order + ">";
						html += "<input type='hidden' name='question_depth' value=" + obj.question_depth + ">";
						if (obj.question_depth >= 0) {
							if(obj.type >= 'a' && obj.type <= 'd'){ // 객관식 이면
								getQuestionCode(obj.question_code);
								$.each(code_data, function(j, code_obj) {
									html += "<label>";
									html += "<input type='checkbox' name='choice_answer' value="+(j+1)+">";
									html += code_obj.question_name;
									html += "</label>";
									html += "&nbsp;&nbsp;";
								});
								if(obj.type == 'b' || obj.type == 'd') { // 객관식 기타 이면
									html += "<label>";
									html += "<input type='checkbox' name='choice_answer' value='기타'>";
									html += '기타';
									html += "</label>";
									html += "<input type='text'>";
									html += "&nbsp;&nbsp;";
								}
								if(obj.type =='c' || obj.type == 'd') { // 객관식 없음 이면
									html += "<label>";
									html += "<input type='checkbox' name='choice_answer_null'>";
									html += '없음';
									html += "</label>";
									html += "&nbsp;&nbsp;";
								}
								
							}else if (obj.type == '1') {	
								html += "<textarea class='form-control' rows='3' name='subjective_answer'></textarea>";
							}
						}
						html += "</form>";
						html += "</div>";
						html += "</div>";
						html += "</div>";
						
						$("#rowDiv").append(html);
						cnt++;
					});
				}
			});
		}		

		function validityCheck() {
			var check = true;
			
			$.each(list_data, function(i, obj) {
				if(obj.is_free == 'y')
					return;
				
				if(obj.type != '1' && obj.type != '2') {					
					var cnt = obj.number; // 1개 선택인지 복수 선택인지
					var checkCnt = $('form[name='+i+'] input[type=checkbox]:checked').length; // 체크된 개수
					var checkNull = $('form[name='+i+'] input[name=choice_answer_null]:checked').length; // 없음 체크 확인.
					var checkOther = $('form[name='+i+'] input[value=기타]:checked').length; // 기타 체크 확인.
					
					if(checkNull > 0){
						return;
					}
					
					if(checkOther > 0) {
						var otherStr = $('form[name='+i+'] input[type=text]').val();
						otherStr = $.trim(otherStr);
						
						if(!otherStr) {
							if(obj.question_depth > 0)
								str = obj.question_order + "-" + obj.question_depth + "문항 기타에 글을 써주세요.";
							else
								str = obj.question_order + "문항 기타에 글을 써주세요.";
							
							alert(str);
							check = false;
							return false;
						}						
					}					
					
					if(cnt != checkCnt) {						
						if(obj.question_depth > 0)
							str = obj.question_order + "-" + obj.question_depth + "문항에 선택해주세요.";
						else
							str = obj.question_order + "문항에 선택해주세요.";
						
						alert(str);
						check = false;
						return false;
					} 				
				} else if (obj.type == '1') {
					var areaStr = $('form[name='+i+'] textarea').val();
					areaStr = $.trim(areaStr);
					
					if(!areaStr){
						if(obj.question_depth > 0)
							str = obj.question_order + "-" + obj.question_depth + "문항에 글을 써주세요.";
						else
							str = obj.question_order + "문항에 글을 써주세요.";
						
						alert(str);
						check = false;
						return false;
					}
				}
			});
			
			return check;
		}
		
		function getAnswer(seq, page) {
			$.ajax({
				type : 'POST',
				url : '/survey/answerList.ajax',
				dataType : 'json',
				data : 'seq=' + seq + '&page=' + page,
				async: false,
				success : function(data) {
					answer_data = data;
					
					$.each(data, function(i, obj) {
						
						if(!obj.choice_answer && !obj.subjective_answer) { // 객관식 답이 없고 주관식 답이 없으면 == 없음
							$('form[name='+i+'] input[name=choice_answer_null]').attr('checked', true);
						} else if(obj.choice_answer) { // 객관식 답이 있으면
							var choiceArr = obj.choice_answer.split("@@");
							
							for(var j=0; j<choiceArr.length - 1; j++) {
								$('form[name='+i+'] input[value='+choiceArr[j]+']').attr('checked', true);
							}
							
							if(obj.subjective_answer) { // 객관식 답이 있고 주관식 답도 있으면 == 기타								
								$('form[name='+i+'] input[type=text]').val(obj.subjective_answer);
							}
							
						} else if(obj.subjective_answer) { // 객관식 답이 없고 주관식 답이 있으면 == 주관식
							$('form[name='+i+'] textarea').val(obj.subjective_answer);
						}
						
					});
				}
			});
		}
		
		function getProgress(seq) {
			$.ajax({
				type : 'POST',
				url : '/survey/getProgress.ajax',
				data : "seq="+seq,
				dataType : 'json',
				async: false,
				success : function(data) {
					per = data.answerCount/data.questionCount * 100;
					$('.progress-bar').attr('style', 'width:'+ per + '%;');
					$('.progress-bar').html(data.answerCount+'/'+data.questionCount);
				}
			});				
		}
		
		function sendAnswer(form) {
			$.ajax({
				type : 'POST',
				url : '/survey/answerInsert.ajax',
				data : form.serialize(),
				async: false,
				success : function(data) {
				
				}
			});
		}
				
		function checkboxInit() {
			$.each(list_data, function(i, obj) {
				$('form[name='+i+'] input[type=checkbox]').change(function() {
					var cnt = obj.number; // 1개 선택인지 복수 선택인지
					var checkCnt = $('form[name='+i+'] input[type=checkbox]:checked').length; // 체크된 개수
					var checkNull = $('form[name='+i+'] input[name=choice_answer_null]:checked').length; // 없음 체크 확인.
					var checkOther = $('form[name='+i+'] input[value=기타]:checked').length; // 기타 체크 확인.
					
					if(checkOther > 0) {
						$('form[name='+i+'] input[type=text]').attr('name', 'subjective_answer');
					} else {
						$('form[name='+i+'] input[type=text]').attr('name', '');
					}
					
					if(checkNull > 0){
						$('form[name='+i+'] input[name=choice_answer]').attr('checked', false);
						$('form[name='+i+'] input[type=checkbox]:not(:checked)').attr("disabled", "disabled");
						$('form[name='+i+'] input[type=text]').attr('name', '');
					} else if(cnt == checkCnt) {
						$('form[name='+i+'] input[type=checkbox]:not(:checked)').attr("disabled", "disabled");
					} else {
						$('form[name='+i+'] input[type=checkbox]').removeAttr("disabled");
					}
				});		
				$('form[name='+i+'] input[type=checkbox]').trigger("change");
			});
		}
		
		function completePage() {
			
			if(page == maxPage) { // 마지막 페이지면
				if(!validityCheck()) // 유효성 검사.
					return;
				
				$.each(list_data, function(i, obj) { // 마지막 설문 결과를 올린다.
					var form = $('form[name='+i+']');
					sendAnswer(form);
				});
				
				window.location.href = '/survey/list';
				alert("수고하셨습니다.");
				return;
			}
			
			if(per < 100) { // 마지막 페이지가 아니고 설문을 전부 완료하지 않았으면
				alert("설문을 전부 완료해주세요.");
			} else {				
				if(!validityCheck()) // 유효성 검사.
					return;
				
				$.each(list_data, function(i, obj) {
					var form = $('form[name='+i+']');
					sendAnswer(form);
				});
				
				window.location.href = '/survey/list';
				alert("수고하셨습니다.");
			}
		}
		
		function btnDisabledCheck() {
			if(page <= 1)
				$('#prevBtn').attr('disabled', 'disabled');
			else
				$('#prevBtn').removeAttr('disabled');
				
			if(page >= maxPage)
				$('#nextBtn').attr('disabled', 'disabled');
			else
				$('#nextBtn').removeAttr('disabled');
		}

		$(document).ready(function() {
			if (msg) {
				if (!confirm(msg)) {
					window.location.href = '/survey/list';
					return;
				}
			}
			getList(seq, page);			
			getAnswer(seq, page);
			getProgress(seq);
			checkboxInit();			
			btnDisabledCheck();
			var per = answerCount/questionCount * 100;
			$('.progress-bar').attr('style', 'width:'+ per + '%;');			
			
		});
	</script>
</body>
<div class='container'>
	<div class="progress">
		<div class="progress-bar progress-bar-success progress-bar-striped active" 
		style="width: 0%;">${answerCount}/${questionCount }</div>
	</div>
	<div class='row' id='rowDiv'></div>
	<div>
		<button class='btn btn-default' onclick='prevPage()' id='prevBtn'>이전</button>
		<button class='btn btn-default' onclick='nextPage()' id='nextBtn'>다음</button>
		<button class='btn btn-default' onclick='completePage()' id='completeBtn'>완료</button>
	</div>
</div>
</html>