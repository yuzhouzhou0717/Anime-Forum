package com.dao;
import com.util.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.bean.User;

import java.sql.ResultSet;
public class UserDao {
	public Integer getUserIdByUsername(String username) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "SELECT uid FROM user WHERE username = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("uid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtils.closeConnection(connection, preparedStatement, resultSet);
        }

        return null; // 如果没有找到对应的用户，返回null
    }
    public int register(User user) {
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtils.getConnection();
            if (!isUsernameValid(user.getUsername()) || !isPasswordValid(user.getPassword())) {
                return row;
            }
            String sql = "INSERT INTO user (username, pwd) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());

            row = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

    public boolean isUsernameValid(String username) {
        // 用户名只能由字母构成
        String usernameRegex = "^[a-zA-Z]+$";
        return username.matches(usernameRegex);
    }

    public boolean isPasswordValid(String password) {
    	if (password == null) {
            return false;
        }
        // 密码必须由字母和数字构成，并且不能小于6位
        String passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d).{6,}$";
        return password.matches(passwordRegex);
    }
    public boolean isUsernameExists(String username) {
        boolean exists = false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // 如果查询到结果，说明用户名已存在
                int count = resultSet.getInt(1);
                exists = count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常，例如打印异常信息或抛出自定义异常
        } finally {
            // 关闭连接和预处理语句
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
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

        return exists;
    }
    public boolean login(String username, String password) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "SELECT * FROM user WHERE username = ? AND pwd = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            resultSet = preparedStatement.executeQuery();

            // 如果查询结果不为空，说明用户名和密码匹配
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常，例如打印异常信息或抛出自定义异常
        } finally {
            // 关闭连接、预处理语句和结果集
            DatabaseUtils.closeConnection(connection, preparedStatement, resultSet);
        }

        // 如果出现异常或者用户名密码不匹配，返回false
        return false;
    }
    public int getKeyByUsername(String username) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "SELECT `key` FROM user WHERE username = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("key");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常，例如打印异常信息或抛出自定义异常
        } finally {
            // 关闭连接、预处理语句和结果集
            DatabaseUtils.closeConnection(connection, preparedStatement, resultSet);
        }

        return 0; // 如果没有找到对应的用户，或者没有权限字段，返回null
    }
 // 删除用户 by 用户ID
    public boolean deleteUserById(int userId) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "DELETE FROM user WHERE uid = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);

            // 使用 executeUpdate 来执行删除操作
            int rowsAffected = statement.executeUpdate();

            // 根据执行结果返回相应的值
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtils.closeConnection(connection, statement, null);
        }
    }

    public boolean addUser(String username, String password, int key) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtils.getConnection();
            String sql = "INSERT INTO user (username, pwd, `key`) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            preparedStatement.setInt(3, key);
            
            int rowsAffected = preparedStatement.executeUpdate();

            // 返回是否插入成功
            return rowsAffected > 0;
        } finally {
            DatabaseUtils.closeConnection(connection, preparedStatement,null);
        }
    }
    public static boolean updateUsername(int userId, String newUsername) {
        boolean updated = false;
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // 建立数据库连接
            connection = DatabaseUtils.getConnection();

            // 准备更新用户名的 SQL 查询
            String sql = "UPDATE user SET username = ? WHERE uid = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, newUsername);
            statement.setInt(2, userId);

            // 执行更新操作
            int rowsUpdated = statement.executeUpdate();

            // 如果有行受影响，则更新成功
            if (rowsUpdated > 0) {
                updated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接
            DatabaseUtils.closeConnection(connection, statement,null);
        }
        
        return updated;
    }

    public boolean updatePassword(int userId, String oldPassword, String newPassword) {
        boolean passwordUpdated = false;
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseUtils.getConnection();
            String query = "UPDATE user SET pwd = ? WHERE uid = ? AND pwd = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, newPassword);
            statement.setInt(2, userId);
            statement.setString(3, oldPassword);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                passwordUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtils.closeConnection(connection, statement,null);
        }
        return passwordUpdated;
    }
}




