<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>文档列表</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<table title="文档列表" id="documentTable" class="easyui-datagrid" style="width:700px;height:250px"
			data-options="
				url: '/graduation/document/queryDocument',
				fit:true,rownumbers:true,
				method:'get',toolbar:'#tbDocument',
				fitColumns:'true',
				singleSelect:'true',
				onDblClickCell:ClickCellDocument
			">
		<thead>
			<tr>
				<th field="ID" width="10%" align="center">文件编号</th>
				<th field="DNAME" width="20%" align="center">文件名称</th>
				<th field="CREATETIME" width="20%" align="center">上传时间</th>
				<th field="UPDATETIME" width="20%" align="center">修改时间</th>
				<th field="SNAME" width="10%" align="center">上传学生</th>
				<th field="SID" width="0%" align="center" hidden="true"></th>
				<th field="DPATH" width="0%" align="center" hidden="true"></th>
				<th field="opt" width="15%" align="center" formatter="optFormatter">操作</th>
			</tr>
		</thead>
	</table>
	
	<div id="tbDocument" style="padding:5px;height:auto">
		<div>
			<input id="searchDocumentText" class="easyui-textbox" prompt="请输入题目名称" style="width:15%;height:25px;padding:12px"/>
			<a id="searchTitle" class="easyui-linkbutton" iconCls="icon-search" onclick="searchDocument()">搜索</a>
			<a id="helpT" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#helpTitle').window('open')">帮助</a>
		</div>
	</div>
	
	<!-- 帮助内容 -->
	<div id="helpTitle" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据题目名称进行模糊查询。<br/>
		2.点击"项目需求"或"项目任务"单元格可查看对应具体内容。<br/>
		3.点击所选学生的姓名可直接对该学生进行评分。<br/>
		</b></h3>
	</div>
	
	<div id="reqDlg" closed="true" class="easyui-dialog" title="题目需求" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	<div id="taskDlg" closed="true" class="easyui-dialog" title="题目任务" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	
	<script type="text/javascript">
		/* 按条件查询题目信息 */
		function searchDocument() {
			var text = $("#searchDocumentText").val();
			$('#documentTable').datagrid({
				url:'/graduation/document/queryDocument?text='+text
			});
		}
		
		/* 点击行事件 */
		function ClickCellDocument(index, field) {
			var documentRows = $('#documentTable').datagrid('getRows');
			if (field == "SNAME") {
				//获取单元格的值
				var studentSID = documentRows[index].SID;  //得到学生学号
				window.open('/graduation/page/back/teacher/studentScoreTable.jsp?text='+studentSID); //打开新窗口
			} 
		}
		
		/* 操作按钮格式化 */  
		function optFormatter(value, row, index) {  
		    return [  
		            "<a href='javascript:;' onclick='downloadDocument("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/download.png' title='下载'/>", 
		            "</a>" 
		            ].join("");  
		}  
		
		/* 下载文档 */
		function downloadDocument(index) {
			var documentRows = $('#documentTable').datagrid('getRows');
			var dpath = documentRows[index].DPATH;
			/* $.ajax({
				url:'/graduation/document/downloadDocument?fileName='+dpath,
				type:"post",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					if (status != '0') {
						$.messager.alert('下载错误',info.msg,'warning');
					} else {
						alert('success');
					}
				}
			}); */
			
			//下载文件不能用ajax
			location.href = '/graduation/document/downloadDocument?dpath='+dpath
		}
	</script>
</body>
</html>