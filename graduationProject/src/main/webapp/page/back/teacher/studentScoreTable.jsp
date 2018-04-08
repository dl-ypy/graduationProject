<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>学生成绩列表</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<table id="studentScoreTable" class="easyui-datagrid" style="width:700px;height:250px"
			data-options="fit:true,rownumbers:true,
			method:'get',
			toolbar:'#tbs',
			fitColumns:'true',
			onDblClickRow: onClickRow,
			onSelect: onSelect">
		<thead>
			<tr>
				<th data-options="field:'ID',fixed:'true',width:'10%'">编号</th>
				<th data-options="field:'SID',align:'center',fixed:'true',width:'15%',sortable:'true'">学号</th>
				<th data-options="field:'SNAME',align:'center',fixed:'true',width:'15%'">姓名</th>
				<th data-options="field:'SCORE1',align:'center',fixed:'true',width:'12%',sortable:'true',editor:{
							type:'combobox',
							options:{
								valueField:'score1Id',
								textField:'score1Name',
								method:'get',
								data:[
										{'score1Id':'A','score1Name':'A'},
									    {'score1Id':'B','score1Name':'B'},
									    {'score1Id':'C','score1Name':'C'},
									    {'score1Id':'D','score1Name':'D'},
									    {'score1Id':'','score1Name':'无'},
									 ],
							    editable:false 
							}
						}">开题报告评分</th>
				<th data-options="field:'SCORE2',align:'center',fixed:'true',width:'12%',sortable:'true',editor:{
							type:'combobox',
							options:{
								valueField:'score2Id',
								textField:'score2Name',
								method:'get',
								editable:false,
								data:[
										{'score2Id':'A','score2Name':'A'},
									    {'score2Id':'B','score2Name':'B'},
									    {'score2Id':'C','score2Name':'C'},
									    {'score2Id':'D','score2Name':'D'},
									    {'score2Id':'','score2Name':'无'},
									 ]
							}
						}">中期报告评分</th>
				<th data-options="field:'SCORE3',align:'center',fixed:'true',width:'12%',sortable:'true',editor:{
							type:'combobox',
							options:{
								valueField:'score3Id',
								textField:'score3Name',
								method:'get',
								editable:false,
								data:[
										{'score3Id':'A','score3Name':'A'},
									    {'score3Id':'B','score3Name':'B'},
									    {'score3Id':'C','score3Name':'C'},
									    {'score3Id':'D','score3Name':'D'},
									    {'score3Id':'','score3Name':'无'},
									 ]
							}
						}">说明书评分</th>
				<th data-options="field:'SCORE4',align:'center',fixed:'true',width:'12%',sortable:'true',editor:{
							type:'combobox',
							options:{
								valueField:'score4Id',
								textField:'score4Name',
								method:'get',
								editable:false,
								data:[
										{'score4Id':'A','score4Name':'A'},
									    {'score4Id':'B','score4Name':'B'},
									    {'score4Id':'C','score4Name':'C'},
									    {'score4Id':'D','score4Name':'D'},
									    {'score4Id':'','score4Name':'无'},
									 ]
							}
						}">答辩评分</th>
						<th data-options="field:'TOTALSCORE',align:'center',fixed:'true',width:'12%'">最终成绩</th>
			</tr>
		</thead>
	</table>
	
	<div id="tbs" style="padding:5px;height:auto">
		<div>
			<input id="searchText" class="easyui-textbox" prompt="请输入学生学号或姓名" style="width:15%;height:25px;padding:12px"/>
			<a id="search" class="easyui-linkbutton" iconCls="icon-search" onclick="searchStudent()">搜索</a>
			<a id="myStudents" class="easyui-linkbutton" iconCls="icon-man" onclick="searchMyStudent()">我的学生</a>
			<a id="allStudents" class="easyui-linkbutton" iconCls="icon-man" onclick="searchAllStudent()">全部学生</a>
			<a id="helpS" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#help').window('open')">帮助</a>
		</div>
	</div>
	<!-- 帮助内容 -->
	<div id="help" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据学号或者姓名搜索学生。<br/>
		2.点击"我的学生"按钮可查看归您管理的学生。<br/>
		3.点击"全部学生"按钮可查看全部学生信息。<br/>
		4.选择您的学生，双击该行，即可对该学生进行评分，再单击该行即可保存。</br>
		5.若您查询不到任何数据，可能是您没有以教师或管理员身份登录。
		</b></h3>
	</div>
	<script type="text/javascript">
		var flag = 0;   //判断查询的学生是否为自己的学生
		/* 按条件查询学生信息 */
		function searchStudent() {
			editIndex = undefined;   //查询学生信息，相当于刷新页面，需要将editIndex重新赋值
			var text = $("#searchText").val();
			$('#studentScoreTable').datagrid({
				url:'/graduation/student/queryStudent?text='+text+'&flag='+flag
			});
		}
		
		/* 我的学生 */
		function searchMyStudent() {
			flag = 1;
			editIndex = undefined;   //相当于刷新页面，需要将editIndex重新赋值
			var text = $("#searchText").val();
			$('#studentScoreTable').datagrid({
				url:'/graduation/student/queryStudent?text='+text+'&flag='+flag
			});
		}
		
		/* 全部学生 */
		function searchAllStudent() {
			flag = 0;
			editIndex = undefined;   //相当于刷新页面，需要将editIndex重新赋值
			var text = $("#searchText").val();
			$('#studentScoreTable').datagrid({
				url:'/graduation/student/queryStudent?text='+text+'&flag='+flag
			});
		}
		
		/* 分页 */
		function pagerFilter(data){
			editIndex = undefined;   //刷新页面，需要将editIndex重新赋值
			if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
				data = {
					total: data.length,
					rows: data
				}
			}
			var dg = $(this);
			var opts = dg.datagrid('options');
			var pager = dg.datagrid('getPager');
			pager.pagination({
				onSelectPage:function(pageNum, pageSize){
					opts.pageNumber = pageNum;
					opts.pageSize = pageSize;
					pager.pagination('refresh',{
						pageNumber:pageNum,
						pageSize:pageSize
					});
					dg.datagrid('loadData',data);
				}
			});
			if (!data.originalRows){
				data.originalRows = (data.rows);
			}
			var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
			var end = start + parseInt(opts.pageSize);
			data.rows = (data.originalRows.slice(start, end));
			return data;
		}
		
		/* 表格配置 */
		$(function(){
			var text = '';
			var urlMsg = window.location.href;  //获取url的信息
			var indexD = urlMsg.indexOf('=');   //得到字符串中’=‘的下标
			if (indexD !== -1) {
				text = urlMsg.substring(indexD+1, urlMsg.lenght);  //截取参数
			}
			$('#studentScoreTable').datagrid({loadFilter:pagerFilter}).datagrid({
				url:'/graduation/student/queryStudent?flag=0&text='+text,
				pagination: true,
				singleSelect:true,
			});

			/* 排序 */
			$("#studentScoreTable").datagrid({
				onSortColumn: function (sort, order) {
		            loadlistgrid(sort, order);
		        }
			})
		});
		
		var editIndex = undefined;
		var sid;  //此次点击的学生学号
		var sid1;  //上次点击的学生学号
		/*结束编辑*/
		function endEditing(){
			var row = $("#studentScoreTable").datagrid("getSelected");
			sid = row.SID;
			if (editIndex == undefined){
				sid1 = sid;
				return true;
			}
			if ($('#studentScoreTable').datagrid('validateRow', editIndex)){
				//注意：getEditor要在endEdit之前，否则得到null，field对应的属性也必须有editor属性，否则也得到null
				var ed1 = $('#studentScoreTable').datagrid('getEditor', {index:editIndex,field:'SCORE1'});
				var sc1 = $(ed1.target).combobox('getText');
				var ed2 = $('#studentScoreTable').datagrid('getEditor', {index:editIndex,field:'SCORE2'});
				var sc2 = $(ed2.target).combobox('getText');
				var ed3 = $('#studentScoreTable').datagrid('getEditor', {index:editIndex,field:'SCORE3'});
				var sc3 = $(ed3.target).combobox('getText');
				var ed4 = $('#studentScoreTable').datagrid('getEditor', {index:editIndex,field:'SCORE4'});
				var sc4 = $(ed4.target).combobox('getText');
				$('#studentScoreTable').datagrid('endEdit', editIndex);
				//进行修改的ajax
				$.ajax({
					url:'/graduation/student/updateStudent?sid='+sid1+'&score1='+sc1+'&score2='+sc2+'&score3='+sc3+'&score4='+sc4,
					type:"get",
					dataType:"json",
					success:function(data){
						var info = eval(data);
						var status = info.status;
						var msg = info.msg;
						if (status != '0') {
							$.messager.alert('修改错误',msg,'warning');
							//searchStudent();
						}
						$('#studentScoreTable').datagrid('reload');  //刷新表格数据
					}
				});
				
				editIndex = undefined;
				sid1 = sid;  //每次用完sid1后，将本次点击的sid赋给sid1
				return true;
			} else {
				sid1 = sid;
				return false;
			}
		}
		
		/*双击编辑*/
		function onClickRow(index){
			if (editIndex != index){
				if (endEditing()){
					$('#studentScoreTable').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					editIndex = index;
				} else {
					$('#studentScoreTable').datagrid('selectRow', editIndex);
				}
			}
		}
		
		/* 单击结束编辑 */
		function onSelect(index) {
			if(editIndex != undefined) {
				endEditing();
			}
		}
		
		/* 排序 */
		function loadlistgrid(sortname, sortvalue) {
			var text = $("#searchText").val();
			$('#studentScoreTable').datagrid({
				url:'/graduation/student/queryStudent?sortname=' + sortname + '&sortvalue=' + sortvalue + '&flag=' + flag +'&text='+text
			});
		}
	</script>
</body>
</html>