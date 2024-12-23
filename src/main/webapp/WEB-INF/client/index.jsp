<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>天外来物动漫论坛</title>
<!-- 导入主css脚本 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/main.css"
	type="text/css" />
<!-- 导入首页轮播图css和js脚本 -->
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/autoplay.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/autoplay.js"></script>
</head>
<body class="main">
	<!-- 导入公共头部 -->
	<%@include file="head.jsp"%>


	<!-- 网站首页轮播图 start -->
	<div id="box_autoplay">
		<div class="list">
			<ul>
				<li><img
					src="${pageContext.request.contextPath}/static/images/1.png"
					width="600" height="270" /></li>
				<li><img
					src="${pageContext.request.contextPath}/static/images/2.png"
					width="600" height="270" /></li>
				<li><img
					src="${pageContext.request.contextPath}/static/images/3.png"
					width="600" height="270" /></li>
				<li><img
					src="${pageContext.request.contextPath}/static/images/4.png"
					width="600" height="270" /></li>
				<li><img
					src="${pageContext.request.contextPath}/static/images/5.png"
					width="600" height="270" /></li>
			</ul>
		</div>
	</div>
	<hr />
	<!-- 主内容 -->
	<%@include file="good.jsp"%>
	<!-- 导入首页轮播图css和js脚本 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/autoplay.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/Snowfall.js"></script>
		
</body>
</html>