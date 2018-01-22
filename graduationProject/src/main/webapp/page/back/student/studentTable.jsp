<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>列表</title>
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/graduation/easyui/demo/demo.css">
	<script type="text/javascript" src="/graduation/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="/graduation/easyui/jquery.easyui.min.js"></script>
</head>
<body>
	<h2>Custom Panel Tools</h2>
	<p>Click the right top buttons to perform actions with panel.</p>
	<div style="margin:20px 0 10px 0;"></div>
	<div class="easyui-panel" title="Custom Panel Tools" style="width:700px;height:200px;padding:10px;"
			data-options="iconCls:'icon-save',closable:true,tools:'#tt'">
		<p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
		<ul>
			<li>easyui is a collection of user-interface plugin based on jQuery.</li>
			<li>easyui provides essential functionality for building modem, interactive, javascript applications.</li>
			<li>using easyui you don't need to write many javascript code, you usually defines user-interface by writing some HTML markup.</li>
			<li>complete framework for HTML5 web page.</li>
			<li>easyui save your time and scales while developing your products.</li>
			<li>easyui is very easy but powerful.</li>
		</ul>
	</div>
	<div id="tt">
		<a href="javascript:void(0)" class="icon-add" onclick="javascript:alert('add')"></a>
		<a href="javascript:void(0)" class="icon-edit" onclick="javascript:alert('edit')"></a>
		<a href="javascript:void(0)" class="icon-cut" onclick="javascript:alert('cut')"></a>
		<a href="javascript:void(0)" class="icon-help" onclick="javascript:alert('help')"></a>
	</div>
</body>
</html>