<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js">
</script>
    <meta charset="UTF-8">
    <title>动漫详情</title>
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/animeDetails.css"
	rel="stylesheet" />

</head>
<body class="main">
    <%@include file="head.jsp"%>
   <div class="container">
    <div class="anime-details">
        <div>
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
           
                    int animeId = Integer.parseInt(request.getParameter("id"));

                    connection = DatabaseUtils.getConnection();

                
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery("SELECT * FROM anime WHERE id = " + animeId);

                    if (resultSet != null && resultSet.next()) {
                        String image = resultSet.getString("image_path");
                        String name = resultSet.getString("name");

                        out.println("<img src='" + request.getContextPath() + "/" + image + "' alt='" + name + "'>");
                    } else {
                        out.println("<p>动漫不存在</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    DatabaseUtils.closeConnection(connection, statement, resultSet);
                }
            %>
        </div>
        <div class="anime-details-text">
            <%

            int animeId = Integer.parseInt(request.getParameter("id"));
                connection = DatabaseUtils.getConnection();

                statement = connection.createStatement();
                resultSet = statement.executeQuery("SELECT * FROM anime WHERE id = " + animeId);

                if (resultSet != null && resultSet.next()) {
                    String name = resultSet.getString("name");
           
                    String description = resultSet.getString("description");
                    String tags = resultSet.getString("tags");

                    out.println("<h2>" + name + "</h2>");
              
                    out.println("<p>简介: " + description + "</p>");
                    out.println("<p>标签: " + tags + "</p>");
                }
            %>
        </div>
        
    </div>
    <hr/>
     <div class="comment-section">
     <!-- 显示错误消息 -->
                        <c:if test="${not empty requestScope.error_msg}">
                            <div id="error-msg" class="error-message">${requestScope.error_msg}</div>
                        </c:if>
    <h3>(っ•̀ω•́)っ✎⁾⁾评论区</h3>
    <div>
 
        <%
    
            connection = DatabaseUtils.getConnection();

  
            statement = connection.createStatement();

            resultSet = statement.executeQuery("SELECT c.*, c.id AS comment_id, u.username FROM comments c JOIN user u ON c.user_id = u.uid WHERE anime_id = " + animeId);

            while (resultSet != null && resultSet.next()) {
                String username = resultSet.getString("username");
                String commentText = resultSet.getString("comment_text");
                Timestamp timestamp = resultSet.getTimestamp("created_at");
                LocalDateTime localDateTime = timestamp.toLocalDateTime();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String formattedTime = localDateTime.format(formatter);
                int commentId = resultSet.getInt("comment_id");
                int likes = resultSet.getInt("likes");
                System.out.println("commentId: " + commentId);
                System.out.println("animeId: " +animeId);
        %>
   <div class="card">
    <div class="card-header">
        <strong><%= username %></strong> 说:
    </div>
    <div class="card-body">
        <p class="card-text"><%= commentText %></p>
        <div class="d-flex justify-content-between align-items-center">
            <small class="text-muted">评论时间: <%= formattedTime %></small>
            <div>
                <span id="likes_<%= commentId %>" class="mr-2"><%= likes %></span>
                <button class="btn btn-outline-primary btn-sm" onclick="likeComment(<%= commentId %>)">
    <span class="fa-thumbs-up fas"></span> 点赞
</button>

            </div>
        </div>
    </div>
</div>


        <%
            }
        %>
    </div>
    <div>
        <div class="comment-form">
           
            <form action="CommentServlet" method="post">
                <input type="hidden" name="animeId" value="<%= animeId %>">
                <br>
 
                <textarea placeholder="请勿少于四个字！" id="commentText" name="commentText" rows="4" required></textarea>
                <br>
                <input class="btn btn-primary " type="submit" value="发表">
            </form>
        </div>
    </div>
</div>
</div>
<div class=""><button class="btn btn-primary fixed-button" onclick="scrollToBottomAndFocus()"><i class="fa-solid fa-pen-to-square"></i>发表评论</button></div>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/scroll.js"></script>


<script type="text/javascript">

function likeComment(commentId) {
  
    $.ajax({
        type: "POST",
        url: "/chapter04/client/LikeCommentServlet",
        data: { commentId: commentId },
        success: function(response) {
         
            console.log("Likes updated:", response);

    
            var likesElement = $("#likes_" + commentId);
            if (likesElement.length) {
                likesElement.text(response);
            }
        },
        error: function(error) {
            console.error("Ajax request failed:", error);
        }
    });
}

</script>

    
</body>
</html>