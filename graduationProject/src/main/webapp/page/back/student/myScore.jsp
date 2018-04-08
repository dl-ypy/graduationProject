<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>我的成绩</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<script type="text/javascript" src="/graduation/echarts/echarts.min.js"></script>
	<script type="text/javascript">
		$(function(){
	    	searchScore('totalScore');
	    });
		
		/* 画仪表盘 */
		function scoreGauge(dataValue, scoreName) {
			// 基于准备好的dom，初始化echarts实例
	    	var myChart = echarts.init(document.getElementById('myScore'));
	    	// 指定图表的配置项和数据
	        var option = {
	        		tooltip : {
	        	        formatter: "{a} <br/>{b} : {c}"
	        	    },
	        	    toolbox: {
	        	        feature: {
	        	            saveAsImage: {}
	        	        }
	        	    },
	        	    series: [
	        	        {
	        	            name: '学生成绩',
	        	            type: 'gauge',
	        	            splitNumber: 4,
	        	            detail: {formatter:'{value}'},
	        	            data: [{value: dataValue, name: scoreName}],
	        	            axisLine: {            // 坐标轴线  
	                            lineStyle: {       // 属性lineStyle控制线条样式  
	                                color: [[0.25, '#c23531'], [0.5, '#ffc125'], [0.75, '#91c7ae'], [1, '#9acd32']]
	                            }  
	                        },
	        	        }
	        	    ]
	        };

	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
		}
        
		/* 查询指定成绩 */
        function searchScore(score) {
        	var scoreData;
        	var scoreValue;
        	var scoreName;
        	$.ajax({
				url:'/graduation/student/queryOneStudent',
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						if (score == 'score1') {
							scoreData = info.data.score1;
							scoreName = '开题报告评分';
						} else if (score == 'score2') {
							scoreData = info.data.score2;
							scoreName = '中期报告评分';
						} else if (score == 'score3') {
							scoreData = info.data.score3;
							scoreName = '说明书评分';
						} else if (score == 'score4') {
							scoreData = info.data.score4;
							scoreName = '答辩评分';
						} else if (score == 'totalScore') {
							scoreData = info.data.totalScore;
							scoreName = '最终评分';
						}
					}
					if (scoreData == 'A') {
						scoreValue = 100;
					} else if (scoreData == 'B') {
						scoreValue = 75;
					} else if (scoreData == 'C') {
						scoreValue = 50;
					} else if (scoreData == 'D') {
						scoreValue = 25;
					}
					scoreGauge(scoreValue, scoreName);
				}
			});
        }
	</script>
	<div style="margin: 0 auto; width: 600px;height:400px;">
		<div id="myScore" style="width: 600px;height:350px;"></div>
		<div id="button-bar" style="margin-left: 115px">
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score1')">开题报告评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score2')">中期报告评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score3')">说明书评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score4')">答辩评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('totalScore')">最终评分</a>
		</div>
	</div>
</body>
</html>