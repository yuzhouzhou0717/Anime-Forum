package chapter04;


	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.SQLException;

	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

	import com.util.DatabaseUtils;

	@WebServlet("/client/AddAnimeServlet")
	public class AddAnimeServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	    	request.setCharacterEncoding("UTF-8");


	        String animeName = request.getParameter("animeName");
	        String imagePath = request.getParameter("image_path");
	        String description = request.getParameter("description");
	        String tags = request.getParameter("tags");

	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        try {
	            connection = DatabaseUtils.getConnection();
	            String sql = "INSERT INTO anime (name, image_path, description, tags) VALUES (?, ?, ?, ?)";
	            
	            preparedStatement = connection.prepareStatement(sql);
	            preparedStatement.setString(1, animeName);
	            preparedStatement.setString(2, imagePath);
	            preparedStatement.setString(3, description);
	            preparedStatement.setString(4, tags);

	            int rowsAffected = preparedStatement.executeUpdate();
	            if (rowsAffected > 0) {
	            	System.out.println("uid: " + animeName);
	            	 response.sendRedirect(request.getContextPath() + "/client/animeAdmin.jsp");
	            } else {
	                request.setAttribute("error_msg", "添加动漫失败");
	                request.getRequestDispatcher("/client/animeAdmin.jsp").forward(request, response);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            DatabaseUtils.closeConnection(connection, preparedStatement,null);
	        }
	    }
	}
