<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link href="https://fonts.googleapis.com/css?family=Varela+Round"	rel="stylesheet">
<link rel="stylesheet"	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!--
<script src="https://code.jquery.com/jquery-3.3.1.min.js"	type="text/javascript"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css"	href="/resources/css/datetimepickerstyle.css" />
-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/src/js/bootstrap-datetimepicker.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
<link href="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/build/css/bootstrap-datetimepicker.css" rel="stylesheet"/>

<script	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>

<style type="text/css">
body {
	font-family: 'Varela Round', sans-serif;
}

.form-control {
	box-shadow: none;
	font-weight: normal;
	font-size: 13px;
}

.form-control:focus {
	border-color: #33cabb;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
}

.navbar-header.col {
	padding: 0 !important;
}

.navbar {
	background: #fff;
	padding-left: 16px;
	padding-right: 16px;
	border-bottom: 1px solid #dfe3e8;
	border-radius: 0;
}

.nav-link img {
	border-radius: 50%;
	width: 36px;
	height: 36px;
	margin: -8px 0;
	float: left;
	margin-right: 10px;
}

.navbar .navbar-brand, .navbar .navbar-brand:hover, .navbar .navbar-brand:focus
	{
	padding-left: 0;
	font-size: 20px;
	padding-right: 50px;
}

.navbar .navbar-brand b {
	font-weight: bold;
	color: #33cabb;
}

.navbar .form-inline {
	display: inline-block;
}

.navbar .nav li {
	position: relative;
}

.navbar .nav li a {
	color: #888;
}

.search-box {
	position: relative;
}

.search-box input {
	padding-right: 35px;
	border-color: #dfe3e8;
	border-radius: 4px !important;
	box-shadow: none
}

.search-box .input-group-addon {
	min-width: 35px;
	border: none;
	background: transparent;
	position: absolute;
	right: 0;
	z-index: 9;
	padding: 7px;
	height: 100%;
}

.search-box i {
	color: #a0a5b1;
	font-size: 19px;
}

.navbar .nav .btn-primary, .navbar .nav .btn-primary:active {
	color: #fff;
	background: #33cabb;
	padding-top: 8px;
	padding-bottom: 6px;
	vertical-align: middle;
	border: none;
}

.navbar .nav .btn-primary:hover, .navbar .nav .btn-primary:focus {
	color: #fff;
	outline: none;
	background: #31bfb1;
}

.navbar .navbar-right li:first-child a {
	padding-right: 30px;
}

.navbar .nav-item i {
	font-size: 18px;
}

.navbar .dropdown-item i {
	font-size: 16px;
	min-width: 22px;
}

.navbar ul.nav li.active a, .navbar ul.nav li.open>a {
	background: transparent !important;
}

.navbar .nav .get-started-btn {
	min-width: 120px;
	margin-top: 8px;
	margin-bottom: 8px;
}

.navbar ul.nav li.open>a.get-started-btn {
	color: #fff;
	background: #31bfb1 !important;
}

.navbar .dropdown-menu {
	border-radius: 1px;
	border-color: #e5e5e5;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .05);
}

.navbar .nav .dropdown-menu li {
	color: #999;
	font-weight: normal;
}

.navbar .nav .dropdown-menu li a, .navbar .nav .dropdown-menu li a:hover,
	.navbar .nav .dropdown-menu li a:focus {
	padding: 8px 20px;
	line-height: normal;
}

.navbar .navbar-form {
	border: none;
}

.navbar .dropdown-menu.form-wrapper {
	width: 280px;
	padding: 20px;
	left: auto;
	right: 0;
	font-size: 14px;
}

.navbar .dropdown-menu.form-wrapper a {
	color: #33cabb;
	padding: 0 !important;
}

.navbar .dropdown-menu.form-wrapper a:hover {
	text-decoration: underline;
}

.navbar .form-wrapper .hint-text {
	text-align: center;
	margin-bottom: 15px;
	font-size: 13px;
}

.navbar .form-wrapper .social-btn .btn, .navbar .form-wrapper .social-btn .btn:hover
	{
	color: #fff;
	margin: 0;
	padding: 0 !important;
	font-size: 13px;
	border: none;
	transition: all 0.4s;
	text-align: center;
	line-height: 34px;
	width: 47%;
	text-decoration: none;
}

.navbar .social-btn .btn-primary {
	background: #507cc0;
}

.navbar .social-btn .btn-primary:hover {
	background: #4676bd;
}

.navbar .social-btn .btn-info {
	background: #64ccf1;
}

.navbar .social-btn .btn-info:hover {
	background: #4ec7ef;
}

.navbar .social-btn .btn i {
	margin-right: 5px;
	font-size: 16px;
	position: relative;
	top: 2px;
}

.navbar .form-wrapper .form-footer {
	text-align: center;
	padding-top: 10px;
	font-size: 13px;
}

.navbar .form-wrapper .form-footer a:hover {
	text-decoration: underline;
}

.navbar .form-wrapper .checkbox-inline input {
	margin-top: 3px;
}

