<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>学生列表</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<table id="studentTable" class="easyui-datagrid" style="width:700px;height:250px"
			data-options="fit:true,rownumbers:true,
			method:'get',toolbar:'#tb',
			fitColumns:'true'">
		<thead>
			<tr>
				<th data-options="field:'ID',fixed:'true',width:'10%'">编号</th>
				<th data-options="field:'SID',align:'center',fixed:'true',width:'20%'">学号</th>
				<th data-options="field:'SNAME',align:'center',fixed:'true',width:'20%'">姓名</th>
				<th data-options="field:'SSEX',align:'center',fixed:'true',width:'10%'">性别</th>
				<th data-options="field:'SCLASS',align:'center',fixed:'true',width:'20%'">班级</th>
				<th data-options="field:'SPHONE',align:'center',fixed:'true',width:'20%'">联系电话</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb" style="padding:5px;height:auto">
		<div>
			<input id="searchText" class="easyui-textbox" prompt="请输入学生学号或姓名" style="width:15%;height:25px;padding:12px"/>
			<a id="search" class="easyui-linkbutton" iconCls="icon-search" onclick="searchStudent()">搜索</a>
			<a id="myStudents" class="easyui-linkbutton" iconCls="icon-man" onclick="searchMyStudent()">我的学生</a>
		</div>
	</div>
	<script type="text/javascript">
		/* 按条件查询学生信息 */
		function searchStudent() {
			var text = $("#searchText").val();
			$('#studentTable').datagrid({
				url:'/graduation/student/queryStudent?text='+text
			});
		}
		
		/* 我的学生 */
		function searchMyStudent() {
			var text = $("#searchText").val();
			$('#studentScoreTable').datagrid({
				url:'/graduation/student/queryMyStudent?text='+text
			});
		}
		
		/* 分页 */
		function pagerFilter(data){
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
			$('#studentTable').datagrid({loadFilter:pagerFilter}).datagrid({
				url:'/graduation/student/queryStudent',
				pagination: true,
				singleSelect:true
			});
		});
	</script>
</body>
</html>