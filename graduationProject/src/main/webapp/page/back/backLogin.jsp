<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>毕业设计管理系统后台登录</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		.panel-htop {
			position:absolute;
			left:35%;
			top:30%
		}
	</style>
</head>
<body>
	<center><h2>用户登录</h2></center>
	<div style="margin:20px 0;"></div>
	<div class="easyui-panel" title="请登录" style="width:400px;">
		<div style="padding:10px 60px 20px 60px">
	    <form id="ff" class="easyui-form" method="post" data-options="novalidate:true">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>编号:</td>
	    			<td><input class="easyui-textbox" type="text" name="id" data-options="required:true,missingMessage:'编号不能为空'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" type="text" name="password" data-options="required:true,missingMessage:'密码不能为空',validType:'length[6,6]',invalidMessage:'密码长度为6位'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>身份:</td>
	    			<td>
	    				<select class="easyui-combobox" name="type" data-options="required:true,missingMessage:'请选择一种身份'">
	    					<option value="2">学生</option>
	    					<option value="1">教师</option>
	    					<option value="0">管理员</option>
	    				</select>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">登录</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
	    </div>
	    </div>
	</div>
	<script>
		function submitForm(){
			/* ajax提交，使用ajax是为了在登录页面弹出后台的错误信息 */
			$('#ff').form('submit',{
				url:'/graduation/whole/login',
				type: "POST",
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
				success:function(data){
					var info = eval('('+data+')'); //easyui需要用eval转换为json格式
					var status = info.status;
					var msg = info.msg;
					//如果成功，重新跳转到控制层
					if (status == '0') {
						var url = "/graduation/page/"+msg+".jsp";
						location.href=url;
					} else {
						//如果不成功，则返回错误信息
						alert(msg);
					}
				}
			});
		}
		function clearForm(){
			$('#ff').form('clear');
		}
	</script>
</body>
</html>