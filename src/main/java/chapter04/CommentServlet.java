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
import javax.servlet.http.HttpSession;

import com.bean.Comment;
import com.dao.CommentDao;
import com.util.DatabaseUtils;

@WebServlet("/client/CommentServlet")
public class CommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
  
        int animeId = Integer.parseInt(request.getParameter("animeId"));
        String commentText = request.getParameter("commentText");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("uid");
        String username = (String) session.getAttribute("username"); 

        if (userId == null) {
      
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
         
            Comment comment = new Comment();
            comment.setUserId(userId);
            comment.setAnimeId(animeId);
            comment.setContent(commentText);

       
            CommentDao commentDao = new CommentDao();
            int rowsAffected = commentDao.addComment(comment);
        
            if (rowsAffected > 0) {
              
                response.sendRedirect("animeDetails.jsp?id=" + animeId);
                System.out.println("评论: " + commentText);
            } else {
             
                request.setAttribute("error_msg", "评论提交失败");
                response.sendRedirect("animeDetails.jsp?id=" + animeId);
            }
        }
    }
}

