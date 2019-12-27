<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/15.0.0/classic/ckeditor.js"></script>
<script>
var loginName = '${loginVO.userName}';

function fn_disply(rno) {
	<c:if test="${boardVO.isComment == 'N'.charAt(0)}">
	alert("덧글 사용이 불가능 상태입니다.");
	return;
	</c:if>
	
	var con = document.getElementById("reDiv"+rno);
    if(con.style.display=='none'){
        con.style.display = 'block';
    }else{
        con.style.display = 'none';
    }
}

function fn_modComment(rno) {
	<c:if test="${boardVO.isComment == 'N'.charAt(0)}">
	alert("덧글 사용이 불가능 상태입니다.");
	return;
	</c:if>
	var writer = $('#mod'+rno).attr('data-writer');
	
	<c:if test="${loginVO.isAdmin != '1'}">	
	if(writer != loginName) {
		alert("작성자 본인만 수정 가능합니다.");
		return;
	}
	</c:if>
	var isDelete = $('#mod'+rno).attr('data-isdelete');
	if(isDelete == 1) {
		alert("삭제 된 덧글에는 수정이 불가능합니다.");
		return;
	}
	
	var content = prompt("덧글 내용을 입력하세요.", "");
	
	if(!content)
		return;	
	
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/modComment.do'/>",
        data : "rno="+ rno + "&content=" + content,
        success : function(data){
            if(data=="success")
            {
                getCommentList();
            }
        }        
    });
}

function fn_delComment(rno) {
	<c:if test="${boardVO.isComment == 'N'.charAt(0)}">
	alert("덧글 사용이 불가능 상태입니다.");
	return;
	</c:if>
	var writer = $('#del'+rno).attr('data-writer');
	
	<c:if test="${loginVO.isAdmin != '1'}">	
	if(writer != loginName) {
		alert("작성자 본인만 삭제 가능합니다.");
		return;
	}
	</c:if>
	
	var isDelete = $('#del'+rno).attr('data-isdelete');
	if(isDelete == 1) {
		alert("이미 삭제 된 덧글입니다.");
		return;
	}
	
	if(!confirm("정말 삭제하시겠습니까?"))
		return;
	
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/delComment.do'/>",
        data : "rno="+ rno,
        success : function(data){
            if(data=="success")
            {
                getCommentList();
            }
        }        
    });
}

function fn_reComment(rno){
	<c:if test="${boardVO.isComment == 'N'.charAt(0)}">
	alert("덧글 사용이 불가능 상태입니다.");
	return;
	</c:if>
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/addReComment.do'/>",
        data:$("#reCommentForm" + rno).serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("textarea[id='content']").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
        
    });
}

/*
 * 댓글 등록하기(Ajax)
 */
function fn_comment(code){
	<c:if test="${boardVO.isComment == 'N'.charAt(0)}">
	alert("덧글 사용이 불가능 상태입니다.");
	return;
	</c:if>
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/addComment.do'/>",
        data:$("#commentForm").serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("textarea[id='content']").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
        
    });
}

/**
 * 댓글 불러오기(Ajax)
 */
