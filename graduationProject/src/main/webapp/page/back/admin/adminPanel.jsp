<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>教师控制平台</title>
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
					if ('学生基本信息' == node.text) {
						addTab(node.text,'/graduation/page/back/admin/studentTable.jsp');
					} else {
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
		
	</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden">

    <div region="north" border="false" style="overflow: hidden; height: 50px;
        background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float:right; padding-right:20px;" class="head">欢迎 ypy <a href="#" id="loginOut">安全退出</a></span>
        <span style="padding-left:10px; font-size: 16px; "><img src="images/blocks.gif" width="20" height="20" align="absmiddle" />教师控制平台</span>
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
				<ul id="student_manage" class="easyui-tree">
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