<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>天外来物动漫论坛</title>
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/allAnime.css"
	rel="stylesheet" />
</head>
<body>
<%@include file="head.jsp"%>

    <div class="anime-container ">
        <% 
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
               
            	connection = DatabaseUtils.getConnection();


                statement = connection.createStatement();
                resultSet = statement.executeQuery("SELECT * FROM anime");

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    String image = resultSet.getString("image_path");

               
                    out.println("<div class='anime-card'>");
   
                    out.println("<a href='animeDetails.jsp?id=" + id + "'>");
                    out.println("<img src='" + request.getContextPath() + "/" + image + "' alt='" + name + "'>");
                    out.println("</a>");
                    out.println("<small>" + name + "</small>");
                    out.println("</div>");
                }
            }catch (Exception e) {
                e.printStackTrace();
            } finally {
            	 DatabaseUtils.closeConnection(connection, statement, resultSet);
            }
            
        %>
    </div>
</body>
</html>
