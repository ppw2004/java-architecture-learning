package com.example.dao;

import com.example.entity.User;
import com.example.util.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * 用户DAO层
 */
public class UserDao {

    private QueryRunner runner = new QueryRunner(DruidUtils.getDataSource());

    /**
     * 根据用户名查询用户
     */
    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        return runner.query(sql, new BeanHandler<>(User.class), username);
    }

    /**
     * 根据ID查询用户
     */
    public User findById(Integer id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        return runner.query(sql, new BeanHandler<>(User.class), id);
    }

    /**
     * 查询所有用户
     */
    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        return runner.query(sql, new BeanListHandler<>(User.class));
    }

    /**
     * 添加用户
     */
    public boolean add(User user) throws SQLException {
        String sql = "INSERT INTO users(username, password, nickname, email, age) VALUES(?, ?, ?, ?, ?)";
        int rows = runner.update(sql,
            user.getUsername(),
            user.getPassword(),
            user.getNickname(),
            user.getEmail(),
            user.getAge()
        );
        return rows > 0;
    }

    /**
     * 更新用户
     */
    public boolean update(User user) throws SQLException {
        String sql = "UPDATE users SET nickname=?, email=?, age=? WHERE id=?";
        int rows = runner.update(sql,
            user.getNickname(),
            user.getEmail(),
            user.getAge(),
            user.getId()
        );
        return rows > 0;
    }

    /**
     * 删除用户
     */
    public boolean delete(Integer id) throws SQLException {
        String sql = "DELETE FROM users WHERE id=?";
        int rows = runner.update(sql, id);
        return rows > 0;
    }
}
