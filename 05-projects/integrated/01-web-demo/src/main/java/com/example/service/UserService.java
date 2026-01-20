package com.example.service;

import com.example.dao.UserDao;
import com.example.entity.User;
import com.example.entity.Result;

import java.sql.SQLException;
import java.util.List;

/**
 * 用户Service层
 */
public class UserService {

    private UserDao userDao = new UserDao();

    /**
     * 用户登录
     */
    public Result<User> login(String username, String password) {
        try {
            User user = userDao.findByUsername(username);

            if (user == null) {
                return Result.error("用户不存在");
            }

            if (!user.getPassword().equals(password)) {
                return Result.error("密码错误");
            }

            // 清除密码后再返回
            user.setPassword(null);
            return Result.success(user);

        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }

    /**
     * 查询所有用户
     */
    public Result<List<User>> findAll() {
        try {
            List<User> users = userDao.findAll();
            // 清除密码
            users.forEach(u -> u.setPassword(null));
            return Result.success(users);
        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }

    /**
     * 根据ID查询用户
     */
    public Result<User> findById(Integer id) {
        try {
            User user = userDao.findById(id);
            if (user == null) {
                return Result.error("用户不存在");
            }
            user.setPassword(null);
            return Result.success(user);
        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }

    /**
     * 添加用户
     */
    public Result<String> add(User user) {
        try {
            // 检查用户名是否已存在
            User existUser = userDao.findByUsername(user.getUsername());
            if (existUser != null) {
                return Result.error("用户名已存在");
            }

            boolean success = userDao.add(user);
            return success ? Result.success("添加成功") : Result.error("添加失败");
        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }

    /**
     * 更新用户
     */
    public Result<String> update(User user) {
        try {
            boolean success = userDao.update(user);
            return success ? Result.success("更新成功") : Result.error("更新失败");
        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }

    /**
     * 删除用户
     */
    public Result<String> delete(Integer id) {
        try {
            boolean success = userDao.delete(id);
            return success ? Result.success("删除成功") : Result.error("删除失败");
        } catch (SQLException e) {
            e.printStackTrace();
            return Result.error("系统错误");
        }
    }
}