.or-seperator {
	margin-top: 32px;
	text-align: center;
	border-top: 1px solid #e0e0e0;
}

.or-seperator b {
	color: #666;
	padding: 0 8px;
	width: 30px;
	height: 30px;
	font-size: 13px;
	text-align: center;
	line-height: 26px;
	background: #fff;
	display: inline-block;
	border: 1px solid #e0e0e0;
	border-radius: 50%;
	position: relative;
	top: -15px;
	z-index: 1;
}

.navbar .checkbox-inline {
	font-size: 13px;
}

.navbar .navbar-right .dropdown-toggle::after {
	display: none;
}

@media ( min-width : 1200px) {
	.form-inline .input-group {
		width: 300px;
		margin-left: 30px;
	}
}

@media ( max-width : 768px) {
	.navbar .dropdown-menu.form-wrapper {
		width: 100%;
		padding: 10px 15px;
		background: transparent;
		border: none;
	}
	.navbar .form-inline {
		display: block;
	}
	.navbar .input-group {
		width: 100%;
	}
	.navbar .nav .btn-primary, .navbar .nav .btn-primary:active {
		display: block;
	}
}

/* The side navigation menu */
.sidenav {
  height: 100%; /* 100% Full-height */
  width: 0; /* 0 width - change this with JavaScript */
  position: fixed; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0; /* Stay at the top */
  left: 0;
  background-color: #111; /* Black*/
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
}

/* The navigation menu links */
.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.sidenav a:hover {
  color: #f1f1f1;
}

/* Position and style the close button (top right corner) */
.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

/* Style page content - use this if you want to push the page content to the right when you open the side navigation */
#main {
  transition: margin-left .5s;
  padding: 20px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
<script type="text/javascript">
	// Prevent dropdown menu from closing when click inside the form
	$(document).on("click", ".navbar-right .dropdown-menu", function(e) {
		e.stopPropagation();
	});
