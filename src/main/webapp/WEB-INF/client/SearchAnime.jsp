<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DatabaseUtils" %>
<!DOCTYPE html>
<html>
<head>
<link type="text/css"
	href="${pageContext.request.contextPath}/static/css/allAnime.css"
	rel="stylesheet" />
<meta charset="UTF-8">
<title>动漫列表</title>
</head>
<body>
<%@include file="head.jsp"%>

    <div class="anime-container ">
        <% 
String searchString = request.getParameter("searchTerm");

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

try {
    connection = DatabaseUtils.getConnection();
    String query = "SELECT * FROM anime WHERE name LIKE ?";
    preparedStatement = connection.prepareStatement(query);
    

    preparedStatement.setString(1, "%" + searchString + "%");
    
    resultSet = preparedStatement.executeQuery();
    
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
} catch (SQLException e) {
    e.printStackTrace();
} finally {
	 DatabaseUtils.closeConnection(connection, null, resultSet);
}
%>
</div>
</body>
</html>