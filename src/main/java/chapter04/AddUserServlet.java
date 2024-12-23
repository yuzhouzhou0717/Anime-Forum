
package chapter04;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.User;
import com.dao.UserDao;

@WebServlet("/client/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
       
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        int key = Integer.parseInt(request.getParameter("key"));

       
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setkey(key);

   
        UserDao userDao = new UserDao();
        boolean result = false;
		try {
			result = userDao.addUser(username,password,key);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}

        
        if (result) {
      
        	 response.sendRedirect(request.getContextPath() + "/client/admin.jsp");
        } else {

            request.setAttribute("error_msg", "添加用户失败");
            request.getRequestDispatcher("/client/admin.jsp").forward(request, response);
        }
}

}