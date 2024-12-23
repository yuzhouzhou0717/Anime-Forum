package com.dao;

import com.bean.Comment;
import com.bean.pComment;
import com.util.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class pCommentDao {
	
    public int addpComment(pComment pcomment) {
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtils.getConnection();

            String sql = "INSERT INTO pcomments (user_id, post_id, pcomment_text) VALUES (?, ?, ?)";
           
            preparedStatement = connection.prepareStatement(sql);
            
            // 假设 Comment 对象中包含用户ID
            preparedStatement.setInt(1, pcomment.getUserId());
            preparedStatement.setInt(2, pcomment.getPostId());
            preparedStatement.setString(3, pcomment.getPcommnet());
            
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
    public boolean deletePcomment(int pcommentId, int userId) {
        try (Connection connection = DatabaseUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM pcomments WHERE pcomment_id = ? AND user_id = ?")) {

            preparedStatement.setInt(1, pcommentId);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 处理异常，例如记录日志或抛出自定义异常
            return false;
        }
    } 
}