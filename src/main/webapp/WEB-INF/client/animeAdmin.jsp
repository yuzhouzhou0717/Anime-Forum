<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
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
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/animeAdmin.css"
	rel="stylesheet" />

<div>
<!-- 导入公共头部 -->
    <%@include file="adminHead.jsp"%>
    <h2>动漫管理</h2>
    <table>
        <tr>
            <th>动漫ID</th>
            <th>动漫名称</th>
            <th>动漫图片</th>
            <th>动漫简介</th>
            <th>动漫标签</th>
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
                    resultSet = statement.executeQuery("SELECT * FROM anime");

                    while (resultSet.next()) {
                        int animeId = resultSet.getInt("id");
                        String animeName = resultSet.getString("name");
                        String image_path = resultSet.getString("image_path");
                        String description = resultSet.getString("description");
                        String tags = resultSet.getString("tags");

      
                        out.println("<tr class='anime-info'>");
                        out.println("<td>" + animeId + "</td>");
                        out.println("<td>" + animeName + "</td>");
                        out.println("<td>" + image_path + "</td>");
                        out.println("<td>" + description + "</td>");
                        out.println("<td>" + tags + "</td>");
                   
                        out.println("<td><a class='btn btn-primary' onclick='showAnimeInfo(" + animeId + ")' href='javascript:void(0)'>展示</a> ");
                    
                        out.println("<a class='btn btn-danger' href='DeleteAnimeServlet?id=" + animeId + "'>删除</a></td>");
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

   
    <button id="addAnimeBtn" class="btn btn-primary" onclick="toggleAddAnimeForm()">增加动漫</button>

    <div class="add-anime-form">
        <h2>添加动漫</h2>
        <form action="AddAnimeServlet" method="post">
            <label for="animeName">动漫名称:</label>
            <input type="text" id="animeName" name="animeName" required><br>
            <label for="image_path">动漫图片:</label>
            <input type="text" id="image_path" name="image_path" required><br>
            <label for="description">动漫简介:</label>
            <input type="text" id="description" name="description" required><br>
            <label for="tags">动漫标签:</label>
            <input type="text" id="tags" name="tags" required><br>
            <!-- Add other fields for anime information as needed -->
            <input type="submit" value="添加动漫">
        </form>
    </div>
</div>
<script>
        function toggleAddAnimeForm() {
            var form = document.querySelector('.add-anime-form');
            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
        }
    </script>