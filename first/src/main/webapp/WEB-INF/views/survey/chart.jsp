<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>차트 페이지</title>
<jsp:include page="/resources/include/navbar.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/card.css">
<script type="text/javascript">
	var chartLabels = []; // 받아올 데이터를 저장할 배열 선언
	var chartData = [];
	var lineChartData;
	var label;
	var dateChart;
	var json_data;

	var osNameChart;
	var osLabels = [];
	var osData = [];
	var osLabel;
	var osColors = [];

	function createOsNameChart() {
		var ctx = document.getElementById("osNameChart").getContext("2d");
		osNameChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getOsNameChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getOsName.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				osLabels = [];
				osData = [];
				osColors = [];

				$.each(jsonData, function(inx, obj) {

					osLabels.push(obj.osName);
					osData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					osColors.push(color);

				});

				osNameChart.data = {
					labels : osLabels,
					datasets : [ {
						data : osData,
						backgroundColor : osColors
					} ]

				}

				osNameChart.update();
				// 				createChart();

			}
		});
	}

	var osVersionChart;
	var osVLabels = [];
	var osVData = [];
	var osVLabel;
	var osVColors = [];
	var osVLabels = [];

	function createOsVersionChart() {
		var ctx = document.getElementById("osVersionChart").getContext("2d");
		osVersionChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				animation: {
					onComplete: function () {
						window.JSREPORT_READY_TO_START = true
					}
				},
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getOsVersionChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getOsVersion.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				osVLabels = [];
				osVData = [];
				osVColors = [];

				$.each(jsonData, function(inx, obj) {
					if (obj.osVersion) {
						osVLabels.push(obj.osName + "v" + obj.osVersion);
					} else {
						osVLabels.push(obj.osName);
					}

					osVData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					osVColors.push(color);

				});

				osVersionChart.data = {
					labels : osVLabels,
					datasets : [ {
						data : osVData,
						backgroundColor : osVColors
					} ]

				}

				osVersionChart.update();

			}
		});
	}

	var browserNameChart;
	var browserNameLabels = [];
	var browserNameData = [];
	var browserNameLabel;
	var browserNameColors = [];

	function createBrowserNameChart() {
		var ctx = document.getElementById("browserNameChart").getContext("2d");
		browserNameChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getBrowserNameChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getBrowserName.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				browserNameLabels = [];
				browserNameData = [];
				browserNameColors = [];

				$.each(jsonData, function(inx, obj) {

					browserNameLabels.push(obj.browserName);
					browserNameData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					browserNameColors.push(color);

				});

				browserNameChart.data = {
					labels : browserNameLabels,
					datasets : [ {
						data : browserNameData,
						backgroundColor : browserNameColors
					} ]

				}

				browserNameChart.update();

			}
		});
	}

	var browserVersionChart;
	var browserVersionLabels = [];
	var browserVersionData = [];
	var browserVersionLabel;
	var browserVersionColors = [];
	var browserVersionLabels = [];

	function createBrowserVersionChart() {
		var ctx = document.getElementById("browserVersionChart").getContext(
				"2d");
		browserVersionChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getBrowserVersionChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getBrowserVersion.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				browserVersionLabels = [];
				browserVersionData = [];
				browserVersionColors = [];

				$.each(jsonData, function(inx, obj) {
					if (obj.browserVersion) {
						browserVersionLabels.push(obj.browserName + "v"
								+ obj.browserVersion);
					} else {
						browserVersionLabels.push(obj.browserName);
					}

					browserVersionData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					browserVersionColors.push(color);

				});

				browserVersionChart.data = {
					labels : browserVersionLabels,
					datasets : [ {
						data : browserVersionData,
						backgroundColor : browserVersionColors
					} ]

				}

				browserVersionChart.update();
			}
		});
	}

	var deviceBrandChart;
	var deviceBrandLabels = [];
	var deviceBrandData = [];
	var deviceBrandLabel;
	var deviceBrandColors = [];

	function createDeviceBrandChart() {
		var ctx = document.getElementById("deviceBrandChart").getContext("2d");
		deviceBrandChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getDeviceBrandChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getDeviceBrand.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				deviceBrandLabels = [];
				deviceBrandData = [];
				deviceBrandColors = [];

				$.each(jsonData, function(inx, obj) {

					deviceBrandLabels.push(obj.deviceBrand);
					deviceBrandData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					deviceBrandColors.push(color);

				});

				deviceBrandChart.data = {
					labels : deviceBrandLabels,
					datasets : [ {
						data : deviceBrandData,
						backgroundColor : deviceBrandColors
					} ]

				}

				deviceBrandChart.update();

			}
		});
	}

	var deviceModelChart;
	var deviceModelLabels = [];
	var deviceModelData = [];
	var deviceModelLabel;
	var deviceModelColors = [];
	var deviceModelLabels = [];

	function createDeviceModelChart() {
		var ctx = document.getElementById("deviceModelChart").getContext("2d");
		deviceModelChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getDeviceModelChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getDeviceModel.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				deviceModelLabels = [];
				deviceModelData = [];
				deviceModelColors = [];

				$.each(jsonData, function(inx, obj) {
					if (obj.deviceModel) {
						deviceModelLabels.push(obj.deviceBrand + "-"
								+ obj.deviceModel);
					} else {
						deviceModelLabels.push(obj.deviceBrand);
					}

					deviceModelData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					deviceModelColors.push(color);

				});

				deviceModelChart.data = {
					labels : deviceModelLabels,
					datasets : [ {
						data : deviceModelData,
						backgroundColor : deviceModelColors
					} ]

				}

				deviceModelChart.update();
			}
		});
	}

	var idChart;
	var idLabels = [];
	var idData = [];
	var idLabel;
	var idColors = [];

	function createIdChart() {
		var ctx = document.getElementById("idChart").getContext("2d");
		idChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getIdChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getId.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit
					+ "&check=" + $('#idCheckbox').is(':checked'),
			success : function(jsonData) {
				idLabels = [];
				idData = [];
				idColors = [];

				$.each(jsonData, function(inx, obj) {

					if (obj.id)
						idLabels.push(obj.id);
					else
						idLabels.push("비회원");

					idData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					idColors.push(color);

				});

				idChart.data = {
					labels : idLabels,
					datasets : [ {
						data : idData,
						backgroundColor : idColors
					} ]

				}

				idChart.update();

			}
		});
	}

	var ipChart;
	var ipLabels = [];
	var ipData = [];
	var ipLabel;
	var ipColors = [];

	function createIpChart() {
		var ctx = document.getElementById("ipChart").getContext("2d");
		ipChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getIpChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getIp.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				ipLabels = [];
				ipData = [];
				ipColors = [];

				$.each(jsonData, function(inx, obj) {

					ipLabels.push(obj.ip);

					ipData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					ipColors.push(color);

				});

				ipChart.data = {
					labels : ipLabels,
					datasets : [ {
						data : ipData,
						backgroundColor : ipColors
					} ]

				}

				ipChart.update();

			}
		});
	}

	var refererChart;
	var refererLabels = [];
	var refererData = [];
	var refererLabel;
	var refererColors = [];

	function createRefererChart() {
		var ctx = document.getElementById("refererChart").getContext("2d");
		refererChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getRefererChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getReferer.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit
					+ "&check=" + $('#refererCheckbox').is(':checked'),
			success : function(jsonData) {
				refererLabels = [];
				refererData = [];
				refererColors = [];

				$.each(jsonData, function(inx, obj) {
					if (obj.referer)
						refererLabels.push(obj.referer);
					else
						refererLabels.push("직접 접속");

					refererData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					refererColors.push(color);

				});

				refererChart.data = {
					labels : refererLabels,
					datasets : [ {
						data : refererData,
						backgroundColor : refererColors
					} ]

				}

				refererChart.update();

			}
		});
	}

	var pathChart;
	var pathLabels = [];
	var pathData = [];
	var pathLabel;
	var pathColors = [];

	function createPathChart() {
		var ctx = document.getElementById("pathChart").getContext("2d");
		pathChart = new Chart(ctx, {
			type : 'pie',
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}

	function getPathChart(start, end, limit) {
		$.ajax({
			type : 'POST',
			url : "/chart/getPath.ajax",
			dataType : "json",
			data : "start=" + start + "&end=" + end + "&limit=" + limit,
			success : function(jsonData) {
				pathLabels = [];
				pathData = [];
				pathColors = [];

				$.each(jsonData, function(inx, obj) {

					pathLabels.push(obj.path);

					pathData.push(obj.count);

					r = Math.floor(Math.random() * 200);
					g = Math.floor(Math.random() * 200);
					b = Math.floor(Math.random() * 200);
					color = 'rgb(' + r + ', ' + g + ', ' + b + ')';

					pathColors.push(color);

				});

				pathChart.data = {
					labels : pathLabels,
					datasets : [ {
						data : pathData,
						backgroundColor : pathColors
					} ]

				}

				pathChart.update();

			}
		});
	}
	var reVisitData = [];
	function getVisit(type, start, end) {
		$.ajax({
			type : 'POST',
			url : "/chart/getVisit.ajax",
			dataType : "json",
			data : "type=" + type + "&start=" + start + "&end=" + end,
			success : function(jsonData) {
				json_data = jsonData;
				// 				console.log(jsonData);
				chartLabels = [];
				chartData = [];

				$.each(jsonData, function(inx, obj) {
					date = new Date(obj.date);

					switch (type) {
					case 'y':
						chartLabels.push(date.format("yyyy"));
						label = '년도별 방문자 수';
						break;
					case 'm':
						chartLabels.push(date.format("yyyy-MM"));
						label = '월별 방문자 수';
						break;
					case 'd':
						chartLabels.push(date.format("yyyy-MM-dd"));
						label = '일별 방문자 수';
						break;
					}

					chartData.push(obj.count);

				});

				dateChart.data = {
					labels : chartLabels,
					datasets : [ {
						label : label,
						backgroundColor : "#bfdaf9",
						borderColor : "#80b6f4",
						pointBorderColor : "#80b6f4",
						pointBackgroundColor : "#80b6f4",
						pointHoverBackgroundColor : "#80b6f4",
						pointHoverBorderColor : "#80b6f4",
						fill : false,
						borderWidth : 4,
						data : chartData
					} ]

				}

				dateChart.update();
				// 				createChart();

			}
		});

		$.ajax({
			type : 'POST',
			url : "/chart/getNewVisit.ajax",
			dataType : "json",
			data : "type=" + type + "&start=" + start + "&end=" + end,
			success : function(jsonData) {
				chartNewLabels = [];
				chartNewData = [];
				var format;

				switch (type) {
				case 'y':
					format = "yyyy";
					newlabel = '년도별 신규 방문자 수';
					reLabel = '년도별 재 방문자 수';
					break;
				case 'm':
					format = "yyyy-MM";
					newlabel = '월별 신규 방문자 수';
					reLabel = '월별 재 방문자 수';
					break;
				case 'd':
					format = "yyyy-MM-dd";
					newlabel = '일별 신규 방문자 수';
					reLabel = '일별 재 방문자 수';
					break;
				}

				$.each(jsonData, function(inx, obj) {
					date = new Date(obj.date);
					for (var i = inx; i < chartLabels.length; i++) {
						if (chartLabels[i] == date.format(format)) {
							chartNewData.push(obj.count);
							break;
						} else {
							chartNewData.push(0);
						}
					}

				});

				var reVisitData = [];
				for (var i = 0; i < chartData.length; i++) {
					if (chartNewData[i])
						reVisitData.push(chartData[i] - chartNewData[i]);
					else
						reVisitData.push(chartData[i]);

					// 					console.log(reVisitData[i]);
				}

				dateChart.data = {
					labels : chartLabels,
					datasets : [ {
						label : label,
						backgroundColor : "#bfdaf9",
						borderColor : "#80b6f4",
						pointBorderColor : "#80b6f4",
						pointBackgroundColor : "#80b6f4",
						pointHoverBackgroundColor : "#80b6f4",
						pointHoverBorderColor : "#80b6f4",
						fill : false,
						borderWidth : 4,
						data : chartData
					}, {
						label : newlabel,
						backgroundColor : "#f0f6f4",
						borderColor : "#ffb6f4",
						pointBorderColor : "#ffb6f4",
						pointBackgroundColor : "#ffb6f4",
						pointHoverBackgroundColor : "#ffb6f4",
						pointHoverBorderColor : "#ffb6f4",
						fill : false,
						borderWidth : 4,
						data : chartNewData
					}, {
						label : reLabel,
						backgroundColor : "#daffd4",
						borderColor : "#80f9b4",
						pointBorderColor : "#80f9b4",
						pointBackgroundColor : "#80f9b4",
						pointHoverBackgroundColor : "#80f9b4",
						pointHoverBorderColor : "#80f9b4",
						fill : false,
						borderWidth : 4,
						data : reVisitData
					}

					]

				}

				dateChart.update();
				// 				createChart();

			}
		});
	}

	function createVisitChart() {
		var ctx = document.getElementById("dateChart").getContext("2d");
		dateChart = Chart.Bar(ctx, {
			data : lineChartData,
			options : {
				maintainAspectRatio : false,
				// 				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}
	

	function chartInit() {		
		var start = new Date(0).getTime();
		var end = new Date().getTime();
		var limit = 0;

		if($('#dateChart').length > 0) {
			createVisitChart();
			getVisit('y', start, end);
		}

		if($('#osNameChart').length > 0) {
			createOsNameChart();
			getOsNameChart(start, end, limit);
		}
		
		if($('#osVersionChart').length > 0) {
			createOsVersionChart();
			getOsVersionChart(start, end, limit);
		}

		if($('#browserNameChart').length > 0) {
			createBrowserNameChart();
			getBrowserNameChart(start, end, limit);
		}
		if($('#browserVersionChart').length > 0) {
			createBrowserVersionChart();
			getBrowserVersionChart(start, end, limit);
		}
		if($('#deviceBrandChart').length > 0) {
			createDeviceBrandChart();
			getDeviceBrandChart(start, end, limit);
		}
		if($('#deviceModelChart').length > 0) {
			createDeviceModelChart();
			getDeviceModelChart(start, end, limit);
		}
		if($('#idChart').length > 0) {
			createIdChart();
			getIdChart(start, end, limit);
		}
		if($('#ipChart').length > 0) {
			createIpChart();
			getIpChart(start, end, limit);
		}
		if($('#refererChart').length > 0) {
		createRefererChart();
		getRefererChart(start, end, limit);
		}
		if($('#pathChart').length > 0) {
		createPathChart();
		getPathChart(start, end, limit);
		}
// 		page, perPageNum, searchType, keyword, start, end
		getList(${pvo.page}, ${pvo.perPageNum}, '${pvo.searchType}', '${pvo.keyword}', start, end);
	}

	function clickBtn(page) {
		if(page)
			pvo.page = page;
		
		pvo.perPageNum = $("#perPageNum option:selected").val();		
		
		type = $('#selectType option:selected').val();

		if ($('#startDate').val())
			start = new Date($('#startDate').val()).getTime();
		else
			start = new Date(0).getTime();

		if ($('#endDate').val())
			end = new Date($('#endDate').val()).getTime();
		else
			end = new Date().getTime();

		limit = 0;
		
		if($('#dateChart').length > 0) {
			getVisit('y', start, end);
		}
		if($('#osNameChart').length > 0) {
			getOsNameChart(start, end, limit);
		}		
		if($('#osVersionChart').length > 0) {
			getOsVersionChart(start, end, limit);
		}
		if($('#browserNameChart').length > 0) {
			getBrowserNameChart(start, end, limit);
		}
		if($('#browserVersionChart').length > 0) {
			getBrowserVersionChart(start, end, limit);
		}
		if($('#deviceBrandChart').length > 0) {
			getDeviceBrandChart(start, end, limit);
		}
		if($('#deviceModelChart').length > 0) {
			getDeviceModelChart(start, end, limit);
		}
		if($('#idChart').length > 0) {
			getIdChart(start, end, $('#idSelect option:selected').val());
		}
		if($('#ipChart').length > 0) {
			getIpChart(start, end, $('#ipSelect option:selected').val());
		}
		if($('#refererChart').length > 0) {
			getRefererChart(start, end, $('#refererSelect option:selected').val());
		}
		if($('#pathChart').length > 0) {
			getPathChart(start, end, $('#pathSelect option:selected').val());
		}

// 		getVisit(type, start, end);
// 		getOsNameChart(start, end, limit);
// 		getOsVersionChart(start, end, limit);
// 		getBrowserNameChart(start, end, limit);
// 		getBrowserVersionChart(start, end, limit);
// 		getDeviceBrandChart(start, end, limit);
// 		getDeviceModelChart(start, end, limit);
// 		getIdChart(start, end, $('#idSelect option:selected').val());
// 		getIpChart(start, end, $('#ipSelect option:selected').val());
// 		getRefererChart(start, end, $('#refererSelect option:selected').val());
// 		getPathChart(start, end, $('#pathSelect option:selected').val());
		
// 		page, perPageNum, searchType, keyword, start, end
		getList(pvo.page, pvo.perPageNum, pvo.searchType+'', pvo.keyword+'', start, end);
			
	}
	
	var list, pageMaker, pvo;
	function getList(page, perPageNum, searchType, keyword, start, end) {
		var html = '';
		var pageHtml = '';
		var sendData = "page=" + page + "&perPageNum=" +perPageNum + "&searchType=" + searchType + "&keyword=" + keyword + "&start=" + start + "&end=" + end;
		
		$.ajax({
			type : 'POST',
			url : "/chart/getList.ajax",
			dataType : "json",
			data : sendData,
			success : function(jsonData) {
				list = jsonData.list;
// 				console.log(list);
				pageMaker = jsonData.pageMaker;
// 				console.log(pageMaker);
				pvo = jsonData.pvo;
// 				console.log(pvo);
				$('#tbody').html(html);
				
				$.each(list, function(inx, obj) {
					html +=	'<tr>';
					html += '<td>' + ((pageMaker.totalCount - inx) - ( (pvo.page - 1)  *  pvo.perPageNum )) + '</td>';
					html += '<td>' + obj.ip +'</td>';
					html += '<td>' + new Date(obj.date).format("yyyy-MM-dd HH:mm") +'</td>';
					html += '<td>' + obj.id + '</td>';
					html += '<td>' + obj.osName + '</td>';
					html += '<td>' + obj.osVersion + '</td>';
					html += '<td>' + obj.browserName + '</td>';
					html += '<td>' + obj.browserVersion + '</td>';
					html += '<td>' + obj.deviceBrand + '</td>';
					html += '<td>' + obj.deviceModel + '</td>';
					html += '<td>' + obj.referer + '</td>';
					html += '<td>' + obj.path + '</td>';
					html += '</tr>';

				});
				
				$('#tbody').html(html);
				$('#pagination').html(pageHtml);
				
				if(pageMaker.prev) {
					pageHtml +=	'<li class="page-item"><a class="page-link"';
					pageHtml +=		'href="javascript:clickBtn('+1+');">처음</a></li>';
					pageHtml +=	'<li class="page-item"><a class="page-link"';
					pageHtml +=		'href="javascript:clickBtn('+(pageMaker.startPage-1)+');">이전</a></li>';
				}				
				
				for(var i=pageMaker.startPage; i<=pageMaker.endPage; i++) {
					pageHtml +=	'<li class="page-item ';
					if(pvo.page == i)
						pageHtml += ' active';
					
					pageHtml += '" >';
							
					pageHtml +=		'<a class="page-link" href="javascript:clickBtn('+i+');">'+i+'</a>';
					pageHtml +=	'</li>';
				}
				
				if(pageMaker.next && pageMaker.endPage > 0) {
					pageHtml +=	'<li class="page-item"><a class="page-link"';
					pageHtml +=		'href="javascript:clickBtn('+(pageMaker.endPage+1)+');">다음</a></li>';
					pageHtml +=	'<li class="page-item"><a class="page-link"';
					pageHtml +=		'href="javascript:clickBtn('+pageMaker.totalPage+');">마지막</a></li>';
				}
				
				$('#pagination').html(pageHtml);
			}
		});
		
	}
	
	function print() {
		var cssText = "";
	}
	
	$(document).ready(function() {
		chartInit();

		$('#startDate').datetimepicker({
			format : 'L'
		});
		$('#endDate').datetimepicker({
			format : 'L',
			useCurrent : false
		//Important! See issue #1075
		});
		$("#startDate").on("dp.change", function(e) {
			$('#endDate').data("DateTimePicker").minDate(e.date);
		});
		$("#endDate").on("dp.change", function(e) {
			$('#startDate').data("DateTimePicker").maxDate(e.date);
		});
		
		$('button[name=modBtn]').click(function(){
			var seq = this.form.seq.value;
			$('#modSeq').val(seq);
			$('#modifyModal').modal();
		});
		
		$('#addChartBtn').click(function(){			
			$('#addModal').modal();
		});
		
		$('#modalAddBtn').click(function(){
			$('#addChartForm').submit();
		});
		
		$('#modalModBtn').click(function(){
			$('#modChartForm').submit();
		});
		
		$('#allprint').click(function(){
			window.print();
		});
		
		$('#printBtn').click(function(){		
			$("#print_div").html("");
			if($('input:checkbox[id="printTable"]').is(":checked"))
				$("#print_div").append($('#tableDiv').html());
			
			if($('input:checkbox[id="printdate"]').is(":checked"))
				$("#print_div").append($('#dateDiv').html());
			if($('input:checkbox[id="printosName"]').is(":checked"))
				$("#print_div").append($('#osNameDiv').html());
			if($('input:checkbox[id="printosVersion"]').is(":checked"))
				$("#print_div").append($('#osVersionDiv').html());
			if($('input:checkbox[id="printbrowserName"]').is(":checked"))
				$("#print_div").append($('#browserNameDiv').html());
			if($('input:checkbox[id="printbrowserVersion"]').is(":checked"))
				$("#print_div").append($('#browserVersionDiv').html());
			if($('input:checkbox[id="printdeviceBrand"]').is(":checked"))
				$("#print_div").append($('#deviceBrandDiv').html());
			if($('input:checkbox[id="printdeviceModel"]').is(":checked"))
				$("#print_div").append($('#deviceModelDiv').html());
			if($('input:checkbox[id="printid"]').is(":checked"))
				$("#print_div").append($('#idDiv').html());
			if($('input:checkbox[id="printip"]').is(":checked"))
				$("#print_div").append($('#ipDiv').html());
			if($('input:checkbox[id="printreferer"]').is(":checked"))
				$("#print_div").append($('#refererDiv').html());
			if(	$('input:checkbox[id="printpath"]').is(":checked"))
				$("#print_div").append($('#pathDiv').html());

			if($('input:checkbox[id="printosName"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printosVersion"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printbrowserName"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printbrowserVersion"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printdeviceBrand"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printdeviceModel"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printid"]').is(":checked")){
				
			}
			if($('input:checkbox[id="printip"]').is(":checked")){
				
			} 
			if($('input:checkbox[id="printreferer"]').is(":checked")){
				
			}
			if(	$('input:checkbox[id="printpath"]').is(":checked")){
				
			}
			
			
// 			var divToPrint=document.getElementById('print_div');
// 			var newWin=window.open('','Print-Window');
// 			  newWin.document.open();
// 			  newWin.document.write('<html><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');
// 			  newWin.document.close();
// 			  setTimeout(function(){newWin.close();},10);

			var print_contents = $("#print_div").html();
			$("#print_iframe").contents().find("body").html(print_contents);
			$("#print_iframe").contents().find(".btn_box_hidden").hide();
			$("#print_iframe").focus();
			frames["print_iframe"].focus();
			frames["print_iframe"].print();		
	
		});

	});
	
	
	
</script>
</head>
<body>
<!-- modifyModal -->
<div id='modifyModal' class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">차트 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form action="/chart/modifyChart.action" method="post" id="modChartForm">
      	<input type='hidden' name='seq' id='modSeq'>
      	유형 : 
      	<select id='modSelectType' name='type'>
				<option value='ip'>방문자의 IP</option>
				<option value='date'>방문자수</option>
				<option value='id'>방문자의 아이디</option>
				<option value='osName'>방문자의 OS 이름</option>
				<option value='osVersion'>방문자의 OS 버전</option>
				<option value='browserName'>방문자의 브라우저 이름</option>
				<option value='browserVersion'>방문자의 브라우저 버전</option>
				<option value='deviceBrand'>방문자의 디바이스 브랜드</option>
				<option value='deviceModel'>방문자의 디바이스 모델</option>
				<option value='referer'>방문자의 리퍼러</option>
				<option value='path'>방문자가 방문한 주소</option>
		</select>
		순서 : 
		<select id='modSelectBoardOrder' name='boardOrder'>
				<option value='0'>0</option>
				<option value='1'>1</option>
				<option value='2'>2</option>
				<option value='3'>3</option>
				<option value='4'>4</option>
				<option value='5'>5</option>
				<option value='6'>6</option>
				<option value='7'>7</option>
				<option value='8'>8</option>
				<option value='9'>9</option>
				<option value='10'>10</option>
		</select>
		크기 : 
		<select id='modSelectWidth' name='width'>
				<option value='2'>작음</option>
				<option value='1'>큼</option>				
		</select>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id='modalModBtn'>Save changes</button>
      </div>
    </div>
  </div>
</div>

<!-- addModal -->
<div id='addModal' class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">차트 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="/chart/addChart.action" method="post" id="addChartForm">
      	유형 : 
      	<select id='addSelectType' name='type'>
				<option value='ip'>방문자의 IP</option>
				<option value='date'>방문자수</option>
				<option value='id'>방문자의 아이디</option>
				<option value='osName'>방문자의 OS 이름</option>
				<option value='osVersion'>방문자의 OS 버전</option>
				<option value='browserName'>방문자의 브라우저 이름</option>
				<option value='browserVersion'>방문자의 브라우저 버전</option>
				<option value='deviceBrand'>방문자의 디바이스 브랜드</option>
				<option value='deviceModel'>방문자의 디바이스 모델</option>
				<option value='referer'>방문자의 리퍼러</option>
				<option value='path'>방문자가 방문한 주소</option>
		</select>
		순서 : 
		<select id='addSelectBoardOrder' name='boardOrder'>
				<option value='0'>0</option>
				<option value='1'>1</option>
				<option value='2'>2</option>
				<option value='3'>3</option>
				<option value='4'>4</option>
				<option value='5'>5</option>
				<option value='6'>6</option>
				<option value='7'>7</option>
				<option value='8'>8</option>
				<option value='9'>9</option>
				<option value='10'>10</option>
		</select>
		크기 : 
		<select id='addSelectWidth' name='width'>
				<option value='2'>작음</option>
				<option value='1'>큼</option>				
		</select>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id='modalAddBtn'>추가</button>
      </div>
    </div>
  </div>
</div>

	<div class='container'>	
		<div class='row'>
			<div class='col-12'>
				<div class='card card-default'>
					<div class='card-header text-center'>기간 선택</div>
					<div class='card-body'>
						<div class='col-sm-6'>
							<input id='startDate' type='text' class="form-control"
								placeholder='여기부터' />

						</div>
						<div class='col-sm-6'>
							<input id='endDate' type='text' class="form-control"
								placeholder='여기까지' />
						</div>
					</div>
					<div class='card-footer text-center'>
						<div class='input-group'>
							<select id='selectType' class='form-control'>
								<option value='y'>년</option>
								<option value='m'>월</option>
								<option value='d'>일</option>
							</select>
							<div class='input-group-btn'>
								<div class='input-group-text'>
									<button class='btn btn-default' onclick="clickBtn(1)">선택</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class='col-12' id='tableDiv'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자 로그 테이블
					<label><input type='checkbox' id='printTable' name='printTable'>인쇄</label>
					<form action="/chart/excelAll.xls" method="post">
						<button type='submit'>엑셀로 받기</button>
<!-- 						<button>엑셀로 받기(기간 및 검색 결과)</button> -->
<!-- 					<button>엑셀로 받기(현화면)</button>	 -->
					</form>	
					<button type='button' id='printBtn'>선택 인쇄</button>
					<button type='button' id='allprint'>전체 인쇄</button>				
									
					</div>
					<div class='card-body' style='height: 500px'>
						<table class='table table-striped' id='table'>
							<thead>
								<tr>
									<th>번호</th>
									<th>IP</th>
									<th>날짜</th>
									<th>아이디</th>
									<th>OS 이름</th>
									<th>OS 버전</th>
									<th>브라우저 이름</th>
									<th>브라우저 버전</th>
									<th>디바이스 브랜드</th>
									<th>디바이스 모델</th>
									<th>리퍼러</th>
									<th>방문한 주소</th>
								</tr>
							</thead>
							<tbody id='tbody'>
								<c:forEach items="${list}" var="userAgentVO" varStatus="status">
									<tr>
										<td>${(pageMaker.totalCount - status.index) - ( (pageMaker.pvo.page - 1)  *  pageMaker.pvo.perPageNum ) }</td>
										<td>${userAgentVO.ip}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${userAgentVO.date}" /></td>
										<td>${userAgentVO.id}</td>
										<td>${userAgentVO.osName}</td>
										<td>${userAgentVO.osVersion}</td>
										<td>${userAgentVO.browserName}</td>
										<td>${userAgentVO.browserVersion}</td>
										<td>${userAgentVO.deviceBrand}</td>
										<td>${userAgentVO.deviceModel}</td>
										<td>${userAgentVO.referer}</td>
										<td>${userAgentVO.path}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class='card-footer text-center'>
						<form action="/chart/home" method="post" name='searchForm'
							id='searchForm'>
							<div class='search row'>
								<div class='col-xs-2 col-sm-2'>
									<select name='perPageNum' class='form-control' id='perPageNum'
										onchange='clickBtn(1)'>
										<option value="3"
											<c:if test="${pageMaker.pvo.perPageNum == '3'}">selected="selected"</c:if>>3개</option>
										<option value="5"
											<c:if test="${pageMaker.pvo.perPageNum == '5'}">selected="selected"</c:if>>5개</option>
										<option value="10"
											<c:if test="${pageMaker.pvo.perPageNum == '10'}">selected="selected"</c:if>>10개</option>
										<option value="15"
											<c:if test="${pageMaker.pvo.perPageNum == '15'}">selected="selected"</c:if>>15개</option>
										<option value="20"
											<c:if test="${pageMaker.pvo.perPageNum == '20'}">selected="selected"</c:if>>20개</option>
										<option value="50"
											<c:if test="${pageMaker.pvo.perPageNum == '50'}">selected="selected"</c:if>>50개</option>
									</select>
								</div>
								<div class='col-xs-2 col-sm-2'>
									<select name="searchType" class='form-control' id='type'>
										<option value="n"
											<c:out value="${pvo.searchType == null?'selected':''}"/>>---</option>
										<option value="ip"
											<c:out value="${pvo.searchType eq 'ip'?'selected':''}"/>>IP</option>
										<option value="date"
											<c:out value="${pvo.searchType eq 'date'?'selected':''}"/>>날짜</option>
										<option value="id"
											<c:out value="${pvo.searchType eq 'id'?'selected':''}"/>>아이디</option>
										<option value="os"
											<c:out value="${pvo.searchType eq 'os'?'selected':''}"/>>OS</option>
										<option value="browser"
											<c:out value="${pvo.searchType eq 'browser'?'selected':''}"/>>브라우저</option>
										<option value="device"
											<c:out value="${pvo.searchType eq 'device'?'selected':''}"/>>디바이스</option>
										<option value="referer"
											<c:out value="${pvo.searchType eq 'referer'?'selected':''}"/>>리퍼러</option>
										<option value="path"
											<c:out value="${pvo.searchType eq 'path'?'selected':''}"/>>방문한 주소</option>
									</select>
								</div>

								<div class='col-xs-7 col-sm-7'>
									<div class='input-group'>
										<input type="text" name="keyword" id="listKeywordInput"
											class='form-control' value="${pvo.keyword}"> <span
											class='input-group-btn'>
											<button type='submit' id="searchBtn" class='btn btn-primary'>검색</button>
											<button type='button' id="addChartBtn" class='btn btn-info'>차트추가</button>
										</span>

									</div>
								</div>

							</div>
						</form>
						<div class='text-center'>
							<ul class="pagination" id='pagination'>
								<c:if test="${pageMaker.prev}">
									<li class='page-item'><a class='page-link'
										href="list${pageMaker.makeSearch(1)}">처음</a></li>
									<li class='page-item'><a class='page-link'
										href="list${pageMaker.makeSearch(pageMaker.startPage-1)}">이전</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li
										class='page-item 
						<c:if test="${pageMaker.pvo.page == idx}"> active</c:if>
						'>
										<%-- 						<c:out value="${pageMaker.pvo.page == idx?'class=page-item active':'' }"/>> --%>
										<a class='page-link' href="list${pageMaker.makeSearch(idx)}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li class='page-item'><a class='page-link'
										href="list${pageMaker.makeSearch(pageMaker.endPage+1)}">다음</a></li>
									<li class='page-item'><a class='page-link'
										href="list${pageMaker.makeSearch(pageMaker.totalPage)}">마지막</a></li>
								</c:if>

							</ul>
						</div>
					</div>
				</div>
			</div>

			<c:forEach items="${dashList }" var="vo" varStatus='status'>
				<div class='col-12 <c:if test="${vo.width == 2 }"> col-lg-6</c:if>' id='${vo.type }Div'>							
					<div class='card card-default'>
					<div class='card-header text-center'>
				<c:choose>
				<c:when test="${vo.type == 'ip' }">
				방문자의 IP
				</c:when>
				<c:when test="${vo.type == 'date' }">
				방문자수
				</c:when>
				<c:when test="${vo.type == 'id' }">
				방문자의 아이디
				</c:when>
				<c:when test="${vo.type == 'osName' }">
				방문자의 OS 이름
				</c:when>
				<c:when test="${vo.type == 'osVersion' }">
				방문자의 OS 버전
				</c:when>
				<c:when test="${vo.type == 'browserName' }">
				방문자의 브라우저 이름
				</c:when>
				<c:when test="${vo.type == 'browserVersion' }">
				방문자의 브라우저 버전
				</c:when>
				<c:when test="${vo.type == 'deviceBrand' }">
				방문자의 디바이스 브랜드
				</c:when>
				<c:when test="${vo.type == 'deviceModel' }">
				방문자의 디바이스 모델
				</c:when>
				<c:when test="${vo.type == 'referer' }">
				방문자의 리퍼러
				</c:when>
				<c:when test="${vo.type == 'path' }">
				방문자가 방문한 주소
				</c:when>
				</c:choose>
				<form method="post" action="/chart/delete.action">
				<input type='hidden' name='seq' value='${vo.seq }'>
				<input type='hidden' name='id' value='${vo.id }'>
				<input type='hidden' name='type' value='${vo.type }'>
				<input type='hidden' name='boardOrder' value='${vo.boardOrder }'>
				<input type='hidden' name='width' value='${vo.width }'>					
				<button type='button' name='modBtn'>수정</button>
				<button type='submit' name='delBtn'>삭제</button>
				</form>
				<label><input type='checkbox' id='print${vo.type }' name='print${vo.type }'>인쇄</label>
				</div>
						<div class='card-body' style='height: 500px'>
							<canvas id='${vo.type }Chart'></canvas>
						</div>
						<c:choose>
						<c:when test="${vo.type == 'id' }">
						<div class='card-footer text-center'>
						<div class='input-group'>
							<select id='idSelect' class='form-control' onchange='clickBtn()'>
								<option value='0'>전체</option>
								<option value='5'>5개</option>
								<option value='10'>10개</option>
								<option value='15'>15개</option>
								<option value='20'>20개</option>
							</select>
							<div class='input-group-addon'>
								<div class='input-group-text'>
									<input type='checkbox' id='idCheckbox' onclick='clickBtn()'>
									<label for="idCheckbox">비회원 제외</label>
								</div>
							</div>
						</div>
					</div>
						</c:when>
						<c:when test="${vo.type == 'referer' }">
						<div class='card-footer text-center'>
						<div class='input-group'>
							<select id='refererSelect' class='form-control'
								onchange='clickBtn()'>
								<option value='0'>전체</option>
								<option value='5'>5개</option>
								<option value='10'>10개</option>
								<option value='15'>15개</option>
								<option value='20'>20개</option>
							</select>
							<div class='input-group-addon'>
								<div class='input-group-text'>
									<input type='checkbox' id='refererCheckbox'
										onclick='clickBtn()'> <label for="refererCheckbox">직접
										접속 제외</label>
								</div>
							</div>
						</div>
					</div>
						</c:when>
						<c:when test="${vo.type == 'ip' }">
						<div class='card-footer text-center'>
						<select id='ipSelect' class='form-control' onchange='clickBtn()'>
							<option value='0'>전체</option>
							<option value='5'>5개</option>
							<option value='10'>10개</option>
							<option value='15'>15개</option>
							<option value='20'>20개</option>
						</select>
					</div>
						</c:when>
						<c:when test="${vo.type == 'path' }">
						<div class='card-footer text-center'>
						<select id='pathSelect' class='form-control' onchange='clickBtn()'>
							<option value='0'>전체</option>
							<option value='5'>5개</option>
							<option value='10'>10개</option>
							<option value='15'>15개</option>
							<option value='20'>20개</option>
						</select>
					</div>
						</c:when>
						</c:choose>
					</div>
				</div>
			</c:forEach>
			
			<c:if test="${dashList == null || dashList.size() == 0 }">
			<div class='col-12'>
				<div class='card card-default'>
					<div class='card-body' style='height: 500px'>
						<canvas id='dateChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 OS이름</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='osNameChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 OS버전</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='osVersionChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 브라우저 이름</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='browserNameChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 브라우저 버전</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='browserVersionChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 디바이스 브랜드</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='deviceBrandChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 디바이스 모델</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='deviceModelChart'></canvas>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 아이디</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='idChart'></canvas>
					</div>
					<div class='card-footer text-center'>
						<div class='input-group'>
							<select id='idSelect' class='form-control' onchange='clickBtn()'>
								<option value='0'>전체</option>
								<option value='5'>5개</option>
								<option value='10'>10개</option>
								<option value='15'>15개</option>
								<option value='20'>20개</option>
							</select>
							<div class='input-group-addon'>
								<div class='input-group-text'>
									<input type='checkbox' id='idCheckbox' onclick='clickBtn()'>
									<label for="idCheckbox">비회원 제외</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 IP</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='ipChart'></canvas>
					</div>
					<div class='card-footer text-center'>
						<select id='ipSelect' class='form-control' onchange='clickBtn()'>
							<option value='0'>전체</option>
							<option value='5'>5개</option>
							<option value='10'>10개</option>
							<option value='15'>15개</option>
							<option value='20'>20개</option>
						</select>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자의 리퍼러</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='refererChart'></canvas>
					</div>
					<div class='card-footer text-center'>
						<div class='input-group'>
							<select id='refererSelect' class='form-control'
								onchange='clickBtn()'>
								<option value='0'>전체</option>
								<option value='5'>5개</option>
								<option value='10'>10개</option>
								<option value='15'>15개</option>
								<option value='20'>20개</option>
							</select>
							<div class='input-group-addon'>
								<div class='input-group-text'>
									<input type='checkbox' id='refererCheckbox'
										onclick='clickBtn()'> <label for="refererCheckbox">직접
										접속 제외</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class='col-12 col-lg-6'>
				<div class='card card-default'>
					<div class='card-header text-center'>방문자가 방문한 주소</div>
					<div class='card-body' style='height: 500px'>
						<canvas id='pathChart'></canvas>
					</div>
					<div class='card-footer text-center'>
						<select id='pathSelect' class='form-control' onchange='clickBtn()'>
							<option value='0'>전체</option>
							<option value='5'>5개</option>
							<option value='10'>10개</option>
							<option value='15'>15개</option>
							<option value='20'>20개</option>
						</select>
					</div>
				</div>
			</div>
			</c:if>
		</div>
	</div>

</body>
</html>