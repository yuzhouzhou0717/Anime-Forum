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

@WebServlet("/client/DeleteAnimeServlet")
public class DeleteAnimeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String animeIdStr = request.getParameter("id");

        if (animeIdStr != null && !animeIdStr.isEmpty()) {
            int animeId = Integer.parseInt(animeIdStr);

            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                connection = DatabaseUtils.getConnection();
                String sql = "DELETE FROM anime WHERE id = ?";
                preparedStatement = connection.prepareStatement(sql);

             
                preparedStatement.setInt(1, animeId);

      
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
            
                    response.sendRedirect(request.getContextPath() + "/client/animeAdmin.jsp");
                } else {
            
                    request.setAttribute("error_msg", "删除动漫失败");
                    request.getRequestDispatcher("/client/animeAdmin.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
          
                DatabaseUtils.closeConnection(connection, preparedStatement, null);
            }
        } else {
        
            request.setAttribute("error_msg", "未提供有效的动漫ID");
            request.getRequestDispatcher("/client/animeAdmin.jsp").forward(request, response);
        }
    }
}
