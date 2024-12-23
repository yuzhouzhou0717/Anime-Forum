package chapter04;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.pComment;
import com.dao.pCommentDao;

@WebServlet("/client/pCommentServlet")
public class pCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        int post_id = Integer.parseInt(request.getParameter("post_id"));
        int user_id = (int) request.getSession().getAttribute("uid");
        String pcomment_text = request.getParameter("pcomment_text");
  
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("uid");
        String username = (String) session.getAttribute("username");   
        System.out.println("Username: " + userId); 

        if (userId == null) {
       
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
        pComment pcomment = new pComment();
        pcomment.setUserId(user_id);
        pcomment.setPostId(post_id);
        pcomment.setPcommnet(pcomment_text);
 
        pCommentDao pcommentDao = new pCommentDao();
        int rowsAffected =  pcommentDao.addpComment(pcomment);

        if (rowsAffected > 0) {
       
        	response.sendRedirect("PostDetails.jsp?postId=" + post_id);
            System.out.println("评论: " + pcomment_text);
        } else {
    
            request.setAttribute("error_msg", "评论提交失败");
        }
    }
    }      
    
}
