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
    <title>后台管理</title>
    <link type="text/css" href="${pageContext.request.contextPath}/static/css/postAdmin.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 导入公共头部css脚本 -->
    <link type="text/css" href="${pageContext.request.contextPath}/static/css/head.css" rel="stylesheet" />
</head>
<body>
    <!-- 导入公共头部 -->
    <%@include file="adminHead.jsp"%>

    <div>
        <h2>帖子管理</h2>
        <table>
            <tr>
                <th>帖子ID</th>
                <th>用户ID</th>
                <th>帖子内容</th>
                <th>发帖时间</th>
            </tr>
            <tbody>
                <%
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        connection = DatabaseUtils.getConnection();
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery("SELECT * FROM posts");

                        while (resultSet.next()) {
                            int pid = resultSet.getInt("post_id");

                            int uid = resultSet.getInt("user_id");

                            String post_text = resultSet.getString("post_text");
                            String post_date = resultSet.getString("post_date");
                        


                            out.println("<tr class='user-info'>");
                            out.println("<td>" + pid + "</td>");
                           
                            out.println("<td>" + uid + "</td>");
                            out.println("<td>" + post_text + "</td>");
                            out.println("<td>" + post_date + "</td>");
                         
              
                            out.println("<td><a class='btn btn-primary' onclick='' href=''>展示</a> ");
                      
                            out.println("<a class='btn btn-danger' href='DeletePostServlet?pid=" + pid + "'>删除</a></td>");
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
  </div>