package chapter04;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;
@WebServlet("/client/UpdatePwdServlet")
public class UpdatePwdServlet extends HttpServlet {
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     String oldPassword = request.getParameter("oldPassword");
     String newPassword = request.getParameter("newPassword");
     
 
     int userId = (int) request.getSession().getAttribute("uid");

     UserDao userDao = new UserDao(); 
     boolean passwordUpdated = userDao.updatePassword(userId, oldPassword, newPassword);

     if (passwordUpdated) {
         response.getWriter().write("success");
     } else {
         response.getWriter().write("failure");
     }
 }
}
