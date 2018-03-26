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
				url: '/graduation/title/queryAllTitle',
				fit:true,rownumbers:true,
				method:'get',toolbar:'#tbTitle',
				fitColumns:'true',
				singleSelect:'true',
				onDblClickCell:ClickCellTitle
			">
		<thead>
			<tr>
				<th field="CNAME" width="15%" align="center">题目名称</th>
				<th field="REQ" width="30%" align="center">题目需求</th>
				<th field="TASK" width="30%" align="center">题目任务</th>
				<th id="teacherName" field="TNAME" width="10%" align="center">管理教师</th>
				<th id="titleID" field="CID" width="0%" hidden="true"></th>
				<th id="teacherID" field="TID" width="0%" hidden="true"></th>
				<th field="CSELECTED" width="10%" align="center">是否已选</th>
				<th field="opt" width="5%" align="center" formatter="optFormatter">操作</th>
			</tr>
		</thead>
	</table>
	
	<div id="tbTitle" style="padding:5px;height:auto">
		<div>
			<input id="searchTitleText" class="easyui-textbox" prompt="请输入题目名称" style="width:15%;height:25px;padding:12px"/>
			<a id="searchTitle" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTitle()">搜索</a>
			<a id="helpT" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#helpTitle').window('open')">帮助</a>
		</div>
	</div>
	
	<!-- 帮助内容 -->
	<div id="helpTitle" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据题目名称进行模糊查询。<br/>
		2.双击"项目需求"或"项目任务"单元格可查看对应具体内容。<br/>
		3.双击所选学生的姓名可直接对该学生进行评分。<br/>
		</b></h3>
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
		
		/* 操作按钮格式化 */  
		function optFormatter(value, row, index) {  
		    return [  
		            "<a href='javascript:;' onclick='selectTitle("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/select.png' title='选择'/>", 
		            "</a>",
		            "&nbsp;",
		            "&nbsp;",
		            "<a href='javascript:;' onclick='unSelectTitle("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/unSelect.png' title='取消选择'/>", 
		            "</a>"
		            ].join("");  
		}  
		
		/* 选择题目事件 */
		function selectTitle(index) {
			$.messager.confirm('选择提醒','您确定要选择该题目吗?',function(r){
				if (r) {
					var titleRows = $('#titleTable').datagrid('getRows');
					var cid = titleRows[index].CID;
					var tid = titleRows[index].TID;
					$.ajax({
						url:'/graduation/title/selectTitle?cid='+cid+'&tid='+tid,
						type:"get",
						dataType:"json",
						success:function(data){
							var info = eval(data);
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								//修改‘是否选择’列的值
								titleRows[index].CSELECTED = '是';
							}
							$('#titleTable').datagrid('refreshRow', index);  //进行刷新
							$.messager.alert('消息提示',msg,'info');
						}
					});
				}
			});
		}
		
		/* 取消选择题目事件 */
		function unSelectTitle(index) {
			$.messager.confirm('选择提醒','您确定要取消该题目吗?',function(r){
				if (r) {
					var titleRows = $('#titleTable').datagrid('getRows');
					var cid = titleRows[index].CID;
					var tid = titleRows[index].TID;
					$.ajax({
						url:'/graduation/title/unSelectTitle?cid='+cid+'&tid='+tid,
						type:"get",
						dataType:"json",
						success:function(data){
							var info = eval(data);
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								//修改‘是否选择’列的值
								titleRows[index].CSELECTED = '否';
							}
							$('#titleTable').datagrid('refreshRow', index);  //进行刷新
							$.messager.alert('消息提示',msg,'info');
						}
					});
				}
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