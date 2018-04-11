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
		<a href="#"><img id="fileImg1" src='/graduation/images/file1.png' title='开题报告' style="display:none; margin-right: 20px; margin-left: 5px" onclick="queryDocument('开题报告')"/></a>
		<a href="#"><img id="fileImg2" src='/graduation/images/file2.png' title='中期检查' style="display:none; margin-right: 20px; margin-left: 5px"  onclick="queryDocument('中期检查')"/></a>
		<a href="#"><img id="fileImg3" src='/graduation/images/file3.png' title='说明书' style="display:none; margin-right: 20px; margin-left: 5px"  onclick="queryDocument('说明书')"/></a>
		<a href="#"><img id="fileImg4" src='/graduation/images/file4.png' title='论文' style="display:none; margin-right: 20px; margin-left: 5px"  onclick="queryDocument('论文')"/></a>
		<a href="#" onclick="uploadClick()"><img src='/graduation/images/upload.png' title='上传'/></a>
		<form id="documentForm" method="post" enctype="multipart/form-data" style="display:none;">  
    		<input id="upload" name="file" type="file" onchange="fileUpload();"/>
    		<input id="studentId" name="sid" type="text" value="${user_student}" onchange="fileUpload();"/>
  		</form>  
	</div>
	
	<!-- 文档模态框 -->
	<div id="documentModal" closed="true" class="easyui-dialog" title="文档详情" data-options="iconCls:'icon-save'" style="width:350px;height:300px;padding:10px">
			<input type="hidden" id="documentId" class="easyui-textbox" name="id"/>
	    	<table cellpadding="5">
	    		<tr>
	    			<td>文档名称:</td>
	    			<td><input id="documentName" class="easyui-textbox" name="dname" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>审核教师:</td>
	    			<td><input id="teacherName" class="easyui-textbox" name="tname" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>审核时间:</td>
	    			<td><input id="approveTime" class="easyui-textbox" name="approveTime" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>审核是否通过:</td>
	    			<td><input id="isApprove" class="easyui-textbox" name="isApprove" data-options="multiline:true" style="height:30px" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>修改建议:</td>
	    			<td><input id="agree" class="easyui-textbox" name="agree" data-options="multiline:true" style="height:60px" readonly="readonly"></input></td>
	    		</tr>
	    	</table>
	</div>
	
	<script type="text/javascript">
		/* 页面初始化 */
		$(function(){
			load();
		});
		
		/* 初始化页面加载 */
		function load() {
			$.ajax({
				url:'/graduation/document/queryDocumentBySid',
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					var documentData = info.data;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						var reg1 = /开题报告$/;
						var reg2 = /中期检查$/;
						var reg3 = /说明书$/;
						var reg4 = /论文$/;
						//判断是否显示图片
						for (var i=0; i<documentData.length; i++) {
							if (reg1.test(documentData[i].DNAME)) {
								$('#fileImg1').show();
							} else if (reg2.test(documentData[i].DNAME)) {
								$('#fileImg2').show();
							} else if (reg3.test(documentData[i].DNAME)) {
								$('#fileImg3').show();
							} else if (reg4.test(documentData[i].DNAME)) {
								$('#fileImg4').show();
							}
						}
					}
				}
			});
		}
		
		//点击图片弹出选择文件框
		function uploadClick() {
			$('#upload').click();  
		}
		
		//文件上传
		function fileUpload() {
			$.messager.confirm('上传提醒','您确定要上传此文件?',function(r){
				if (r) {
					$('#documentForm').form('submit',{
						url:'/graduation/document/uploadDocument',
						type: "POST",
						onSubmit:function(){
							return $(this).form('enableValidation').form('validate');
						},
						success:function(data){
							var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
							var status = info.status;
							var msg = info.msg;
							if (status == '0') {
								load(); //重新加载
							} else {
								$.messager.alert('上传提醒',msg,'warning');
							}
						}
					});
				}
			});
		}
		
		/* 查询文档详细内容，并弹出模态框 */
		function queryDocument(dname) {
			$.ajax({
				url:'/graduation/document/queryOneDocumentBySidAndDname?dname='+dname,
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					var documentData = info.data;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						$('#documentName').textbox("setValue", documentData.DNAME);
						$('#teacherName').textbox("setValue", documentData.TNAME);
						$('#approveTime').textbox("setValue", documentData.APPROVETIME);
						$('#isApprove').textbox("setValue", documentData.ISAPPROVE);
						$('#agree').textbox("setValue", documentData.AGREE);
						$('#documentModal').dialog('open');
					}
				}
			});
		}
	</script>
</body>
</html>