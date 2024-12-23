package chapter04;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.UserDao;

@WebServlet("/client/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

  
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDao userDao = new UserDao();

 
        boolean isValidUser = userDao.login(username, password);

        if (isValidUser) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            
            int userId = userDao.getUserIdByUsername(username);
            session.setAttribute("uid", userId);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error_msg", "用户名或密码错误");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}


