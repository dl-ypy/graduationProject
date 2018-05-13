<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>修改密码</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		
		/* 保存修改 */
		function update() {
			$('#updatePassForm').form('submit',{
				url:'/graduation/teacher/updateTeacherPass',
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
					} else {
						//如果不成功，则返回错误信息
						$.messager.alert('修改提醒',msg,'warning');
					}
				}
			});
		}
		
		/* 确认没密码规则 */
		$.extend($.fn.validatebox.defaults.rules, {     
            isPass: {  
                validator: function(value, param){ 
                	var newPass = $("#newPass").val();
                	if (value === newPass) {
                		return true;
                	} else {
	                	return false;  
                	}
                },     
                message: '两次输入的密码不一致。'    
            } 
        }); 
	</script>

	<div id="updatePass" style="width:100%;height:100%;background: url('/graduation/images/password.jpg');">
		<form id="updatePassForm" style="position:relative; left:40%; top:25%" class="easyui-form" method="post" data-options="novalidate:true">
	    	<table cellpadding="5" style="color: #CD8500">
	    		<tr>
	    			<td>原密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="oldPassword" data-options="required:true,missingMessage:'原密码不能为空',validType:'length[6,6]',invalidMessage:'密码长度为6位'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>新密码:</td>
	    			<td><input class="easyui-textbox" id="newPass" type="password" name="password" data-options="required:true,missingMessage:'请输入新密码',validType:'length[6,6]',invalidMessage:'密码长度为6位'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>确认密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="tpassword" data-options="required:true,missingMessage:'请确认密码',validType:'isPass'"></input></td>
	    		</tr>
	    	</table>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="update()">确认修改</a>
	    </form>
    </div>
</body>
</html>