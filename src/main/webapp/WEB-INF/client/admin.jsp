<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // 检查管理员是否已登录
    HttpSession adminSession = request.getSession();
    Boolean adminLoggedIn = (Boolean) adminSession.getAttribute("adminLoggedIn");

    // 如果管理员未登录，重定向到登录页面
    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/client/adminLogin.jsp");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/admin.css"
	rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 导入公共头部css脚本 -->
    <link type="text/css" href="${pageContext.request.contextPath}/static/css/head.css" rel="stylesheet" />
</head>
<body>
    <!-- 导入公共头部 -->
    <%@include file="adminHead.jsp"%>

    <div>
        <h2>用户管理</h2>
        <table>
            <tr>
                <th>用户ID</th>
                <th>用户名</th>
                <th>密码</th>
                <th>权限</th>
                <th>操作</th>
            </tr>
            <tbody>
                <%
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        connection = DatabaseUtils.getConnection();
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery("SELECT * FROM user");

                        while (resultSet.next()) {
                            int uid = resultSet.getInt("uid");
                            String username = resultSet.getString("username");
                            String pwd = resultSet.getString("pwd");
                            int key = resultSet.getInt("key");

                         
                            out.println("<tr class='user-info'>");
                            out.println("<td>" + uid + "</td>");
                            out.println("<td>" + username + "</td>");
                            out.println("<td>" + pwd + "</td>");
                            out.println("<td>" + key + "</td>");
                           
                            out.println("<td><a class='btn btn-primary' onclick='showUserInfo(" + uid + ")' href='javascript:void(0)'>展示</a> ");
            
                            out.println("<a class='btn btn-danger' href='DeleteUserServlet?uid=" + uid + "'>删除</a></td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        DatabaseUtils.closeConnection(connection, statement, resultSet);
                    }
                %>
            </tbody>
        </table>

        <!-- Add user button -->
        <button id="addUserBtn" class="btn btn-primary" onclick="toggleAddUserForm()">增加用户</button>

        <div style="display: flex; justify-content: space-between;">
            <div class="add-user-form">
                <h2>添加用户</h2>
                <form action="AddUserServlet" method="post">
                    <label for="username">用户名:</label>
                    <input type="text" id="username" name="username" required><br>
                    <label for="password">密码:</label>
                    <input type="password" id="password" name="password" required><br>
                    <label for="key">权限(0: 普通用户, 1: 管理员):</label>
                    <input type="key" id="key" name="key" required><br>
                    <input type="submit" value="添加用户">
                </form>
            </div>


            <div id="userInfoForm" class="add-user-form" style="margin-right: 650px;">
                <h2>用户信息</h2>
                <form id="userInfoDisplayForm" onclick="">
                    <label for="displayedUsername">用户名:</label>
                    <input type="text" id="displayedUsername" name="username" required><br>
                    <label for="displayedPassword">密码:</label>
                    <input type="text" id="displayedPassword" name="password" required><br>
                    <label for="displayedKey">权限:</label>
                    <input type="key" id="displayedKey" name="key" required><br>
                    <input type="submit" value="保存修改" onclick="saveUserInfo()">
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleAddUserForm() {
            var form = document.querySelector('.add-user-form');
            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
        }
    </script>
    <script>
        function showUserInfo(uid) {
      
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var userData = JSON.parse(xhr.responseText);
                    fillUserInfoForm(userData);
                }
            };
            xhr.open('GET', 'GetUserInfoServlet?uid=' + uid, true);
            xhr.send();
        }

        function fillUserInfoForm(userData) {
          
            document.getElementById('displayedUsername').value = userData.username;
            document.getElementById('displayedPassword').value = userData.pwd;
            document.getElementById('displayedKey').value = userData.key;

    
            var userInfoForm = document.getElementById('userInfoForm');
            userInfoForm.style.display = 'block';
        }
        function saveUserInfo() {
         
            var modifiedUsername = document.getElementById('displayedUsername').value;
            var modifiedPassword = document.getElementById('displayedPassword').value;
            var modifiedKey = document.getElementById('displayedKey').value;


            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                    
                        alert('用户信息已保存！');
                    } else {
                       
                        alert('保存失败，请重试。');
                    }
                }
            };
            xhr.open('POST', 'ModifyUserServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send('username=' + encodeURIComponent(modifiedUsername) +
                '&password=' + encodeURIComponent(modifiedPassword) +
                '&key=' + encodeURIComponent(modifiedKey));
        }
    </script>
</body>
</html>

