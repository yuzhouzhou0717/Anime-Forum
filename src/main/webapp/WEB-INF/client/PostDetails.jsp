<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子详情</title>

    <link type="text/css" href="${pageContext.request.contextPath}/static/css/postDetails.css" rel="stylesheet" />

</head>
<body>
    <%@include file="head.jsp"%>
    <div>
    <a href="http://localhost:8080/chapter04/client/Post.jsp" class="btn btn-primary back-link">返回<i class="fa-solid fa-share"></i></a>
    </div>
    <div class="post-details">
        <%
            Connection connection = null;
            PreparedStatement postStatement = null;
            PreparedStatement commentStatement = null;
            ResultSet postResultSet = null;
            ResultSet commentResultSet = null;

            try {
                int postId = Integer.parseInt(request.getParameter("postId"));

                connection = DatabaseUtils.getConnection();

          
                postStatement = connection.prepareStatement("SELECT p.post_text, p.user_id, u.username, p.post_date FROM posts p JOIN user u ON p.user_id = u.uid WHERE p.post_id = ?");
                postStatement.setInt(1, postId);
                postResultSet = postStatement.executeQuery();

                if (postResultSet.next()) {
                    String postText = postResultSet.getString("post_text");
                    int userId = postResultSet.getInt("user_id");
                    String username = postResultSet.getString("username");
                    Timestamp postTimestamp = postResultSet.getTimestamp("post_date");
                    LocalDateTime postDateTime = postTimestamp.toLocalDateTime();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String formattedTime = postDateTime.format(formatter);

                 
                    out.println("<div class='post-detail'>");
                    out.println("<h2>" + postText + "</h2>");
                    out.println("<hr/>");
                    out.println("<p>作者: " + username + "</p>");
                    out.println("<p>发帖时间: " + formattedTime + "</p>");
                    %>
                       <button class="btn btn-primary"  onclick="toggleReplyForm('<%= postId %>')">回复</button>

                    <div id="reply-form-<%= postId %>" class="reply-form">
                        <form action="pCommentServlet" method="post">
                            <input type="hidden" name="post_id" value="<%= postId %>">
                            <textarea name="pcomment_text" rows="2" required></textarea>
                            <br>
                            <input type="submit" class="btn btn-primary" value="发表回复">
                        </form>
                    </div>
                  <% 
                    out.println("</div>");
                    

               
                    commentStatement = connection.prepareStatement("SELECT pc.pcomment_id, pc.user_id, pc.pcomment_text,pc.pcomment_date, u.username FROM pcomments pc JOIN user u ON pc.user_id = u.uid WHERE pc.post_id = ?");
                    commentStatement.setInt(1, postId);
                    commentResultSet = commentStatement.executeQuery();
                    int Counter = 1;
             
                    while (commentResultSet.next()) {
                        int commentId = commentResultSet.getInt("pcomment_id");
                        int commentUserId = commentResultSet.getInt("user_id");
                        String commentText = commentResultSet.getString("pcomment_text");
                        String commentUsername = commentResultSet.getString("username");
                        Timestamp commentTimestamp = commentResultSet.getTimestamp("pcomment_date");
                        LocalDateTime commentDateTime = commentTimestamp.toLocalDateTime();
                        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        String formattedTime1 = commentDateTime.format(formatter1);

                        out.println("<div class='comment'>");
                        out.println("<p>" + commentUsername + "说:</p>");
                        
                        out.println("<strong><p>" + commentText + "</p></strong>");
                        out.println("<hr/>");
                        out.println("<small>回复时间: " + formattedTime1 + "</small>");
                        out.println("<small>" + Counter + "楼</small>");
                     
                        out.println("</div>");
                        Counter++; 
                    }
                } else {
            
                    out.println("<p>No post found for the specified ID.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                DatabaseUtils.closeConnection(connection, postStatement, postResultSet);
                DatabaseUtils.closeStatement(commentStatement, commentResultSet);
            }
        %> 
    </div>
    <script>
    window.onload = function() {
        var replyForms = document.querySelectorAll(".reply-form");
        for (var i = 0; i < replyForms.length; i++) {
            replyForms[i].style.display = "none";
        }
    };

    function toggleReplyForm(commentId) {
        var replyForm = document.getElementById("reply-form-" + commentId);
        if (replyForm.style.display === "none" || replyForm.style.display === "") {
            replyForm.style.display = "block";
        } else {
            replyForm.style.display = "none";
        }
    }
    </script>
</body>
</html>

