<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>天外来物动漫论坛</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 导入公共头部css脚本 -->
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/head.css"
	rel="stylesheet" />
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/index.jsp">天外来物动漫论坛</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/admin.jsp">用户管理</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/animeAdmin.jsp">动漫管理</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="${pageContext.request.contextPath}/client/commentAdmin.jsp"">评论管理</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/postAdmin.jsp">帖子管理</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/adminLogin.jsp">管理员登录</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/AdminLogoutServlet">退出</a>
					</li>
				</ul>
	

			</div>
		</div>
	</nav>
	<!-- 导入公共头部js脚本 -->
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/head.js"></script>
</body>
</html>
