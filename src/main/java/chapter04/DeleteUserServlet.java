package chapter04;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;
import com.util.DatabaseUtils;

@WebServlet("/client/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("uid"));

     
        UserDao userDao = new UserDao();
        boolean result = userDao.deleteUserById(userId);

        if (result) {
           
        	response.sendRedirect(request.getContextPath() + "/client/admin.jsp");
        } else {
          
            request.setAttribute("error_msg", "删除用户失败");
            request.getRequestDispatcher("/client/admin.jsp").forward(request, response);
        }
    }
}
