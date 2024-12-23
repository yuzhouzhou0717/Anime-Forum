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

import com.dao.CommentDao;


@WebServlet("/client/LikeCommentServlet")
public class LikeCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	

        int commentId = Integer.parseInt(request.getParameter("commentId"));


        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("uid");
   

        if (userId != null) {

        CommentDao commentDao = new CommentDao();
        int updatedLikes = commentDao.likeComment(commentId);


        response.getWriter().write(String.valueOf(updatedLikes));
    }else {
    	response.setContentType("text/plain; charset=UTF-8");

    	request.setCharacterEncoding("UTF-8");
    	   response.getWriter().write("请登录！");
    }
}

}