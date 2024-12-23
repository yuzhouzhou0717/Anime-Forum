package chapter04;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;

@WebServlet("/client/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String newUsername = request.getParameter("newUsername");
        int userId = (int) request.getSession().getAttribute("uid"); // 获取用户ID
        

        boolean updateSuccessful = UserDao.updateUsername(userId, newUsername);
        
        if (updateSuccessful) {
            out.println("用户名更新成功");
    
        } else {
            out.println("用户名更新失败");
         
        }
    }
}
