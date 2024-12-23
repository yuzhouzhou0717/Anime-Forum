<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%
 
    HttpSession adminSession = request.getSession();
    Boolean adminLoggedIn = (Boolean) adminSession.getAttribute("adminLoggedIn");

 
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
	href="${pageContext.request.contextPath}/static/css/commentAdmin.css"
	rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 导入公共头部css脚本 -->
    <link type="text/css" href="${pageContext.request.contextPath}/static/css/head.css" rel="stylesheet" />
</head>
<body>
    <!-- 导入公共头部 -->
    <%@include file="adminHead.jsp"%>

    <div>
        <h2>评论管理</h2>
        <table>
            <tr>
                <th>评论ID</th>
                 <th>动漫ID</th>
                <th>用户ID</th>
                <th>评论内容</th>
                <th>评论时间</th>
            </tr>
            <tbody>
                <%
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        connection = DatabaseUtils.getConnection();
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery("SELECT * FROM comments");

                        while (resultSet.next()) {
                            int cid = resultSet.getInt("id");
                            int aid = resultSet.getInt("anime_id");
                            int uid = resultSet.getInt("user_id");

                            String comment_text = resultSet.getString("comment_text");
                            String created_at = resultSet.getString("created_at");
                        

                       
                            out.println("<tr class='user-info'>");
                            out.println("<td>" + cid + "</td>");
                            out.println("<td>" + aid + "</td>");
                            out.println("<td>" + uid + "</td>");
                            out.println("<td>" + comment_text + "</td>");
                            out.println("<td>" + created_at + "</td>");
                         
                
                            out.println("<td><a class='btn btn-primary' onclick='' href=''>展示</a> ");

                            out.println("<a class='btn btn-danger' href='DeleteCommentServlet?cid=" + cid + "'>删除</a></td>");
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