function getCommentList(){
    
    $.ajax({
        type:'GET',
        url : "<c:url value='/board/commentList.do'/>",
        dataType : "json",
        data:$("#commentForm").serialize(),
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data){
            
            var html = "";
            var cCnt = data.length;
            var margin = 0;
            var icon = "";
//	            console.log(data);
            
            if(data.length > 0){
                
                for(i=0; i<data.length; i++){
                	margin = 0;
                	icon = "";
                	for(j=0; j<data[i].re_depth; j++) {
                		margin += 20;
                		icon = "<img src='/resources/img/icon_re.gif' align='absmiddle' alt='' />";
                	}
                	html += "<div style='margin-left: "+margin+"px'>";
                	html += "<li>";
                	html += "<p>";
                	html += icon;
                	html += "<span class='glyphicon glyphicon-user'></span>";
                	html += data[i].writer + " (" + data[i].regDate + ")" + "좋아요 : " + data[i].good_score + " 싫어요 : " + data[i].bad_score;
                	html += "</p>";
                	if(data[i].isDelete == 1)
                		html += "<p class='bg-info'><d>(삭제 된 댓글입니다.)</d></p>";
                	else
                		html += "<p class='bg-info'>"+ data[i].content + "</p>";             
                	html += "<div class='form-group'>";
                	html += "<label> <input type='radio' name='likeType"+data[i].rno+"' value='G' data-isDelete='"+data[i].isDelete+"' data-rno='"+data[i].rno+"' id='likeType'";
                	if(data[i].likeType == 'G')
                		html += " checked='checked' data-isUpdate='Y'";
                	else
                		html += "data-isUpdate='N'";
                	html += "/>좋아요</label>";                	
                	html += "<label> <input type='radio' name='likeType"+data[i].rno+"' value='B' data-isDelete='"+data[i].isDelete+"' data-rno='"+data[i].rno+"' id='likeType'";
                	if(data[i].likeType == 'B')
                		html += " checked='checked' data-isUpdate='Y'";
                	else
                		html += "data-isUpdate='N'";
                	html += "/>싫어요</label>";
                	// html += "<button type='button' class='btn btn-default btn-xs' data-isDelete='"+data[i].isDelete+"' data-rno='"+data[i].rno+"' id='goodBtn'>좋아요</button>";
                	// html += "<button type='button' class='btn btn-default btn-xs' data-isDelete='"+data[i].isDelete+"' data-rno='"+data[i].rno+"' id='badBtn'>싫어요</button>";
                	html += "<button type='button' class='replyUpdate btn btn-warning btn-xs' data-isDelete='"+data[i].isDelete+"' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='mod"+data[i].rno+"' onClick='fn_modComment("+data[i].rno+")'>수정</button>";
                	html += "<button type='button' class='replyDelete btn btn-danger btn-xs data-isDelete='"+data[i].isDelete+"'' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='del"+data[i].rno+"' onClick='fn_delComment("+data[i].rno+")'>삭제</button>";
                	html += "<button type='button' class='repWrite btn btn-info btn-xs' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='rep"+data[i].rno+"' onClick='fn_disply("+data[i].rno+")'>답글</button>";
         			html += "<div id='reDiv"+ data[i].rno +"'' style='display: none;'>";
         			html += "<form id='reCommentForm"+ data[i].rno +"' method='post'>";
         			html += '<input type="hidden" id="bno" name="bno" value="${articleVO.bno}" readonly="readonly" />';
         			html += '<input type="hidden" id="parent" name="parent" value="'+data[i].rno+'" readonly="readonly" />';
         			html += '<input type="hidden" id="orno" name="orno" value="'+data[i].rno+'" readonly="readonly" />';
         			html += "<div class='form-group'>";
         			html += "<label for='writer' class='col-sm-2 control-label'>작성자</label>";
         			html += "<div class='col-sm-10'>";
         			html += '<input type="text" id="writer" name="writer" class="form-control" value="${loginVO.userName}" readonly/>';
         			html += "</div>";
         			html += "</div>";
         			html += '<div class="form-group">';
         			html += '<label for="content" class="col-sm-2 control-label">댓글 내용</label>';
         			html += '<div class="col-sm-10">';
         			html += '<textarea id="content" name="content" class="form-control" ></textarea>';
         			html += '</div></div>';
         			html += '<div class="form-group"> <div class="col-sm-offset-2 col-sm-10">';
         			html += '<button type="button" class="repSubmit btn btn-success" onClick="fn_reComment('+data[i].rno+')">작성</button>';
         			html += '</div></div>';
         			html += "</form>";
         			html += "</div>";
                	html += "</div>";
                	html += "</li>";
                    html += "</div>";
                }
                
            } else {
            	
            	html += "<li>";
            	html += "<p>";
            	html += "<h6><b>등록된 댓글이 없습니다.</b></h6>";
            	html += "</p>";
            	html += "</li>"
                
            }
            
//	            $("#cCnt").html(cCnt);
            $("#replyList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}


	$(document).ready(function(){
		
		var formObj = $("#boardForm");
		
		console.log(formObj);
		console.log(opener.window.name);
		
		$("#reWrite").on("click", function(){
			formObj.attr("action", "/board/${boardVO.boardType }/${boardVO.url }/reRegister");
			formObj.submit();
		});		
		$("#modify").on("click", function(){			
			var form = formObj;
			var isSecret = form.children("#isSecret").val();
			if(isSecret == 'Y') {
				var pw = prompt("비밀번호를 입력하세요");
				form.children("#pw").val(pw);
				
				formObj.attr("action", "/board/${boardVO.boardType }/${boardVO.url }/modifyPage");
				formObj.submit();
				return;
			}
			
			formObj.attr("action", "/board/${boardVO.boardType }/${boardVO.url }/modifyPage");
			if('${loginVO.isAdmin}' == '1' || '${articleVO.writer}' == '${loginVO.userName}')
				formObj.submit();
			else
				alert('작성자 본인만 수정이 가능합니다.');
		});
		
		$("#remove").on("click", function(){
			var form = formObj;
			var isSecret = form.children("#isSecret").val();
			if(isSecret == 'Y') {
				var pw = prompt("비밀번호를 입력하세요");
				form.children("#pw").val(pw);
				formObj.attr("action", "/board/${boardVO.boardType }/${boardVO.url }/removeAction");
				if(confirm("정말 삭제하시겠습니까?")){
					formObj.attr("target", opener.window.name);
					formObj.submit();
					self.opener = self;
					window.close();
					return;
				}
			}
			
			formObj.attr("action", "/board/${boardVO.boardType }/${boardVO.url }/removeAction");			
			
			if('${loginVO.isAdmin}' == '1' || '${articleVO.writer}' == '${loginVO.userName}'){
				if(confirm("정말 삭제하시겠습니까?")){
					formObj.attr("target", opener.window.name);
					formObj.submit();
					self.opener = self;
					window.close();
				}
			}				
			else
				alert('작성자 본인만 삭제가 가능합니다.');
		});
		
		$("#list").on("click", function(){
			self.opener = self;
			window.close();
// 			formObj.attr("action", "/list");
// 			formObj.submit();
		});
		
		$("#order_new").on("click", function() {
			$("#orderType").val("new");
			getCommentList();
		});
		
		$("#order_old").on("click", function() {
			$("#orderType").val("old");
			getCommentList();
		});
		
		$("#order_score").on("click", function() {
			$("#orderType").val("score");
			getCommentList();
		});
		
		 
		/**
		 * 초기 페이지 로딩시 댓글 불러오기
		 */
		 
		 getCommentList();
		 opener.window.parent.location.href="./list?" + $('#searchForm').serialize();
		
	});
	
	$(document).on('change', "#likeType", function(){
		var rno = $(this).attr('data-rno');
		
		var isDelete = $(this).attr('data-isdelete');
		if(isDelete == 1) {
			alert("삭제 된 덧글에는 평가가 불가능합니다.");
			return;
		}	
		
		var likeType = $('input:radio[name="likeType'+rno+'"]:checked').val();
		var isUpdate = $(this).attr('data-isupdate');
		var data = $('#commentForm').serialize()  + "&rno=" + rno + "&likeType=" + likeType + "&isUpdate=" + isUpdate;
		
		console.log(data);
		
		$.ajax({
	        type:'POST',
	        url : "/board/commentLike.do",
	        data: data,
	        success : function(data){
	        	//if(data == 'fail')
	        	//	alert("이미 평가를 했습니다.");
	        	console.log(data);
	        	getCommentList();
	        }
		});
		
	});
	
	$(document).on('click', '#goodBtn', function() {
		var rno = $(this).attr('data-rno');
		
		var isDelete = $(this).attr('data-isdelete');
		if(isDelete == 1) {
			alert("삭제 된 덧글에는 평가가 불가능합니다.");
			return;
		}
		
		$.ajax({
	        type:'POST',
	        url : "/board/commentGood.do",
	        data: "rno=" + rno,
	        success : function(data){
	        	if(data == 'fail')
	        		alert("이미 평가를 했습니다.");
	        	
	        	getCommentList();
	        }
		});
		
	});
	
	$(document).on('click', '#badBtn', function() {
		var rno = $(this).attr('data-rno');
		
		var isDelete = $(this).attr('data-isdelete');
		if(isDelete == 1) {
			alert("삭제 된 덧글에는 평가가 불가능합니다.");
			return;
		}
		
		$.ajax({
	        type:'POST',
	        url : "/board/commentBad.do",
	        data: "rno=" + rno,
	        success : function(data){
	        	if(data == 'fail')
	        		alert("이미 평가를 했습니다.");
	        	
	        	getCommentList();
	        }
		});
	});
	
</script>
</head>
<body>
<form method="post" id="searchForm">
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
		<input type="hidden" name="showType" value="${showType }">
</form>
	<form role="form" method="post" action="modifyPage" id='boardForm'>
		<input type='hidden' name='isSecret' id='isSecret' value="<c:out value='${articleVO.isSecret}'/>">
		<input type='hidden' name='pw' id='pw'>
		<input type="hidden" name="boardId" value='${articleVO.boardId}'>
		<input type="hidden" name="url" value='${boardVO.url}'>
		<input type="hidden" name="bno" value='${articleVO.bno}'>
		<input type="hidden" name="title" value='${articleVO.title}'>
		<input type="hidden" name="content" value='${articleVO.content}'>
		<input type="hidden" name="writer" value="${articleVO.writer}">
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
	</form>
	
	<div class="container" style="margin-top:50px;">
			<div class="form-group">
				<label for="exampleInputEmail1">제목 : </label>
				${articleVO.title }
			</div>
			<div class="form-group">
				<hr>
				${articleVO.content}
				<hr>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자 : </label>
				${articleVO.writer}
			</div>
		
		
		<div>
			<button type="submit" class="btn btn-default" id='modify'>수정</button>
			<button type="submit" class="btn btn-default" id='remove'>삭제</button>	
			<c:if test="${articleVO.isNotice == 'N'.charAt(0) && boardVO.isRpy == 'Y'.charAt(0)}">
			<button type="submit" class="btn btn-default" id='reWrite'>답글</button>
			</c:if>
			<button type="button" class="btn btn-default" id='list'>닫기</button>
		</div>
		<hr>
		<div id="reply">
			<div class="text-right">
				<button type='button' class='btn btn-default' id='order_new'>과거순</button>
				<button type='button' class='btn btn-default' id='order_old'>최신순</button>
				<button type='button' class='btn btn-default' id='order_score'>평점순</button>
			</div>
			<ul class="replyList" id='replyList'>
			</ul>
		<hr>
		<section class="replyForm" id='replyMainForm'>
		<form role="form" method="post" autocomplete="off" class="form-horizontal" id='commentForm'>
			<input type="hidden" id='userId' name="userId" value='${loginVO.userId}'>
			<input type="hidden" id='orderType' name="orderType" value='new'>
			<input type="hidden" name="parent" value='0'>
			<input type="hidden" name="boardId" value='${articleVO.boardId}'>
			<input type="hidden" name="url" value='${boardVO.url}'>
			<input type="hidden" id="bno" name="bno" value="${articleVO.bno}" readonly="readonly" />
			<input type="hidden" id="page" name="page" value="${pvo.page}" readonly="readonly" />
			<input type="hidden" id="perPageNum" name="perPageNum" value="${pvo.perPageNum}" readonly="readonly" />
			<input type="hidden" id="searchType" name="searchType" value="${pvo.searchType}" readonly="readonly" />
			<input type="hidden" id="keyword" name="keyword" value="${pvo.keyword}" readonly="readonly" />
		
			<div class="form-group">
				<label for="writer" class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" id="writer" name="writer" class="form-control" value='${loginVO.userName}' readonly/>
				</div>
			</div>			
			
			<div class="form-group">
				<label for="content" class="col-sm-2 control-label">댓글 내용</label>
				<div class="col-sm-10">
					<textarea id="content" name="content" class="form-control" ></textarea>
				</div>
			</div>
			
			<div class="form-group">
				 <div class="col-sm-offset-2 col-sm-10"> 
					<button type="button" class="repSubmit btn btn-success" onClick="fn_comment()">작성</button> 
				</div>								
			</div>
		</form>		
		</section>
			
		</div>
		
		</div>
</body>
</html>