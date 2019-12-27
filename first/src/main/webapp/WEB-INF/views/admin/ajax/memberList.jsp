<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form id="ajaxform" action="/admin//member/excelUpload.ajax" method="post" enctype="multipart/form-data"> 
<input type="file" name="excel" />
<button type='submit' class='btn btn-info' id='memberUpBtn'>회원 엑셀 업로드</button>
</form>


<!-- <button type='button' class='btn btn-default' id='memberDownBtn'>샘플 엑셀 다운로드</button> -->
<a class='btn btn-default' href='/admin/member/sample.xls' type="mime/type" download>샘플 엑셀 다운로드</a>
<table class='table table-bordered table-hover'>
	<colgroup>
		<col width="20%">
		<col>
		<col width="15%">
		<col width="15%">
	</colgroup>
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>관리자 / 사용자</th>
			<th>사 용 / 미사용</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="memberVO" varStatus="status">
		<tr>
			<td>${memberVO.userId}</td>
			<td>${memberVO.userName}</td>
			<td>
			<c:if test="${memberVO.isAdmin == '1'}">관리자</c:if>
			<c:if test="${memberVO.isAdmin == '0'}">사용자</c:if>
			</td>
			<td>
			<c:if test="${memberVO.isUsing == 'Y'.charAt(0)}">사 용</c:if>
			<c:if test="${memberVO.isUsing == 'N'.charAt(0)}">미사용</c:if>						
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<div id='memberModal' class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">회원 상세 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="details">
				</div>
				<hr>
				<div class="modify text-center">
				<form id='memberForm'>
					<label>권한 변경
						<select name='isAdmin'>
							<option value='0'>사용자</option>
							<option value='1'>관리자</option>
						</select>
					</label>
					<label>사용 / 미사용 변경
						<select name='isUsing'>
							<option value='Y'>사용</option>
							<option value='N'>미사용</option>
						</select>
					</label>
				</form>					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id='saveBtn'>변경</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script>

	$('#ajaxform').ajaxForm({
	   //보내기전 validation check가 필요할경우
         beforeSubmit: function (data, frm, opt) {
        	 				var file_type = data[0].value.type;
        	 				if(file_type != 'application/vnd.ms-excel') {
        	 					alert('xls파일을 선택해주세요.');
        	 					return false;
        	 				}
        	 				
			                return true;
			              },
         //submit이후의 처리
         success: function(responseText, statusText){
        	if(responseText == 'finish')
         		alert("회원 업로드 성공!!");
        	else
        		alert(responseText);
        	
        	adminMember();
         },
         //ajax error
         error: function(){
         	alert("에러발생!!");
         	adminMember();
         }                               
       });
	
	function makeFrame(url,target) { 

	    ifrm = document.createElement( "IFRAME" ); 

	    ifrm.setAttribute( "style", "display:none;" ) ;

	    ifrm.setAttribute( "src", url ) ; 

	    ifrm.setAttribute( "name", target) ; 

	    ifrm.style.width = 0+"px"; 

	    ifrm.style.height = 0+"px"; 

	    document.body.appendChild( ifrm ) ; 

	} 
	
	function removeiframe() {

		var iframes = document.getElementsByTagName('iframe');

		for (var i = 0; i < iframes.length; i++) {

		    iframes[i].parentNode.removeChild(iframes[i]);

		}

	}
	
	$('#memberDownBtn').off().on('click', function(){
		//window.location="/admin/member/sample.xls";
		//var _window = window.open("/admin/member/sample.xls","_blank");
		//_window.document.close();
		//_window.document.execCommand('SaveAs', true, "sample.xls" || "/admin/member/sample.xls")
		//_window.close();
		var fileURL = "/admin/member/sample.xls";
		var fileName = "sample.xls";
		
		makeFrame(fileURL,fileName);
  		var _window = window.open(fileURL, fileName);
        _window.document.close();
        _window.document.execCommand('SaveAs', true, fileName || fileURL)
        _window.close();
        removeiframe();
	});

	$('table tbody tr').click(function() {
		var str = '';
		var tr = $(this);
		var td = tr.children();
		
		td.each(function(i) {
// 			console.log(tr);
			str += $('th').eq(i).text() + " : " + td.eq(i).text() + "<br>";
		});
		
		$('#adminSelect ')
		
		$('#saveBtn').on('click', function() {
			$.ajax({
				type : 'POST',
				url : "/admin/member/change.ajax",
				data : "userId=" + td.eq(0).text() + "&" + $('#memberForm').serialize(),
				async: false,
				dataType : "text",
				success : function(data) {
					hideModal();
					adminMember();
				}
			});
		});		
		
		$('.modal .modal-body .details').html(str);
		$('.modal').modal('show');
	});
</script>