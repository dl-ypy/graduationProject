<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>我的信息</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(function(){
			load();
		});
		
		/* 初始化加载 */
		function load() {
			$.ajax({
				url:'/graduation/teacher/queryOneTeacher',
				type:"get",
				dataType:"json",
				success:function(data){
					var info = eval(data);
					var status = info.status;
					if (status != '0') {
						$.messager.alert('查询错误',info.msg,'warning');
					} else {
						$("#tid").textbox("setValue",info.data.tid);
						$("#tname").textbox("setValue",info.data.tname);
						$("#tphone").textbox("setValue",info.data.tphone);
					}
				}
			});
		}
		
		/* 手机号验证规则 */
		$.extend($.fn.validatebox.defaults.rules, {     
            phoneNum: { //验证手机号    
                validator: function(value, param){  
                 return /^1[3-8]+\d{9}$/.test(value);  
                },     
                message: '请输入正确的手机号码。'    
            } 
        }); 
		
		/* 保存修改 */
		function saveUpdate() {
			$('#baseInfoForm').form('submit',{
				url:'/graduation/teacher/updateTeacher',
				type: "POST",
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
				success:function(data){
					var info = eval('('+data+')'); //easyui需要用eval转换为json格式 
					var status = info.status;
					var msg = info.msg;
					if (status == '0') {
						$.messager.alert('修改提醒',msg,'info');
						//动态刷新欢迎界面的姓名
						$.ajax({
							url:'/graduation/teacher/queryTeacherUserName',
							type:"get",
							dataType:"json",
							success:function(data){
								var info = eval(data);
								var status = info.status;
								var msg = info.msg;
								if (status == '0') {
									$("#userSpan").text(msg);
								}
							}
						});
					} else {
						//如果不成功，则返回错误信息
						$.messager.alert('修改提醒',msg,'warning');
						load(); //重新加载
					}
				}
			});
		}
	</script>

	<div id="baseInfo" style="width:100%;height:100%;background: url('/graduation/images/baseInfo.jpg');">
		<form id="baseInfoForm" style="position:relative; left:40%; top:10%" class="easyui-form" method="post" data-options="novalidate:true">
	    	<table cellpadding="5" style="color:#CD8500">
	    		<tr>
	    			<td>编号:</td>
	    			<td><input class="easyui-textbox" id="tid" type="text" name="tid" readonly="readonly" data-options="required:true,missingMessage:'编号不能为空'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input class="easyui-textbox" id="tname" type="text" name="tname" data-options="required:true,missingMessage:'姓名不能为空'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td><input class="easyui-textbox" id="tphone" type="text" name="tphone" data-options="required:true,missingMessage:'手机号不能为空',validType:'phoneNum'"></input></td>
	    		</tr>
	    	</table>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveUpdate()">保存修改</a>
	    </form>
    </div>
</body>
</html>