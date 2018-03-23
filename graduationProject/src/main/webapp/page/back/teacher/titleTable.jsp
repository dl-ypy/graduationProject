<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>题目列表</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<table title="毕设题目列表" id="titleTable" class="easyui-datagrid" style="width:700px;height:250px"
			data-options="
				url: '/graduation/title/queryTitle',
				fit:true,rownumbers:true,
				method:'get',toolbar:'#tbTitle',
				fitColumns:'true',
				singleSelect:'true',
				onClickCell:ClickCellTitle
			">
		<thead>
			<tr>
				<th field="CNAME" width="15%" align="center">题目名称</th>
				<th field="REQ" width="30%" align="center">题目需求</th>
				<th field="TASK" width="40%" align="center">题目任务</th>
				<th id="studentName" field="SNAME" width="10%" align="center">所选学生</th>
				<th id="studentID" field="SID" width="0%" hidden="true"></th>
				<th field="CSELECTED" width="5%" align="center">是否已选</th>
			</tr>
		</thead>
	</table>
	
	<div id="tbTitle" style="padding:5px;height:auto">
		<div>
			<input id="searchTitleText" class="easyui-textbox" prompt="请输入题目名称" style="width:15%;height:25px;padding:12px"/>
			<a id="searchTitle" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTitle()">搜索</a>
		</div>
	</div>
	
	
	<div id="reqDlg" closed="true" class="easyui-dialog" title="题目需求" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	<div id="taskDlg" closed="true" class="easyui-dialog" title="题目任务" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	
	<script type="text/javascript">
		/* 按条件查询题目信息 */
		function searchTitle() {
			var text = $("#searchTitleText").val();
			$('#titleTable').datagrid({
				url:'/graduation/title/queryTitle?text='+text
			});
		}
		
		/* 点击行事件 */
		function ClickCellTitle(index, field) {
			var titleRows = $('#titleTable').datagrid('getRows');
			if (field == "SNAME") {
				//获取单元格的值
				var studentName = titleRows[index].SNAME
				if (studentName !== "-") {
					var studentSID = titleRows[index].SID;  //得到学生学号
					window.open('/graduation/page/back/teacher/studentScoreTable.jsp?text='+studentSID); //打开新窗口
				} else {
					$.messager.alert('提示','该门课程还未被选择','warning');
				}
			} else if (field == "REQ") {
				var studentREQ = titleRows[index].REQ;
				$('#reqDlg').text(studentREQ);
				$('#reqDlg').dialog('open');
			} else if (field == "TASK") {
				var studentTASK = titleRows[index].TASK;
				$('#taskDlg').text(studentTASK);
				$('#taskDlg').dialog('open');
			}
		}
	</script>
</body>
</html>