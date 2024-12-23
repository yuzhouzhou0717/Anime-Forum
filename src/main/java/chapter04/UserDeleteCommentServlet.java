package chapter04;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CommentDao;

@WebServlet("/client/UserDeleteCommentServlet")
public class UserDeleteCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
   
        int commentId = Integer.parseInt(request.getParameter("commentId"));

        System.out.println("commentId: " + commentId);
   
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("uid");

        if (userId == null) {
        
            response.sendRedirect("login.jsp");
        } else {
        
            CommentDao commentDao = new CommentDao();

           
            if (commentDao.isCommentOwner(commentId, userId)) {
            
                boolean success = commentDao.deleteComment(commentId,userId);

               
                String animeIdParam = request.getParameter("id");
                int animeId = animeIdParam != null ? Integer.parseInt(animeIdParam) : 0;

            if (success) {
           
                String referer = request.getHeader("referer");
                response.sendRedirect(referer);
            } else {
               
                request.setAttribute("error_msg", "评论删除失败，请稍后重试或联系管理员");
                request.getRequestDispatcher("/client/animeDetails.jsp?id=" + animeId).forward(request, response);
            }
         } else {

      
             String animeIdParam = request.getParameter("id");
             int animeId = animeIdParam != null ? Integer.parseInt(animeIdParam) : 0;
           
            request.setAttribute("error_msg", "你无权删除别人的评论");
            request.getRequestDispatcher("/client/animeDetails.jsp?id=" + animeId).forward(request, response);
    }
        }}}
