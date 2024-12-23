<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>天外来物动漫论坛</title>
<script src="https://kit.fontawesome.com/dbb0ce4fd7.js" crossorigin="anonymous"></script>
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
						href="${pageContext.request.contextPath}/index.jsp">论坛</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/allAnime.jsp">版块</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="${pageContext.request.contextPath}/client/Post.jsp">讨论</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/client/login.jsp">登录/注册</a>
					</li>
					&nbsp;&nbsp;&nbsp;
					<li class="nav-item"><i class="fa-solid fa-user"><a
						href="${pageContext.request.contextPath}/client/userProfile.jsp"
						class="nav-link active" aria-current="page">${sessionScope.username}</a></i>
					</li>
					
				</ul>

<form class="d-flex" role="search" action="${pageContext.request.contextPath}/client/SearchAnime.jsp" method="GET">
    <input class="form-control me-2 search-form" type="search" name="searchTerm" placeholder="输入搜索词" aria-label="Search">
    <button class="btn btn-outline-success" type="submit">搜索</button>
</form>
			</div>
		</div>
	</nav>
	<!-- 导入公共头部js脚本 -->
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/head.js"></script>
</body>
</html>
