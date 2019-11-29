<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link href="https://fonts.googleapis.com/css?family=Varela+Round"	rel="stylesheet">
<link rel="stylesheet"	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/src/js/bootstrap-datetimepicker.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
<link href="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/build/css/bootstrap-datetimepicker.css" rel="stylesheet"/>

<script	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>

<style type="text/css">
/* === card component ====== 
 * Variation of the panel component
 * version 2018.10.30
 * https://codepen.io/jstneg/pen/EVKYZj
 */
.card {
	background-color: #fff;
	border: 1px solid transparent;
	border-radius: 6px;
}

.card>.card-link {
	color: #333;
}

.card>.card-link:hover {
	text-decoration: none;
}

.card>.card-link .card-img img {
	border-radius: 6px 6px 0 0;
}

.card .card-img {
	position: relative;
	padding: 0;
	display: table;
}

.card .card-img .card-caption {
	position: absolute;
	right: 0;
	bottom: 16px;
	left: 0;
}

.card .card-body {
	display: table;
	width: 100%;
	padding: 12px;
}

.card .card-header {
	border-radius: 6px 6px 0 0;
	padding: 8px;
}

.card .card-footer {
	border-radius: 0 0 6px 6px;
	padding: 8px;
}

.card .card-left {
	position: relative;
	float: left;
	padding: 0 0 8px 0;
}

.card .card-right {
	position: relative;
	float: left;
	padding: 8px 0 0 0;
}

.card .card-body h1:first-child, .card .card-body h2:first-child, .card .card-body h3:first-child,
	.card .card-body h4:first-child, .card .card-body .h1, .card .card-body .h2,
	.card .card-body .h3, .card .card-body .h4 {
	margin-top: 0;
}

.card .card-body .heading {
	display: block;
}

.card .card-body .heading:last-child {
	margin-bottom: 0;
}

.card .card-body .lead {
	text-align: center;
}

@media ( min-width : 768px ) {
	.card .card-left {
		float: left;
		padding: 0 8px 0 0;
	}
	.card .card-right {
		float: left;
		padding: 0 0 0 8px;
	}
	.card .card-4-8 .card-left {
		width: 33.33333333%;
	}
	.card .card-4-8 .card-right {
		width: 66.66666667%;
	}
	.card .card-5-7 .card-left {
		width: 41.66666667%;
	}
	.card .card-5-7 .card-right {
		width: 58.33333333%;
	}
	.card .card-6-6 .card-left {
		width: 50%;
	}
	.card .card-6-6 .card-right {
		width: 50%;
	}
	.card .card-7-5 .card-left {
		width: 58.33333333%;
	}
	.card .card-7-5 .card-right {
		width: 41.66666667%;
	}
	.card .card-8-4 .card-left {
		width: 66.66666667%;
	}
	.card .card-8-4 .card-right {
		width: 33.33333333%;
	}
}

/* -- default theme ------ */
.card-default {
	border-color: #ddd;
	background-color: #fff;
	margin-bottom: 24px;
}

.card-default>.card-header, .card-default>.card-footer {
	color: #333;
	background-color: #ddd;
}

.card-default>.card-header {
	border-bottom: 1px solid #ddd;
	padding: 8px;
}

.card-default>.card-footer {
	border-top: 1px solid #ddd;
	padding: 8px;
}

.card-default>.card-body {
	
}

.card-default>.card-img:first-child img {
	border-radius: 6px 6px 0 0;
}

.card-default>.card-left {
	padding-right: 4px;
}

.card-default>.card-right {
	padding-left: 4px;
}

.card-default p:last-child {
	margin-bottom: 0;
}

.card-default .card-caption {
	color: #fff;
	text-align: center;
	text-transform: uppercase;
}

/* -- price theme ------ */
.card-price {
	border-color: #999;
	background-color: #ededed;
	margin-bottom: 24px;
}

.card-price>.card-heading, .card-price>.card-footer {
	color: #333;
	background-color: #fdfdfd;
}

.card-price>.card-heading {
	border-bottom: 1px solid #ddd;
	padding: 8px;
}

.card-price>.card-footer {
	border-top: 1px solid #ddd;
	padding: 8px;
}

.card-price>.card-img:first-child img {
	border-radius: 6px 6px 0 0;
}

.card-price>.card-left {
	padding-right: 4px;
}

.card-price>.card-right {
	padding-left: 4px;
}

.card-price .card-caption {
	color: #fff;
	text-align: center;
	text-transform: uppercase;
}

.card-price p:last-child {
	margin-bottom: 0;
}

.card-price .price {
	text-align: center;
	color: #337ab7;
	font-size: 3em;
	text-transform: uppercase;
	line-height: 0.7em;
	margin: 24px 0 16px;
}

.card-price .price small {
	font-size: 0.4em;
	color: #66a5da;
}

.card-price .details {
	list-style: none;
	margin-bottom: 24px;
	padding: 0 18px;
}

.card-price .details li {
	text-align: center;
	margin-bottom: 8px;
}

.card-price .buy-now {
	text-transform: uppercase;
}

.card-price table .price {
	font-size: 1.2em;
	font-weight: 700;
	text-align: left;
}

.card-price table .note {
	color: #666;
	font-size: 0.8em;
}
</style>
