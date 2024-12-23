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

@WebServlet("/client/DeletePostServlet")
public class DeletePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取评论ID参数
        String postId = request.getParameter("pid");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
       
            connection = DatabaseUtils.getConnection();

  
            String sql = "DELETE FROM posts WHERE post_id = ?";
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, postId);

  
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
         
                response.sendRedirect(request.getContextPath() + "/client/postAdmin.jsp");
            } else {
             
                request.setAttribute("error_msg", "删除评论失败");
                request.getRequestDispatcher("/client/postAdmin.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
    
            DatabaseUtils.closeConnection(connection, preparedStatement, null);
        }
    }
}
