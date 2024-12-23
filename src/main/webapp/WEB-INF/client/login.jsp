<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/login.js"></script>
    
</head>
<body class="main">

    <%@include file="head.jsp"%>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-center">
                        <h2 class="mb-4">登录</h2>

                        <!-- 显示错误消息 -->
                        <c:if test="${not empty requestScope.error_msg}">
                            <div id="error-msg" class="error-message">${requestScope.error_msg}(｀⌒´メ)</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/client/LoginServlet" method="post" class="mx-auto">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                                <label for="username">用户名</label>
                            </div>
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                <label for="password">密码</label>
                            </div>
                            &nbsp;
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">登录</button>
                                <a href="" class="btn btn-primary">忘记密码</a>
                            </div>
                            &nbsp;
                            <div>
                                <a href="${pageContext.request.contextPath}/client/register.jsp" class="register-link btn btn-primary"
                                    style="color: white; text-decoration: none;">还没有账号？注册</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
