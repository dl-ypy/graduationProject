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
				url: '/graduation/title/queryTitleByAdmin',
				fit:true,rownumbers:true,
				method:'get',toolbar:'#tbTitle',
				fitColumns:'true',
				singleSelect:'true',
				onDblClickCell:ClickCellTitle
			">
		<thead>
			<tr>
				<th field="CNAME" width="15%" align="center">题目名称</th>
				<th field="REQ" width="15%" align="center">题目需求</th>
				<th field="TASK" width="15%" align="center">题目任务</th>
				<th id="studentName" field="SNAME" width="10%" align="center">所选学生</th>
				<th id="teacherName" field="TNAME" width="10%" align="center">负责教师</th>
				<th id="titleID" field="CID" width="0%" hidden="true"></th>
				<th id="teacherID" field="TID" width="0%" hidden="true"></th>
				<th field="UPDATETIME" width="15%" align="center">最后修改时间</th>
				<th field="UPDATENAME" width="10%" align="center">修改人姓名</th>
				<th field="opt" width="10%" align="center" formatter="optFormatter">操作</th>
			</tr>
		</thead>
	</table>
	
	<div id="tbTitle" style="padding:5px;height:auto">
		<div>
			<input id="searchTitleText" class="easyui-textbox" prompt="请输入题目名称" style="width:15%;height:25px;padding:12px"/>&nbsp;&nbsp;&nbsp;&nbsp;
			题目是否已被选:<select id="searchTitleIsSelected" class="easyui-combobox" editable="false" name="isSelected" style="width:12%;" prompt="题目是否已被选" value="">
			    <option value="all">ALL</option>
			    <option value="是">是</option>
			    <option value="否">否</option>
			</select>
			<a id="searchTitle" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTitle()">搜索</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addTitle()"></a>
			<a id="helpT" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#helpTitle').window('open')">帮助</a>
		</div>
	</div>
	
	<!-- 帮助内容 -->
	<div id="helpTitle" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据题目名称进行模糊查询。<br/>
		2.下拉框可根据该题目是否被选进行查询。<br/>
		3.双击"项目需求"或"项目任务"单元格可查看对应具体内容，并对该内容进行编辑。<br/>
		4.点击加号按钮可以添加题目。<br/>
		</b></h3>
	</div>
	
	<div id="reqDlg" closed="true" class="easyui-dialog" title="题目需求" data-options="iconCls:'icon-save'" style="width:440px;height:250px;padding:10px">
		<form id="reqForm" method="post">
			<input class="easyui-textbox" id="reqCid" type="hidden" name="cid"></input>
			<input class="easyui-textbox" type="hidden" name="updateName" value="${user_name}"></input>
			<input class="easyui-textbox" data-options="required:true,missingMessage:'题目需求不能为空',multiline:true" id="reqText" name="require" style="width:350px;height: 180px"></input>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitReqForm()">确定</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearReqForm()">清空</a>
	    </form>
	</div>
	<div id="taskDlg" closed="true" class="easyui-dialog" title="题目任务" data-options="iconCls:'icon-save'" style="width:440px;height:250px;padding:10px">
		<form id="taskForm" method="post">
			<input class="easyui-textbox" id="taskCid" type="hidden" name="cid"></input>
			<input class="easyui-textbox" type="hidden" name="updateName" value="${user_name}"></input>
			<input class="easyui-textbox" data-options="required:true,missingMessage:'题目任务不能为空',multiline:true" id="taskText" name="task" style="width:350px;height: 180px"></input>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitTaskForm()">确定</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearTaskForm()">清空</a>
	    </form>
	</div>
	
	<!-- 添加题目模态框 -->
	<div id="addDlg" closed="true" class="easyui-dialog" title="添加题目" data-options="iconCls:'icon-add'" style="width:400px;height:400px;padding:10px">
		<form id="addForm" method="post">
			<table cellpadding="5">
				<input id="addUpdateName" class="easyui-textbox" type="hidden" name="updateName" value="${user_name}"></input>
	    		<tr>
	    			<td>题目名称:</td>
	    			<td><input class="easyui-textbox" id="cname" type="text" name="cname" data-options="required:true,missingMessage:'题目名称不能为空'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>题目需求:</td>
	    			<td><input class="easyui-textbox" data-options="required:true,missingMessage:'题目需求不能为空',multiline:true" id="require" name="require" style="width:200px;height: 100px"></input></td>
	    		</tr>
	    		<tr>
	    			<td>题目任务:</td>
	    			<td><input class="easyui-textbox" data-options="required:true,missingMessage:'题目任务不能为空',multiline:true" id="task" name="task" style="width:200px;height: 100px"></input></td>
	    		</tr>
	    		<tr>
	    			<td>负责教师:</td>
	    			<td>
	    				<input class="easyui-combobox" id="tidSelect" name="tid" style="width:80px" data-options="valueField:'id', textField:'text', panelHeight:'auto',required:true,missingMessage:'负责教师不能为空'" >
    				</td>
	    		</tr>
	    	</table>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddForm()">确定</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAddForm()">清空</a>
	    </form>
	</div>
	
	<script type="text/javascript">
		/* 按条件查询题目信息 */
		function searchTitle() {
			var text = $("#searchTitleText").val();
			var isSelected = $("#searchTitleIsSelected").val();
			$('#titleTable').datagrid({
				url:'/graduation/title/queryTitleByAdmin?text='+text+'&isSelected='+isSelected
			});
		}
		
		/* 操作按钮格式化 */  
		function optFormatter(value, row, index) {  
		    return [  
		            "<a href='javascript:;' onclick='deleteTitle("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/delete.png' title='删除'/>", 
		            "</a>"
		            ].join("");  
		}  
		
		function deleteTitle(index) {
			$.messager.confirm('删除提醒','您确定要删除此题目吗?',function(r){
				if (r) {
					var documentRows = $('#titleTable').datagrid('getRows');
					var cid = documentRows[index].CID;
					var tid = documentRows[index].TID;
					$.ajax({
						url:'/graduation/title/deleteTitle?cid='+cid+'&tid='+tid,
						type:"get",
						dataType:"json",
						success:function(data){
							var info = eval(data);
							var status = info.status;
							var msg = info.msg;
							var dataList = info.data;
							if (status == '0') {
								$('#titleTable').datagrid('reload');  //刷新表格数据
							} else {
								$.messager.alert('查询提醒',msg,'warning');
							}
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
				var cid = titleRows[index].CID;
				$('#reqCid').textbox("setValue",cid);
				$('#reqText').textbox("setValue",studentREQ);
				$('#reqDlg').dialog('open');
			} else if (field == "TASK") {
				var studentTASK = titleRows[index].TASK;
				var cid = titleRows[index].CID;
				$('#taskCid').textbox("setValue",cid);
				$('#taskText').textbox("setValue",studentTASK);
				$('#taskDlg').dialog('open');
			}
		}
		
		/* 点击确定修改事件 */
		function submitReqForm() {
			$.messager.confirm('修改提醒','您确定要修改吗?',function(r){
				if (r) {
					$('#reqForm').form('submit',{
						url:'/graduation/title/updateTitle',
						type: "POST",
						onSubmit:function(){
							return $(this).form('enableValidation').form('validate');
						},
						success:function(data){
							var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								$('#reqDlg').dialog('close');
								$('#titleTable').datagrid('reload');  //刷新表格数据
							} else {
								//如果不成功，则返回错误信息
								$.messager.alert('修改提醒',msg,'warning');
							}
						}
					});
				}
			});
		}
		
		function submitTaskForm() {
			$.messager.confirm('修改提醒','您确定要修改吗?',function(r){
				if (r) {
					$('#taskForm').form('submit',{
						url:'/graduation/title/updateTitle',
						type: "POST",
						onSubmit:function(){
							return $(this).form('enableValidation').form('validate');
						},
						success:function(data){
							var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								$('#taskDlg').dialog('close');
								$('#titleTable').datagrid('reload');  //刷新表格数据
							} else {
								//如果不成功，则返回错误信息
								$.messager.alert('修改提醒',msg,'warning');
							}
						}
					});
				}
			});
		}
		
		function submitAddForm() {
			$.messager.confirm('添加提醒','您确定要添加此条信息吗?',function(r){
				if (r) {
					$('#addForm').form('submit',{
						url:'/graduation/title/addTitle',
						type: "POST",
						onSubmit:function(){
							return $(this).form('enableValidation').form('validate');
						},
						success:function(data){
							var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								$('#addDlg').dialog('close');
								$("#tidSelect").combobox('loadData', {}); //添加成功后删除所有option
								$('#titleTable').datagrid('reload');  //刷新表格数据
							} else {
								//如果不成功，则返回错误信息
								$.messager.alert('添加提醒',msg,'warning');
							}
						}
					});
				}
			});
		}
		
		/* 清除事件 */
		function clearReqForm() {
			$('#reqForm').form('clear');
		}
		
		function clearTaskForm() {
			$('#taskForm').form('clear');
		}
		
		function clearAddForm() {
			$('#addForm').form('clear');
		}
		
		/* 添加题目时查询教师 */
		function addTitle() {
			clearAddForm(); //在添加之前先清空添加表单
			//先查询教师，并存入select中
			$.ajax({
				url:'/graduation/teacher/queryTeacher',
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					var msg = info.msg;
					var dataList = info.data;
					if (status == '0') {
						//先得到所有的option，防止多次点击添加会添加重复的option
						var optionArr = $('#tidSelect option');
						var selDom = $("#tidSelect");
						var teacherData = [];
						for (var i=0; i<dataList.length; i++) {
							/* for(var j=0;j<optionArr.length;j++){
					            if(optionArr[j].text==dataList[i].TNAME && optionArr[j].value==dataList[i].TID){
					            	return false;
					            }
					        } */
					        teacherData.push({ "text": dataList[i].TNAME, "id": dataList[i].TID});
						}
						selDom.combobox("loadData",teacherData);
					} else {
						$.messager.alert('查询提醒',msg,'warning');
					}
				}
			});
			$('#addUpdateName').textbox("setValue",'${user_name}');
			$('#addDlg').dialog('open');
		}
	</script>
</body>
</html>