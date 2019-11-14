<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
</head>
<script>

function nameCheck() {

	var user_name = $('#userName').val();
	var data = "userName=" + user_name;
	 $.ajax({
		    url:'/nameCheck', // 요청 할 주소
		    type:'POST', // GET, PUT
		    data:data,// 전송할 데이터
		    dataType:'text',// xml, json, script, html
		    success:function(data) {
		    	console.log(data + "성공");
		    	if(data == 1) {
		    		$("#name_check").text("사용중인 이름입니다 :p");
					$("#name_check").css("color", "red");
					$("#joinSubmit").attr("disabled", true);
		    	} else if(!user_name) {
		    		$("#name_check").text("이름을 입력해주세요 :D");
					$("#name_check").css("color", "red");
					$("#joinSubmit").attr("disabled", true);
		    	} else if(data == 0) {
		    		$("#name_check").text("사용 가능한 이름입니다 :)");
					$("#name_check").css("color", "green");
					$("#joinSubmit").attr("disabled", false);
		    	}
		    },// 요청 완료 시
		    error:function(data) {console.log(data + "실패");},// 요청 실패.
		    complete:function(data) {console.log(data + "완료");}// 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	
}

function idCheck() {

	var user_Id = $('#userId').val();
	var data = "userId=" + user_Id;
	 $.ajax({
		    url:'/idCheck', // 요청 할 주소
		    type:'POST', // GET, PUT
		    data:data,// 전송할 데이터
		    dataType:'text',// xml, json, script, html
		    success:function(data) {
		    	console.log(data + "성공");
		    	if(data == 1) {
		    		$("#id_check").text("사용중인 아이디입니다 :p");
					$("#id_check").css("color", "red");
					$("#joinSubmit").attr("disabled", true);
		    	} else if(!user_Id) {
		    		$("#id_check").text("아이디를 입력해주세요 :D");
					$("#id_check").css("color", "red");
					$("#joinSubmit").attr("disabled", true);
		    	} else if(data == 0) {
		    		$("#id_check").text("사용 가능한 아이디입니다 :)");
					$("#id_check").css("color", "green");
					$("#joinSubmit").attr("disabled", false);
		    	}
		    },// 요청 완료 시
		    error:function(data) {console.log(data + "실패");},// 요청 실패.
		    complete:function(data) {console.log(data + "완료");}// 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	
}
$(document).ready(function(){
	$("#userId").on('blur',function() {
		 idCheck();
	});
	
	$("#userName").on('blur',function() {
		 nameCheck();
	});
});

 </script>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 text-center">
				<div class="col-sm-3"></div>

				<div class="col-sm-6">
					<h2>회원가입</h2>
					<form action="/MemberJoin" method="post" id='joinForm'>
						<table class="table table-boardered">
							<tr>
								<th>아이디</th>
								<td>
								<div class='input-group'>						
								<input type="text" class="form-control" id='userId' onkeyup='spaceRemove($(this))'
									name="userId" placeholder="아이디를 넣으세요" required="required">
									<span class='input-group-btn'>
									<button class='btn btn-primary' type='button' onclick="idCheck()">아이디 확인</button>
									</span>
								</div>
									<label for='userId' id='id_check'></label>								
								</td>
							</tr>
							<tr>
								<th>패스워드</th>
								<td><input type="password" class="form-control" onkeyup='spaceRemove($(this))'
									name="userPass" placeholder="비밀번호를 넣어주세요" required="required"></td>
							</tr>

							<tr>
								<th>패스워드확인</th>
								<td><input type="password" class="form-control" onkeyup='spaceRemove($(this))'
									name="pass2" required="required"></td>
							</tr>

							<tr>
								<th>이름</th>
								<td>
								<div class='input-group'>						
								<input type="text" class="form-control" id='userName' onkeyup='spaceRemove($(this))'
									name="userName" placeholder="이름을 넣으세요" required="required">
									<span class='input-group-btn'>
									<button class='btn btn-primary' type='button' onclick="nameCheck()">이름 확인</button>
									</span>
								</div>
									<label for='userName' id='name_check'></label>
								</td>
							</tr>

							<tr>
								<td colspan="2">
								<input type="submit" id='joinSubmit'class="btn btn-primary" value="전송" disabled> 
								<input type="reset"	class="btn btn-danger" value="리셋"></td>
							</tr>


						</table>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>