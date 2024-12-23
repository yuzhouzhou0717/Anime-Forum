<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>首页</title>
  <link type="text/css"
	href="${pageContext.request.contextPath}/static/css/good.css"
	rel="stylesheet" />
</head>

<body>
    <div class="main-container">
        <div class="div-1">
            <!-- Content of div-1 goes here -->
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    connection = DatabaseUtils.getConnection();
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery("SELECT * FROM anime ORDER BY id DESC LIMIT 6");

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String name = resultSet.getString("name");
                        String image = resultSet.getString("image_path");

                  
                        out.println("<div class='anime-card'>");
                       
                        out.println("<a href='/chapter04/client/animeDetails.jsp?id=" + id + "'>");
                        out.println("<img src='" + request.getContextPath() + "/" + image + "' alt='" + name + "'>");
                        out.println("</a>");
                        out.println("<small>" + name + "</small>");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    DatabaseUtils.closeConnection(connection, statement, resultSet);
                }
            %>
        </div>

        <div class="div-4">
            <div class="div-2">
              
                <h5>(≖ᴗ≖)✧热点动漫</h5>
                <div style="border:1px solid #CCC"></div>  

                <div class="ranking-container">
                    <%
                        connection = null;
                        statement = null;
                        resultSet = null;

                        try {
                            connection = DatabaseUtils.getConnection();
                            statement = connection.createStatement();
                            resultSet = statement.executeQuery("SELECT anime_id, COUNT(anime_id) AS comments_count " +
                                    "FROM comments GROUP BY anime_id ORDER BY comments_count DESC LIMIT 10");

                            int rank = 1;

                            while (resultSet.next()) {
                                int animeId = resultSet.getInt("anime_id");
                                int commentsCount = resultSet.getInt("comments_count");

                                Statement animeStatement = connection.createStatement();
                                ResultSet animeResultSet = animeStatement.executeQuery("SELECT * FROM anime WHERE id = " + animeId);

                                if (animeResultSet.next()) {
                                    String animeName = animeResultSet.getString("name");
                                    String animeImage = animeResultSet.getString("image_path");

                                    out.println("<div class='ranking-item'>");
                                    out.println("<div class='ranking-icon'>" + rank + "</div>");
                                    out.println("<div class='ranking-details'>");
                                    out.println("<a href='/chapter04/client/animeDetails.jsp?id=" + animeId + "'>" + animeName + "</a>");
                                   
                                    out.println("</div>");
                                    out.println("</div>");

                                    rank++;

                                    animeResultSet.close();
                                    animeStatement.close();
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            DatabaseUtils.closeConnection(connection, statement, resultSet);
                        }
                    %>
                </div>
            </div>
            <div class="div-3">
            
                <div class="sub-div">
                    <h5>(◕ᴗ◕✿)热门帖子</h5>
                    <div style="border:1px solid #CCC"></div>  
                     <div class="ranking-container">
                    <%
                        connection = null;
                        statement = null;
                        resultSet = null;

                        try {
                            connection = DatabaseUtils.getConnection();
                            statement = connection.createStatement();
                            resultSet = statement.executeQuery("SELECT post_id, COUNT(post_id) AS posts_count " +
                                    "FROM posts GROUP BY post_id ORDER BY post_id DESC LIMIT 10");

                            int rank = 1;

                            while (resultSet.next()) {
                                int postId = resultSet.getInt("post_id");
                                int commentsCount = resultSet.getInt("posts_count");

                        
                                Statement animeStatement = connection.createStatement();
                                ResultSet animeResultSet = animeStatement.executeQuery("SELECT * FROM posts WHERE post_id = " + postId);

                                if (animeResultSet.next()) {
                                    String text = animeResultSet.getString("post_text");
                                
                                    if (text.length() > 10) {
                                        text = text.substring(0, 10) + "..."; 
                                    }

                                    out.println("<div class='ranking-item'>");
                                    out.println("<div class='ranking-icon'>" + rank + "</div>");
                                    out.println("<div class='ranking-details'>");
                                    out.println("<a href='/chapter04/client/PostDetails.jsp?postId=" + postId + "'>" + text + "</a>");
                                   
                                    out.println("</div>");
                                    out.println("</div>");

                                    rank++;

                                    animeResultSet.close();
                                    animeStatement.close();
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            DatabaseUtils.closeConnection(connection, statement, resultSet);
                        }
                    %>
                </div>
                </div>
            </div>
        </div>
    </div><hr/>
</body>

</html>

