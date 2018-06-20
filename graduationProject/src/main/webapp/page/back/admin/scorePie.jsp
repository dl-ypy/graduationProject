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
		function scorePie(scoreData) {
			// 基于准备好的dom，初始化echarts实例
	    	var myChart = echarts.init(document.getElementById('scorePie'));
	    	// 指定图表的配置项和数据
	        var option = {
	        		title : {
	        	        text: '学生毕设成绩分布图',
	        	        x:'center'
	        	    },
	        	    tooltip : {
	        	        trigger: 'item',
	        	        formatter: "{a} <br/>{b} : {c}人 ({d}%)"
	        	    },
	        	    color:['#EE0000', '#EEB422','#8EE5EE','#7CCD7C','#878787'],
	        	    legend: {
	        	        orient: 'vertical',
	        	        left: 'left',
	        	        data: ['不及格','及格','良好','优秀','未评分']
	        	    },
	        	    series : [
	        	        {
	        	            name: '访问来源',
	        	            type: 'pie',
	        	            radius : '55%',
	        	            center: ['50%', '60%'],
	        	            data: scoreData,
	        	            itemStyle: {
	        	                emphasis: {
	        	                    shadowBlur: 10,
	        	                    shadowOffsetX: 0,
	        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	        	                }
	        	            }
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
				url:'/graduation/student/queryAllStudent',
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						var scoreList = info.data;
						var scoreData = [];
						var score1 = 0;
						var score2 = 0;
						var score3 = 0;
						var score4 = 0;
						var kong = 0;
						for (var i=0; i<scoreList.length; i++) {
							if (score == 'totalScore') {
								if (scoreList[i].TOTALSCORE==null || scoreList[i].TOTALSCORE=='' || scoreList[i].TOTALSCORE=='未全部评完') {
									kong++;
								} else if (scoreList[i].TOTALSCORE == 'A') {
									score1++;
								} else if (scoreList[i].TOTALSCORE == 'B') {
									score2++;
								} else if (scoreList[i].TOTALSCORE == 'C') {
									score3++;
								} else if (scoreList[i].TOTALSCORE == 'D') {
									score4++;
								}
							} else if (score == 'score1') {
								if (scoreList[i].SCORE1==null || scoreList[i].SCORE1=='') {
									kong++;
								} else if (scoreList[i].SCORE1 == 'A') {
									score1++;
								} else if (scoreList[i].SCORE1 == 'B') {
									score2++;
								} else if (scoreList[i].SCORE1 == 'C') {
									score3++;
								} else if (scoreList[i].SCORE1 == 'D') {
									score4++;
								}
							} else if (score == 'score2') {
								if (scoreList[i].SCORE2==null || scoreList[i].SCORE2=='') {
									kong++;
								} else if (scoreList[i].SCORE2 == 'A') {
									score1++;
								} else if (scoreList[i].SCORE2 == 'B') {
									score2++;
								} else if (scoreList[i].SCORE2 == 'C') {
									score3++;
								} else if (scoreList[i].SCORE2 == 'D') {
									score4++;
								}
							} else if (score == 'score3') {
								if (scoreList[i].SCORE3==null || scoreList[i].SCORE3=='') {
									kong++;
								} else if (scoreList[i].SCORE3 == 'A') {
									score1++;
								} else if (scoreList[i].SCORE3 == 'B') {
									score2++;
								} else if (scoreList[i].SCORE3 == 'C') {
									score3++;
								} else if (scoreList[i].SCORE3 == 'D') {
									score4++;
								}
							} else if (score == 'score4') {
								if (scoreList[i].SCORE4==null || scoreList[i].SCORE4=='') {
									kong++;
								}else if (scoreList[i].SCORE4 == 'A') {
									score1++;
								} else if (scoreList[i].SCORE4 == 'B') {
									score2++;
								} else if (scoreList[i].SCORE4 == 'C') {
									score3++;
								} else if (scoreList[i].SCORE4 == 'D') {
									score4++;
								}
							}
						}
						scoreData.push({name:'不及格',value:score4},{name:'及格',value:score3},{name:'良好',value:score2},{name:'优秀',value:score1},{name:'未评分',value:kong});
					}
					scorePie(scoreData);
				}
			});
        }
	</script>
	<div style="background: url('/graduation/images/score.jpg');widows: 100%;height: 100%">
	<div style="margin: 0 auto; width: 100%;height:100%;">
		<div id="scorePie" style="width: 100%;height:400px;"></div>
		<div id="button-bar" style="margin-left: 400px">
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score1')">开题报告评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score2')">中期报告评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score3')">说明书评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('score4')">答辩评分</a>
			<a href="#" class="easyui-linkbutton" onclick="searchScore('totalScore')">最终评分</a>
		</div>
	</div>
	</div>
</body>
</html>