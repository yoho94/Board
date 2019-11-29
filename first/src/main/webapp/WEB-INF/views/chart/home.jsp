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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
    console.log(navigator.userAgent);
//  $(document).ready(function(){      

//  });
    	var json_data;
      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
//       google.charts.setOnLoadCallback(drawChart('d'));
      google.charts.setOnLoadCallback(function() {drawChart('d')});

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart(type) {

        // Create the data table.
        var data = new google.visualization.DataTable();
//         data.addColumn('string', 'Topping');
//         data.addColumn('number', 'Slices');
//         data.addRows([
//           ['Mushrooms', 3],
//           ['Onions', 1],
//           ['Olives', 1],
//           ['Zucchini', 1],
//           ['Pepperoni', 2]
//         ]);

// 	      jsonData = $.ajax({
// 	          type:'POST',
// 	          url : "<c:url value='/chart/getDate'/>",
// 	          dataType : "json"
// 	      }).responseText;

	      $.ajax({
	          type:'POST',
	          url : "/chart/getDate",
	          dataType : "text",
	          data : "type=" + type,
	          success : function(jsonData){
		        	console.log(jsonData);
		        	json_data = jsonData;
		        	
		        	json_data_arr = json_data.split(',');
	        	  
// 	      	  	var data = new google.visualization.DataTable();	      	   	
	      	   	data.addColumn('datetime' , '날짜');
	      	   	data.addColumn('number' , '게시물 수');	      	   	
	      	   	var dataRow = [];
	      	   	

	        	
	        	for(var i=0; i<json_data_arr.length; i++) {
	        		var tmp = json_data_arr[i].split('=');
	        		
	        		var date = new Date(tmp[0]);
	        		var cnt = Number(tmp[1]);
	        		
	        		dataRow = [date, cnt];
	        		data.addRow(dataRow);
	        	}

	        	

	      	   	
// 	        	for(var i=0; i<json_data.regDate.length; i++) {
// 	        		var date = new Date(json_data.regDate[i]);	      
// 	        		dataRow = [date, 1];
// 	        		data.addRow(dataRow);
// 	        	}
	      	   	
				
	            // Set chart options
	            var options = {'title':'게시글 올린 시간',
	                           'width':800,
	                           'height':600};
	            
	            // Instantiate and draw our chart, passing in some options.
	            var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
	            chart.draw(data, options);     	  
	        	  
	          }
	      });	      
        }
      
      
//     $(document).ready(function(){      

//     });
      
    </script>
</head>
<body>
</body>
<div class='container'>
	<div id="chart_div"></div>
</div>
</html>