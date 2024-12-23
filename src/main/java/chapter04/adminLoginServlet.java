package chapter04;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Anime;
import com.bean.User;
import com.dao.UserDao;
import com.util.DatabaseUtils;


@WebServlet("/client/adminLoginServlet")
public class adminLoginServlet extends HttpServlet {
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
	
     
     String username = request.getParameter("username");
     String password = request.getParameter("password");


     UserDao userDao = new UserDao();

     boolean isValidUser = userDao.login(username, password);

     if (isValidUser) {
      
    	 System.out.println("Username: " + userDao.getKeyByUsername(username)); // 输出用户名

         if (userDao.getKeyByUsername(username) == 1) {

             HttpSession session = request.getSession();
             session.setAttribute("username", username);
    
          session.setAttribute("adminLoggedIn", true);

             response.sendRedirect(request.getContextPath() + "/client/admin.jsp");
         } else {
            
             request.setAttribute("error_msg", "无权限登录");
             request.getRequestDispatcher("/client/adminLogin.jsp").forward(request, response);
         }
     } else {

         request.setAttribute("error_msg", "用户名或密码错误");
         request.getRequestDispatcher("/client/adminLogin.jsp").forward(request, response);
     }
 }
}