</script>
<header>
		<nav class="navbar navbar-default navbar-expand-lg navbar-light">
			<div class="navbar-header d-flex col">
				<a class="navbar-brand" href="#none" onclick="openNav();"><b>게시판</b></a>
				<button type="button" data-target="#navbarCollapse"
					data-toggle="collapse" class="navbar-toggle navbar-toggler ml-auto">
					<span class="navbar-toggler-icon"></span> <span class="icon-bar"></span>
					<span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
			</div>
			<!-- Collection of nav links, forms, and other content for toggling -->
			<div id="navbarCollapse"
				class="collapse navbar-collapse justify-content-start">
				<ul class="nav navbar-nav">
					<li class="nav-item" id='home'><a href="/" class="nav-link">Home</a></li>
					<li class="nav-item" id='board'><a onclick="openNav();" href="#none"
						class="nav-link">게시판</a></li>
					<li class="nav-item" id='chartPage'><a href="/chart/home"
						class="nav-link">차트</a></li>
					<li class="nav-item" id='surveyPage'><a href="/survey/list"
						class="nav-link">설문조사</a></li>
					<c:if test="${loginVO.isAdmin == '1'}">
						<li class="nav-item" id='adminNav'><a href="/admin/home"
						class="nav-link">관리자 페이지</a></li>
					</c:if>
					<li>
						<form class="navbar-form form-inline" action="/board/list">
							<div class="input-group search-box">
								<span class='input-group-btn'> <select name="searchType"
									class='form-control'>
										<option value="n"
											<c:out value="${pvo.searchType == null?'selected':''}"/>>
											---</option>
										<option value="t"
											<c:out value="${pvo.searchType eq 't'?'selected':''}"/>>
											제목</option>
										<option value="c"
											<c:out value="${pvo.searchType eq 'c'?'selected':''}"/>>
											본문</option>
										<option value="w"
											<c:out value="${pvo.searchType eq 'w'?'selected':''}"/>>
											작성자</option>
										<option value="tc"
											<c:out value="${pvo.searchType eq 'tc'?'selected':''}"/>>
											제목+본문</option>
										<option value="cw"
											<c:out value="${pvo.searchType eq 'cw'?'selected':''}"/>>
											본문+작성자</option>
										<option value="tcw"
											<c:out value="${pvo.searchType eq 'tcw'?'selected':''}"/>>
											제목+본문+작성자</option>
								</select>
								</span> <input type="text" value="${pvo.keyword}" name="keyword"
									id="keywordInput" class="form-control"
									placeholder="Search here..."> <span
									class="input-group-addon"><i class="material-icons">&#xE8B6;</i></span>
							</div>
						</form>
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right ml-auto">
					<c:if test="${loginVO == null}">
						<li class="nav-item"><a data-toggle="dropdown"
							class="nav-link dropdown-toggle" href="#">로그인</a>
							<ul class="dropdown-menu form-wrapper">
								<li>
									<form action="/login" method="post">
										<!-- 							<p class="hint-text">Sign in with your social media account</p> -->
										<!-- 							<div class="form-group social-btn clearfix"> -->
										<!-- 								<a href="#" class="btn btn-primary pull-left"><i class="fa fa-facebook"></i> Facebook</a> -->
										<!-- 								<a href="#" class="btn btn-info pull-right"><i class="fa fa-twitter"></i> Twitter</a> -->
										<!-- 							</div> -->
										<!-- 							<div class="or-seperator"><b>or</b></div> -->
										<div class="form-group">
											<input type="text" class="form-control"
												placeholder="Username" required="required" name="userId"
												onkeyup='spaceRemove($(this))'>
										</div>
										<div class="form-group">
											<input type="password" class="form-control"
												placeholder="Password" required="required" name="userPass"
												onkeyup='spaceRemove($(this))'>
										</div>
										<input type="submit" class="btn btn-primary btn-block"
											value="Login">
										<div class="form-footer">
											<a href="#">Forgot Your password?</a>
										</div>
									</form>
								</li>
							</ul></li>
						<li class="nav-item" id='join'><a href="/MemberJoin"
							class="nav-link">회원가입</a></li>
					</c:if>
					<c:if test="${loginVO.isAdmin == '1'}">
						<li class="nav-item" id='adminPage'><a href="/adminPage"
							class="nav-link">게시물 관리</a></li>
					</c:if>
					<c:if test="${loginVO != null}">
						<li class="nav-item"><a href="/logout" class="nav-link">로그아웃</a>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</header>
	<script>
		window.name = '게시판';
		var url = window.location.href;
		var index = url.indexOf("?");
		var activeTab = url.substr(window.location.origin.length);
		if (index > 0)
			activeTab = url.substring(url.lastIndexOf("/"), url.indexOf("?"));

		// 		console.log(url);
		// 		console.log(activeTab);

		if (activeTab == '/home' || activeTab == '/')
			$("#home").addClass("active");
		else if (activeTab == '/MemberJoin')
			$("#join").addClass("active");
		else if (activeTab == '/adminPage')
			$("#adminPage").addClass("active");
		else if (activeTab.substring(0, 6) == '/chart')
			$("#chartPage").addClass("active");
		else if (activeTab.substring(0, 7) == '/survey')
			$("#surveyPage").addClass("active");
		else if (activeTab.substring(0, 6) == '/admin')
			$('#adminNav').addClass("active");
		else
			$("#board").addClass("active");

		function spaceRemove(obj) {
			var a = obj.val().replace(/ /gi, '');
			obj.val(a);
		}

		Date.prototype.format = function(f) {

			if (!this.valueOf())
				return " ";

			var weekKorName = [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ];

			var weekKorShortName = [ "일", "월", "화", "수", "목", "금", "토" ];

			var weekEngName = [ "Sunday", "Monday", "Tuesday", "Wednesday",
					"Thursday", "Friday", "Saturday" ];

			var weekEngShortName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri",
					"Sat" ];

			var d = this;

			return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi,
					function($1) {

						switch ($1) {

						case "yyyy":
							return d.getFullYear(); // 년 (4자리)

						case "yy":
							return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

						case "MM":
							return (d.getMonth() + 1).zf(2); // 월 (2자리)

						case "dd":
							return d.getDate().zf(2); // 일 (2자리)

						case "KS":
							return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

						case "KL":
							return weekKorName[d.getDay()]; // 요일 (긴 한글)

						case "ES":
							return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

						case "EL":
							return weekEngName[d.getDay()]; // 요일 (긴 영어)

						case "HH":
							return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

						case "hh":
							return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

						case "mm":
							return d.getMinutes().zf(2); // 분 (2자리)

						case "ss":
							return d.getSeconds().zf(2); // 초 (2자리)

						case "a/p":
							return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

						default:
							return $1;

						}

					});

		};

		String.prototype.string = function(len) {
			var s = '', i = 0;
			while (i++ < len) {
				s += this;
			}
			return s;
		};

		String.prototype.zf = function(len) {
			return "0".string(len - this.length) + this;
		};

		Number.prototype.zf = function(len) {
			return this.toString().zf(len);
		};
	</script>
	
<div id="mySidenav" class="sidenav">
	<a href="/board/list"	class="nav-link">게시판 홈</a>
	<c:import url="/board/sidenavList"></c:import>
</div>

<script>
/* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
function openNav() {
  document.getElementById("mySidenav").style.width = "500px";
//   document.getElementById("main").style.marginLeft = "250px";
  $("body").attr("style", "margin-left:500px;");
//   document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
//   document.getElementById("main").style.marginLeft = "0";
  $("body").attr("style", "margin-left:0px;");
//   document.body.style.backgroundColor = "white";
}

function sidenavList(page) {
	$("#page").val(page);
	var pageData = $("#sidenavSearchForm").serialize();
	
	$("#mySidenav").html('<a href="/board/list"	class="nav-link">게시판 홈</a>');
	$.ajax({
		type : 'POST',
		url : "/board/sidenavList",
		dataType : "html",
		data : pageData,
		async : false,
		success : function(data) {
			$("#mySidenav").append(data);
		}
	});
}
</script>