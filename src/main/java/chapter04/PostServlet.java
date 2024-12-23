package chapter04;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Comment;
import com.bean.Post;
import com.dao.CommentDao;
import com.dao.PostDao;

//PostServlet.java
@WebServlet("/client/PostServlet")
public class PostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

    	request.setCharacterEncoding("UTF-8");
	   
	       
	        String PostText = request.getParameter("PostText");
	        HttpSession session = request.getSession();
	        Integer userId = (Integer) session.getAttribute("uid");

	        if (userId == null) {
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        } else {
	           Post post = new Post();
	           post.setUserId(userId);
	           post.setPostText(PostText);
	           
	            PostDao postDao = new PostDao();
	            int rowsAffected = postDao.addPost(post);
	            if (!Post.isPostValid(PostText)) {
	                request.setAttribute("error_msg", "帖子提交失败");
	                return;
	            }
	            if (rowsAffected > 0) {
	            	  response.sendRedirect(request.getContextPath() + "/client/Post.jsp");
	            } else {
	                request.setAttribute("error_msg", "帖子提交失败");
	            }
	        }
	    }
	}


