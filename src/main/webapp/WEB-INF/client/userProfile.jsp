<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.dao.UserDao" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/dbb0ce4fd7.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <title>个人页面</title>
    <style>       
        .card {
            margin-bottom: 15px;
        }
    </style>
</head>
<body class="main">
<%@include file="head.jsp"%>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="mb-4">我的信息：</h4>
                    <div class="mb-3 text-center">
                        <label for="" class="form-label mb-0">用户名：</label>
                        ${sessionScope.username}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;
                    </div>
                </div>
                <div class="mb-3 text-center">
                    
                         <button class="btn btn-primary" onclick="showEdit1Form()">修改密码</button>
                         <form id="updatePasswordForm" style="display: none;">
    <label for="oldPassword">旧密码：</label>
    <input type="password" id="oldPassword" name="oldPassword"><br><br>
    <label for="newPassword">新密码：</label>
    <input type="password" id="newPassword" name="newPassword"><br><br>
    <button type="submit" class="btn btn-primary" onclick="updatePassword()">保存</button>
</form>
                         
                    &nbsp;&nbsp;&nbsp;
                    <button class="btn btn-primary" onclick="showEditForm()">编辑个人信息</button>

<div id="editForm" style="display: none;">
    <form id="updateForm">
        <label for="newUsername">新用户名：</label>
        <input type="text" id="newUsername" name="newUsername">
        <button type="submit" class="btn btn-primary" onclick="updateUsername()">保存</button>
    </form>
</div>
                    &nbsp;&nbsp;&nbsp;
                   
                        <a class="register-link btn btn-primary" style="color: white; text-decoration: none;"
                           href="${pageContext.request.contextPath}/client/LogoutServlet"><i class="fa-solid fa-right-to-bracket"></i>退出登录</a>
&nbsp;&nbsp;&nbsp;<hr/>
                    <button class="btn btn-primary" onclick="toggleContent('commentDiv')">
