package com.dao;


import com.bean.Post;
import com.util.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class PostDao {
    public int addPost(Post post) {
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtils.getConnection();

            // 检查评论内容是否符合要求
            if (!Post.isPostValid(post.getPostText())) {
                // 如果不符合要求，可以抛出异常或者返回错误码
                return row;
            }

            String sql = "INSERT INTO posts (user_id, post_text) VALUES (?, ?)";
           
            preparedStatement = connection.prepareStatement(sql);
            
            // 假设 Comment 对象中包含用户ID
            preparedStatement.setInt(1,post.getUserId());
            preparedStatement.setString(2, post.getPostText());
            
            row = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常，例如打印异常信息或抛出自定义异常
        } finally {
        	// 关闭连接和预处理语句

          try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return row;
    }
    public boolean deletePost(int postId, int userId) {
        try (Connection connection = DatabaseUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM posts WHERE post_id = ? AND user_id = ?")) {

            preparedStatement.setInt(1, postId);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 处理异常，例如记录日志或抛出自定义异常
            return false;
        }
    } 
}