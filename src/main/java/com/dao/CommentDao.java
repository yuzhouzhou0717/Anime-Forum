package com.dao;

import com.bean.Comment;
import com.util.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CommentDao {
	 // 点赞评论
    public int likeComment(int commentId) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
        	connection = DatabaseUtils.getConnection();

            // 查询当前点赞数
            String queryLikesSql = "SELECT likes FROM comments WHERE id = ?";
            preparedStatement = connection.prepareStatement(queryLikesSql);
            preparedStatement.setInt(1, commentId);
            resultSet = preparedStatement.executeQuery();

            int currentLikes = 0;
            if (resultSet.next()) {
                currentLikes = resultSet.getInt("likes");
            }

            // 更新点赞数
            String updateLikesSql = "UPDATE comments SET likes = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(updateLikesSql);
            preparedStatement.setInt(1, currentLikes + 1);
            preparedStatement.setInt(2, commentId);
            preparedStatement.executeUpdate();

            // 返回更新后的点赞数
            return currentLikes + 1;
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常
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

        return 0; // 处理失败时返回0或其他默认值
    }


    public int addComment(Comment comment) {
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtils.getConnection();

            // 检查评论内容是否符合要求
            if (!Comment.isCommentValid(comment.getContent())) {
                // 如果不符合要求，可以抛出异常或者返回错误码
                return row;
            }

            String sql = "INSERT INTO comments (user_id, anime_id, comment_text) VALUES (?, ?, ?)";
           
            preparedStatement = connection.prepareStatement(sql);
            
            // 假设 Comment 对象中包含用户ID
            preparedStatement.setInt(1, comment.getUserId());
            preparedStatement.setInt(2, comment.getAnimeId());
            preparedStatement.setString(3, comment.getContent());
            
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
 // 在CommentDao中添加删除评论的方法
    public boolean deleteComment(int commentId, int userId) {
        try (Connection connection = DatabaseUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM comments WHERE id = ? AND user_id = ?")) {

            preparedStatement.setInt(1, commentId);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 处理异常，例如记录日志或抛出自定义异常
            return false;
        }
    }
    // 检查评论是否属于指定用户
    public boolean isCommentOwner(int commentId, int userId) {
        try (Connection connection = DatabaseUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT user_id FROM comments WHERE id = ?")) {

            preparedStatement.setInt(1, commentId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next() && resultSet.getInt("user_id") == userId;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 处理异常，例如记录日志或抛出自定义异常
            return false;
        }
    }
}
