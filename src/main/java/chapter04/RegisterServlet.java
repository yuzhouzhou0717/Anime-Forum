package chapter04;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bean.User;
import com.dao.UserDao;


@WebServlet("/client/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        UserDao userDao = new UserDao();
    
        if (!userDao.isUsernameValid(username) || !userDao.isPasswordValid(password)) {
            request.setAttribute("error_msg", "用户名或密码不符合要求，请重新输入。");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; 
        }
       
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error_msg", "两次密码不一致！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; 
        }
      
        if (userDao.isUsernameExists(username)) { 
            request.setAttribute("error_msg", "用户名已存在，请选择其他用户名！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        int row = userDao.register(user);
        if (row > 0) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error_msg","注册失败！请刷新页面或重新打开浏览器！");
            request.getRequestDispatcher("register.jsp").forward(request,response);
        }
    }
}



