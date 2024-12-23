package chapter04;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.PostDao;

@WebServlet("/client/UserDeletePostServlet")
public class UserDeletePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        int postId = Integer.parseInt(request.getParameter("postId"));


        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("uid");

        if (userId == null) {
          
            response.sendRedirect("login.jsp");
        } else {
        	
            PostDao postDao = new PostDao();

           
           boolean success = postDao.deletePost(postId,userId);


            if (success) {
              
                String referer = request.getHeader("referer");
                response.sendRedirect(referer);
            } else {
              
                request.setAttribute("error_msg", "删除失败，请稍后重试或联系管理员");
                request.getRequestDispatcher("/client/userProfile.jsp").forward(request, response);
            }
      
    }
    }
}

