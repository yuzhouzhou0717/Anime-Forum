<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户注册</title>

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
                        <h2 class="mb-4">￣ω￣=注册</h2>

               
                        <c:if test="${not empty requestScope.error_msg}">
                            <div id="error-msg" class="error-message">${requestScope.error_msg}(▼ヘ▼#)</div>
                        </c:if>

                        <form action="RegisterServlet" method="post" class="mx-auto">
                                             <div class="form-floating mb-3">
    <input type="text" class="form-control" id="username" name="username" placeholder="用户名">
    <label for="username">用户名</label>
    <!-- 用户名格式提示 -->
    <small id="usernameHelp" class="form-text text-muted">用户名只能包含字母。</small>
</div>
<div class="form-floating mb-3">
    <input type="password" class="form-control" id="password" name="password" placeholder="密码">
    <label for="password">密码</label>
    <!-- 密码格式提示 -->
    <small id="passwordHelp" class="form-text text-muted">密码必须包含字母和数字，且长度不小于6位。</small>
</div>
<div class="form-floating mb-3">
    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="确认密码">
    <label for="confirmPassword">确认密码</label>
</div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">注册</button>
                                <a href="${pageContext.request.contextPath}/client/login.jsp" class="login-link btn btn-primary" style="color: white; text-decoration: none;"> 已有账号？登录</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


      <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/Snowfall.js"></script>  
</body>
</html>
