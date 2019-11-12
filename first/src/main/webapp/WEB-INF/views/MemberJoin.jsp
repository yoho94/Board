<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>  
  <title>회원가입</title>
  
 </head>    
 <body>
 	<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
 
     <div class="container">
    <div class="row">
    <div class="col-sm-12 text-center" >
    <div class="col-sm-3"></div>
     
    <div class="col-sm-6">
    <h2>회원가입</h2>
    <form action="/MemberJoin" method="post">
        <table class="table table-boardered">
            <tr>
                <th>아이디</th>
                <td><input type="text" class="form-control" name="userId" placeholder="아이디를 넣으세요" required="required"></td>        
            </tr>
            <tr>
                <th>패스워드</th>
                <td><input type="password" class="form-control" name="userPass" placeholder="비밀번호를 넣어주세요" required="required"></td>      
            </tr>
             
            <tr>
                <th>패스워드확인</th>
                <td><input type="password" class="form-control" name="pass2" required="required"></td>        
            </tr>
            
            <tr>
            	<th>이름</th>
            	<td><input type='text' class='form-control' name='userName' required="required"></td>
            </tr>
             
            <tr>
                <td colspan="2">
                <input type="submit" class="btn btn-primary" value="전송">
                <input type="reset" class="btn btn-danger" value="취소">
                </td>
            </tr>
             
             
        </table>
    </form>
    </div>
     
    </div>
    </div>
</div>
</body>
</html>