<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>我的文档</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body >
	<div style="">
		<img src='/graduation/images/file1.png' title='开题报告' style="display:none; margin-right: 20px; margin-left: 5px"/>
		<img src='/graduation/images/file2.png' title='中期检查' style="margin-right: 20px; margin-left: 5px"/>
		<img src='/graduation/images/file3.png' title='说明书' style="margin-right: 20px; margin-left: 5px"/>
		<img src='/graduation/images/file4.png' title='论文' style="margin-right: 20px; margin-left: 5px"/>
		<img src='/graduation/images/upload.png' title='上传'/>
	</div>
	
	<!-- 帮助内容 -->
	<div id="helpTitle" class="easyui-window" title="我来帮助您" data-options="modal:true,closed:true,iconCls:'icon-help'" style="width:500px;height:200px;padding:10px;">
		<h3><b>
		1.搜索框可根据题目名称进行模糊查询。<br/>
		2.下拉列表可根据是否审核通过进行查询。<br/>
		3.点击"修改意见"单元格可查看对应具体内容。<br/>
		4.点击所选学生的姓名可直接对该学生进行评分。<br/>
		5.点击"下载"图标可下载对应文件。<br/>
		6.点击"审核"图标可填写审核意见以及决定是否通过审核。<br/>
		7.更新提醒栏位中如果有小红旗，说明您的学生已经上传了新的文档。<br/>
		</b></h3>
	</div>
	
	<div id="agreeDlg" closed="true" class="easyui-dialog" title="审核意见" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	</div>
	
	<!-- 审核模态框 -->
	<div id="approveModal" closed="true" class="easyui-dialog" title="审核文档" data-options="iconCls:'icon-save'" style="width:300px;height:200px;padding:10px">
		<form id="approveForm" method="post">
			<input type="hidden" id="documentId" class="easyui-textbox" name="id"/>
	    	<table cellpadding="5">
	    		<tr>
	    			<td>修改意见:</td>
	    			<td><input id="agree" class="easyui-textbox" name="agree" data-options="multiline:true" style="height:60px"></input></td>
	    		</tr>
	    		<tr>
	    			<td>是否通过:</td>
	    			<td>
	    				<input type="radio" name="isApprove" value="是">是
	    				<input type="radio" name="isApprove" value="否">否
					</td>
	    		</tr>
	    	</table>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitApproveForm()">确定</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearApproveForm()">清空</a>
	    </form>
	</div>
	
	<script type="text/javascript">
		/* 页面初始化 */
		$(function(){
		});
		
		/* 按条件查询题目信息 */
		function searchDocument() {
			var text = $("#searchDocumentText").val();
			var isApprove = $("#searchIsApprove").val();
			alert(isApprove);
			$('#documentTable').datagrid({
				url:'/graduation/document/queryDocument?text='+text+'&isApprove='+isApprove
			});
		}
		
		/* 点击行事件 */
		function ClickCellDocument(index, field) {
			var documentRows = $('#documentTable').datagrid('getRows');
			if (field == "SNAME") {
				//获取单元格的值
				var studentSID = documentRows[index].SID;  //得到学生学号
				window.open('/graduation/page/back/teacher/studentScoreTable.jsp?text='+studentSID); //打开新窗口
			} else if (field == "AGREE") {
				var documentAGREE = documentRows[index].AGREE;
				$('#agreeDlg').text(documentAGREE);
				$('#agreeDlg').dialog('open');
			}
		}
		
		/* 消息列格式设置 */
		function msgFormatter(value, row, index) {
			if(row.ISHAVENEWMSG==1){  
		        return ["<img src='/graduation/images/newMsg.png' title='您的学生已经重新提交了文档'/>"];  
		    }else if(row.ISHAVENEWMSG==0){  
		        return "";  
		    }  
		}
		
		/* 操作按钮格式化 */  
		function optFormatter(value, row, index) {  
		    return [  
		            "<a href='javascript:;' onclick='downloadDocument("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/download.png' title='下载'/>", 
		            "</a>&nbsp;&nbsp;&nbsp;&nbsp;",
		            "<a href='javascript:;' onclick='approveDocument("+index+")' class='easyui-linkbutton'>",  
		            "<img src='/graduation/images/approve.png' title='审核'/>", 
		            "</a>"
		            ].join("");  
		}  
		
		/* 下载文档 */
		function downloadDocument(index) {
			var documentRows = $('#documentTable').datagrid('getRows');
			var dpath = documentRows[index].DPATH;
			var id = documentRows[index].ID;
			//下载文件不能用ajax
			location.href = '/graduation/document/downloadDocument?dpath='+dpath+'&id='+id;
		}
		
		/* 初始化加载模态框 */
		function loadModal(id) {
			$.ajax({
				url:'/graduation/document/queryOneDocument?id='+id,
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						$("#agree").textbox("setValue",info.data.agree);
						if (info.data.isApprove == "是") {
							$("input[name=isApprove]:eq(0)").attr("checked","checked");
						} else {
							$("input[name=isApprove]:eq(1)").attr("checked","checked");
						}
					}
				}
			});
		}
		
		/* 审核文档 */
		function approveDocument(index) {
			var documentRows = $('#documentTable').datagrid('getRows');
			var documentID = documentRows[index].ID;  //得到文档编号
			loadModal(documentID);
			$('#documentId').textbox("setValue", documentID);  //为模态框中的id设值
			$('#approveModal').dialog('open');
		}
		
		/* 提交审核 */
		function submitApproveForm(){
			$('#approveForm').form('submit',{
				url:'/graduation/document/approveDocument',
				type: "POST",
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
				success:function(data){
					var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
					var status = info.status;
					var msg = info.msg;
					if (status == '0') {
						$('#approveModal').dialog('close');//关闭模态框
						$('#documentTable').datagrid('reload');  //刷新表格数据
					} else {
						$.messager.alert('修改提醒',msg,'warning');
					}
				}
			});
		}
		
		/* 清空按钮事件 */
		function clearApproveForm(){
			$('#approveForm').form('clear');
		}
	</script>
</body>
</html>