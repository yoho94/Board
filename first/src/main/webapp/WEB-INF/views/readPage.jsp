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
function fn_disply(rno) {
	var con = document.getElementById("reDiv"+rno);
    if(con.style.display=='none'){
        con.style.display = 'block';
    }else{
        con.style.display = 'none';
    }
}

function fn_reComment(rno){
    
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
                	html += data[i].writer + " (" + data[i].regDate + ")";
                	html += "</p>";
                	html += "<p class='bg-info'>"+ data[i].content + "</p>";
                	html += "<div class='form-group'>";
                	html += "<button type='button' class='replyUpdate btn btn-warning btn-xs' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='mod"+data[i].rno+"'>수정</button>";
                	html += "<button type='button' class='replyDelete btn btn-danger btn-xs' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='del"+data[i].rno+"'>삭제</button>";
                	html += "<button type='button' class='repWrite btn btn-info btn-xs' data-rno='"+data[i].rno+"' data-writer='"+data[i].writer+"' id='rep"+data[i].rno+"' onClick='fn_disply("+data[i].rno+")'>답글</button>";
         			html += "<div id='reDiv"+ data[i].rno +"'' style='display: none;'>";
         			html += "<form id='reCommentForm"+ data[i].rno +"' method='post'>";
         			html += '<input type="hidden" id="bno" name="bno" value="${boardVO.bno}" readonly="readonly" />';
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
			formObj.attr("action", "/reRegister");
			formObj.submit();
		});		
		$("#modify").on("click", function(){
			formObj.attr("action", "/modifyPage");
			if('${loginVO.isAdmin}' == '1' || '${boardVO.writer}' == '${loginVO.userName}')
				formObj.submit();
			else
				alert('작성자 본인만 수정이 가능합니다.');
		});
		
		$("#remove").on("click", function(){
			formObj.attr("action", "/removeAction");
			if('${loginVO.isAdmin}' == '1' || '${boardVO.writer}' == '${loginVO.userName}'){
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
		
		
		 
		/**
		 * 초기 페이지 로딩시 댓글 불러오기
		 */		    
		 getCommentList();
		 
		
	});
	
</script>
</head>
<body>
	<form role="form" method="post" action="modifyPage" id='boardForm'>
		<input type="hidden" name="bno" value='${boardVO.bno}'>
		<input type="hidden" name="title" value='${boardVO.title}'>
		<input type="hidden" name="content" value='${boardVO.content}'>
		<input type="hidden" name="writer" value="${boardVO.writer}">
		<input type="hidden" name="page" value="${pvo.page}">
		<input type="hidden" name="perPageNum" value="${pvo.perPageNum}">
		<input type="hidden" name="searchType" value="${pvo.searchType}">
		<input type="hidden" name="keyword" value="${pvo.keyword}">
	</form>
	
	<div class="container" style="margin-top:50px;">
			<div class="form-group">
				<label for="exampleInputEmail1">제목 : </label>
				${boardVO.title }
			</div>
			<div class="form-group">
				<hr>
				${boardVO.content}
				<hr>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자 : </label>
				${boardVO.writer}
			</div>
		
		
		<div>
			<button type="submit" class="btn btn-default" id='modify'>수정</button>
			<button type="submit" class="btn btn-default" id='remove'>삭제</button>	
			<c:if test="${boardVO.isNotice == 0 }">
			<button type="submit" class="btn btn-default" id='reWrite'>답글</button>
			</c:if>
			<button type="button" class="btn btn-default" id='list'>닫기</button>
		</div>
		
					<div id="reply">
				<ol class="replyList" id='replyList'>
				</ol>
			<hr>
		<section class="replyForm" id='replyMainForm'>
		<form role="form" method="post" autocomplete="off" class="form-horizontal" id='commentForm'>
		
			<input type="hidden" id="bno" name="bno" value="${boardVO.bno}" readonly="readonly" />
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