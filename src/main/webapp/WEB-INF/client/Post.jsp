<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
  <%@include file="head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子列表</title>
<link type="text/css" href="${pageContext.request.contextPath}/static/css/Post.css" rel="stylesheet" />
</head>
<body>
   
    <hr/>
    <div class="posts-container">
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                connection = DatabaseUtils.getConnection();
                statement = connection.createStatement();
                resultSet = statement.executeQuery("SELECT p.post_id, p.post_text, p.user_id, u.username, p.post_date FROM posts p JOIN user u ON p.user_id = u.uid");

                while (resultSet.next()) {
                    int post_id = resultSet.getInt("post_id");
                    int user_id = resultSet.getInt("user_id");
                    String post = resultSet.getString("post_text");
                    String username = resultSet.getString("username");
                    Timestamp timestamp = resultSet.getTimestamp("post_date");
                    LocalDateTime localDateTime = timestamp.toLocalDateTime();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String formattedTime = localDateTime.format(formatter);

  
                     out.println("<a href='PostDetails.jsp?postId=" + post_id + "'>");
                    out.println("<div class='post-card'>");
                    out.println("<p>" + post + "</p>");
                    out.println("<small>作者：" + username + "</small>");
                    out.println("<small>发帖时间: " + formattedTime + "</small>");
                    out.println("</div>");
                    out.println("</a>");
                    
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                DatabaseUtils.closeConnection(connection, statement, resultSet);
            }
        %>
    </div>
        <div class="post-form">    
        <form action="PostServlet" method="post">
            <textarea id="PostText" name="PostText" rows="4" required></textarea>
            <br>
            <input class="btn btn-primary" type="submit" value="发帖">
        </form>
    </div>
</body>
</html>

