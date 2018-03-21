<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>学生控制平台</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
	</style>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			
			/* 个人信息管理Tree的点击事件 */
			$('#teacher_persnol').tree({
				onClick: function(node){
					if ('基本信息' == node.text) {
						addTab(node.text,'/graduation/student/queryStudent');
					} else {
					}
				}
			});
			
			/* 学生信息管理Tree的点击事件 */
			$('#student_manage').tree({
				onClick: function(node){
					if ($('#tabs').tabs('exists',node.text)) { //判断该选项卡是否打开
						$('#tabs').tabs('select',node.text);   //如果已打开  选中
					} else {
						if ('学生基本信息' == node.text) { /* 获取列的信息并进行比较 */
							addTab(node.text,'/graduation/page/back/teacher/studentTable.jsp');
						} else if ('学生成绩' == node.text) {
							addTab(node.text,'/graduation/page/back/teacher/studentScoreTable.jsp');
						}
					}
				}
			});
			
	    });
		
		/* 添加tab */
		function addTab(subtitle,url) {
			$("#tabs").tabs("add", {
				title:subtitle,
				closable:true,
				href:url
			});
		}
		
		/* 注销 */
		function logout() {
			$.messager.confirm('退出提醒','您确定要退出?',function(r){
				if (r) {
					$.ajax({
						url:'/graduation/whole/logout',
						type:"get",
						dataType:"json",
						success:function(data){
							var info = eval(data);
							var status = info.status;
							var msg = info.msg;
							if (status != '0') {
								$.messager.alert('注销警告',msg,'warning');
							} else {
								location.href="/graduation/page/"+msg+".jsp";
							}
						}
					});
				}
			});
		}
		
	</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden">

    <div region="north" border="false" style="overflow: hidden; height: 60px;
        background: url(/graduation/images/bg_header_2.jpg) #7f99be repeat-x center 50%;
        line-height: 20px; font-family: Verdana, 微软雅黑,黑体;">
        <span style="float:right; padding-right:50px; padding-top:40px;font-size:medium" class="head">${empty user_name?'请<a href="../backLogin.jsp" id="login" style="line-height: 20px; color:#A0522D; font-weight:bold; font-family: Verdana, 微软雅黑,黑体; text-decoration : none">登录</a>':'欢迎'}<span id="userSpan">${empty user_name?'':user_name}</span> | <a onclick="logout()" href="#" id="loginOut" style="line-height: 20px; color:#A0522D; font-family: Verdana, 微软雅黑,黑体; font-weight:bold; text-decoration : none">安全退出</a></span>
        <span style="padding-left:10px; font-size:20px; color: #FFF;">学生控制平台</span>
    </div>
	
	</div>
    <div data-options="region:'south',title:'底部'" style="height:100px;">
    	
    </div>
    <div data-options="region:'east',title:'East'" style="width:100px;">
    
    </div>
    <div region="west" hide="true" title="导航菜单" style="width:200px;" id="left">
    	<div id="meun_accordion" class="easyui-accordion" fit="true">
		    <div title="个人信息管理" data-options="selected:true" style="overflow:auto;padding:10px;">
				<ul id="teacher_persnol" class="easyui-tree">
				    <li id="teacher_persnol_base">
						<span>基本信息</span>
					</li>
				    <li>
				    	<span>修改密码</span>
				    </li>
				</ul>
		    </div>
		    <div title="题目管理">
				<ul id="document_manage" class="easyui-tree">
				    <li>
						<span>题目列表</span>
					</li>
				</ul>
		    </div>
		    <div title="学生管理" style="padding:10px;">
				<ul id="student_manage" class="easyui-tabs">
					<li>
						<span>学生基本信息</span>
					</li>
				    <li>
						<span>学生成绩</span>
					</li>
				</ul>
		    </div>
		    <div title="文档管理">
				<ul id="document_manage" class="easyui-tree">
				    <li>
						<span>文档列表</span>
					</li>
				</ul>
		    </div>
		</div>
    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			
		</div>
    </div>
</body>
</html>