<i class="fa-regular fa-comments"></i>我的评价
                    </button>
                     <button class="btn btn-primary" onclick="toggleContent('postDiv')">
                        <i class="fa-regular fa-inbox"></i>我的帖子
                    </button>
                    <button class="btn btn-primary" onclick="toggleContent('pcommentDiv')">
                      <i class="fa-regular fa-comment"></i>我的回复
                    </button>
                </div>
            </div>
            <div class="anime-details" style="display: none;">
                <div>
                    <%
                      
                        int userId = (int) session.getAttribute("uid");

                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;

                        try {
                            connection = DatabaseUtils.getConnection();
                            statement = connection.createStatement();

                      
                            resultSet = statement.executeQuery("SELECT c.anime_id ,c.id AS commentId, c.comment_text, a.name AS anime_name, c.created_at " +
                                    "FROM comments c INNER JOIN anime a ON c.anime_id = a.id " +
                                    "WHERE c.user_id = " + userId);

                            while (resultSet.next()) {
                              	 int animeId = resultSet.getInt("anime_id");
                              	 int commentId = resultSet.getInt("commentId");
                                 String commentContent = resultSet.getString("comment_text");
                                 String animeName = resultSet.getString("anime_name");
                                 Timestamp commentTime = resultSet.getTimestamp("created_at");

                   
                                 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                 String formattedTime = sdf.format(commentTime);

                       
          
                                  out.println("<div class='card com'>");
                                  out.println("<div class='card card-body'>");
                                   out.println("<a style='color: black; text-decoration: none;' href='/chapter04/client/animeDetails.jsp?id=" + animeId + "'>");
                                  out.println("<p class='card-text'>" + "评论内容："+ commentContent +"</p>");
                                  out.println("<p class='card-text'>" + animeName +"</p>");
                                   out.println("<p class='card-text'>" + formattedTime +"</p>");
                                   out.println("<hr/>");
                                     out.println("</a>");
                       
                                     out.println("<form onsubmit=\"return confirm('确认删除评论吗？')\" action='UserDeleteCommentServlet' method='post'>");
                                     out.println("<input type='hidden' name='commentId' value='" + commentId + "'>");
                                     out.println("<input type='submit' class='btn btn-primary' value='删除评论'>");
                                     out.println("</form>");
                                     out.println("</div>");
                                    
                                     out.println("</div>");
                                    
                   
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            DatabaseUtils.closeConnection(connection, statement, resultSet);
                        }
                    %>
                </div>
            </div>
            <div class="post-details" style="display: none;">
                <div>
                    <%
                      
                        int userId1 = (int) session.getAttribute("uid");

                        Connection connection1 = null;
                        Statement statement1 = null;
                        ResultSet resultSet1 = null;

                        try {
                            connection1 = DatabaseUtils.getConnection();
                            statement1 = connection1.createStatement();

                    
                            resultSet1 = statement1.executeQuery("SELECT * FROM posts WHERE user_id = " + userId1);

                            while (resultSet1.next()) {
                              	 int postId = resultSet1.getInt("post_id");
                          
                                 String postContent = resultSet1.getString("post_text");
                               
                                 Timestamp commentTime1 = resultSet1.getTimestamp("post_date");

                        
                                 SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                 String formattedTime1 = sdf1.format(commentTime1);

                          
          
                                  out.println("<div class='card com'>");
                                  out.println("<div class='card card-body'>");
                                   out.println("<a style='color: black; text-decoration: none;' href='/chapter04/client/PostDetails.jsp?postId=" + postId + "'>");
                                  out.println("<p class='card-text'>" + "帖子内容："+ postContent +"</p>");
                           
                                   out.println("<p class='card-text'>" + formattedTime1 +"</p>");
                                   out.println("<hr/>");
                                     out.println("</a>");
                                
                                     out.println("<form onsubmit=\"return confirm('确认删除帖子吗？')\" action='UserDeletePostServlet' method='post'>");
                                     out.println("<input type='hidden' name='postId' value='" + postId + "'>");
                                     out.println("<input type='submit' class='btn btn-primary' value='删除评论'>");
                                     out.println("</form>");
                                     out.println("</div>");
                                    
                                     out.println("</div>");
                                    
                   
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            DatabaseUtils.closeConnection(connection1, statement1, resultSet1);
                        }
                    %>
                </div>
            </div>
            <div class="pco-details" style="display: none;">
                <div>
                    <%
                    
                        int userId2 = (int) session.getAttribute("uid");

                        Connection connection2 = null;
                        Statement statement2 = null;
                        ResultSet resultSet2 = null;

                        try {
                            connection2 = DatabaseUtils.getConnection();
                            statement2 = connection2.createStatement();

                          
                           resultSet2 = statement2.executeQuery(
    "SELECT p.*, pc.* FROM posts p " +
    "INNER JOIN pcomments pc ON p.post_id = pc.post_id " +
    "WHERE pc.user_id = " + userId2
);

                            while (resultSet2.next()) {
                              	 int pcommentId = resultSet2.getInt("pcomment_id");
                              	 int postId = resultSet2.getInt("post_id");
                              	 String post = resultSet2.getString("post_text");
                                 String pcommentContent = resultSet2.getString("pcomment_text");
                               
                                 Timestamp commentTime2 = resultSet2.getTimestamp("pcomment_date");

                           
                                 SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                 String formattedTime2 = sdf2.format(commentTime2);

                           
          
                                  out.println("<div class='card com'>");
                                  out.println("<div class='card card-body'>");
                                   out.println("<a style='color: black; text-decoration: none;' href='/chapter04/client/PostDetails.jsp?postId=" + postId + "'>");
                                   out.println("<p class='card-text'>" + "回复帖子："+ post +"</p>");
                                  out.println("<p class='card-text'>" + "回复内容："+ pcommentContent +"</p>");
                           
                                   out.println("<p class='card-text'>" + formattedTime2 +"</p>");
                                   out.println("<hr/>");
                                     out.println("</a>");
                                     
                                     out.println("<form onsubmit=\"return confirm('确认删除回复吗？')\" action='UserDeletePcommentServlet' method='post'>");
                                     out.println("<input type='hidden' name='pcommentId' value='" + pcommentId + "'>");
                                     out.println("<input type='submit' class='btn btn-primary' value='删除回复'>");
                                     out.println("</form>");
                                     out.println("</div>");
                                    
                                     out.println("</div>");
                                    
                   
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            DatabaseUtils.closeConnection(connection2, statement2, resultSet2);
                        }
                    %>
                </div>
            </div>
            
        </div>
    </div>
</div>
<script>
function toggleContent(selectedDiv) {
    var commentDiv = document.querySelector('.anime-details');
    var postDiv = document.querySelector('.post-details');
    var pcommentDiv = document.querySelector('.pco-details');

    if (selectedDiv === 'commentDiv') {
        commentDiv.style.display = (commentDiv.style.display === 'none' || commentDiv.style.display === '') ? 'block' : 'none';
        postDiv.style.display = 'none';
        pcommentDiv.style.display = 'none';
    } else if (selectedDiv === 'postDiv') {
        postDiv.style.display = (postDiv.style.display === 'none' || postDiv.style.display === '') ? 'block' : 'none';
        commentDiv.style.display = 'none';
        pcommentDiv.style.display = 'none';
    } else if (selectedDiv === 'pcommentDiv') {
        pcommentDiv.style.display = (pcommentDiv.style.display === 'none' || pcommentDiv.style.display === '') ? 'block' : 'none';
        commentDiv.style.display = 'none';
        postDiv.style.display = 'none';
    }
}
function showEdit1Form() {
    var updatePasswordForm = document.getElementById("updatePasswordForm");
    if (updatePasswordForm.style.display === 'none' || updatePasswordForm.style.display === '') {
    	updatePasswordForm.style.display = 'block';
    } else {
    	updatePasswordForm.style.display = 'none';
    }
}
function updatePassword() {
    var oldPassword = document.getElementById("oldPassword").value;
    var newPassword = document.getElementById("newPassword").value;

    var xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = xhr.responseText;
                if (response === 'success') {
                    alert("密码已更新！请重新登录");
                } else {
                    alert("原密码错误！");
                }
            } else {
            	alert("密码错误！！");
            }
        }
    };
    
    xhr.open("POST", "/chapter04/client/UpdatePwdServlet", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("oldPassword=" + oldPassword + "&newPassword=" + newPassword);
}
function showEditForm() {
    var editForm = document.getElementById("editForm");
    if (editForm.style.display === 'none' || editForm.style.display === '') {
        editForm.style.display = 'block';
    } else {
        editForm.style.display = 'none';
    }
}

document.getElementById("updateForm").addEventListener("submit", function(event) {
    event.preventDefault(); 
    updateUsername();
});
function updateUsername() {
    var newUsername = document.getElementById("newUsername").value; 

    var xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
             
                var response = xhr.responseText;
                if (response === 'success') {
                 
                    alert("用户名已更新！");
                } else {
             
                    alert("用户名已更新，请重新登录！");
                }
            } else {
              
               
            }
        }
    };
    
    xhr.open("POST", "/chapter04/client/UpdateUserServlet", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("newUsername=" + newUsername);
}

    </script>
</body>
</html>
