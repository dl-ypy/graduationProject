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
			<input id="searchTitleText" class="easyui-textbox" prompt="请输入题目名称" style="width:15%;height:25px;padding:12px"/>&nbsp;&nbsp;&nbsp;&nbsp;
			题目是否已被选:<select id="searchTitleIsSelected" class="easyui-combobox" editable="false" name="isSelected" style="width:12%;" value="">
			    <option value="all">ALL</option>
			    <option value="是">是</option>
			    <option value="否">否</option>
			</select>
			<a id="searchTitle" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTitle()">搜索</a>
			<a id="myTitle" class="easyui-linkbutton" iconCls="icon-man" onclick="searchMyTitle(${user_student})">我的题目</a>
			<a id="helpT" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#helpTitle').window('open')">帮助</a>
		</div>
	</div>
	
	<!-- 帮助内容 -->
	<div id="helpTitle" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据题目名称进行模糊查询。<br/>
		2.下拉框可根据该题目是否被选进行查询。<br/>
		3.双击"项目需求"或"项目任务"单元格可查看对应具体内容。<br/>
		4.双击"管理教师"单元格可查看对应教师的基本信息。<br/>
		5.操作列中可进行选题与取消选题的操作。
		</b></h3>
	</div>
	
	<div id="reqDlg" closed="true" class="easyui-dialog" title="题目需求" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	<div id="taskDlg" closed="true" class="easyui-dialog" title="题目任务" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	<div id="teacherDlg" closed="true" class="easyui-dialog" title="教师信息" data-options="iconCls:'icon-save'" style="width:300px;height:150px;padding:10px">
		<form id="teacherForm" method="post">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>教师姓名:</td>
	    			<td><input id="tname" class="easyui-textbox" name="tname" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>教师电话:</td>
	    			<td><input id="tphone" class="easyui-textbox" name="tphone" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
	<script type="text/javascript">
		/* 按条件查询题目信息 */
		function searchTitle() {
			var text = $("#searchTitleText").val();
			var isSelected = $("#searchTitleIsSelected").val();
			$('#titleTable').datagrid({
				url:'/graduation/title/queryAllTitle?text='+text+'&isSelected='+isSelected
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
								$('#titleTable').datagrid('reload');  //刷新表格数据
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
								$('#titleTable').datagrid('reload');  //刷新表格数据
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
			if (field == "REQ") {
				var studentREQ = titleRows[index].REQ;
				$('#reqDlg').text(studentREQ);
				$('#reqDlg').dialog('open');
			} else if (field == "TASK") {
				var studentTASK = titleRows[index].TASK;
				$('#taskDlg').text(studentTASK);
				$('#taskDlg').dialog('open');
			} else if (field == "TNAME") {
				var teacherTid = titleRows[index].TID;
				$.ajax({
					url:'/graduation/teacher/queryOneTeacherByStu?tid='+teacherTid,
					type:"get",
					dataType:"json",
					success:function(data){
						var info = eval(data);
						var status = info.status;
						if (status == '0') {
							$("#tname").textbox("setValue", info.data.tname);
							$("#tphone").textbox("setValue", info.data.tphone);
						} else {
							$.messager.alert('消息提示',info.msg,'info');
						}
					}
				});
				$('#teacherDlg').dialog('open');
			}
		}
		
		//查询自己所选题目
		function searchMyTitle(sid) {
			$('#titleTable').datagrid({
				url:'/graduation/title/queryMyTitle?sid='+sid
			});
		}
	</script>
</body>
</html>