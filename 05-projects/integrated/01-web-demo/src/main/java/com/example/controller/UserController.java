package com.example.controller;

import com.alibaba.fastjson.JSON;
import com.example.entity.Result;
import com.example.entity.User;
import com.example.service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

/**
 * 用户Controller
 */
@WebServlet("/api/user/*")
public class UserController extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 设置响应类型
        resp.setContentType("application/json;charset=utf-8");

        // 允许跨域
        resp.setHeader("Access-Control-Allow-Origin", "*");

        // 获取请求路径
        String uri = req.getRequestURI();
        String methodName = uri.substring(uri.lastIndexOf("/") + 1);

        Result<?> result;

        switch (methodName) {
            case "findAll":
                result = userService.findAll();
                break;
            case "findById":
                String idStr = req.getParameter("id");
                if (idStr == null || idStr.isEmpty()) {
                    result = Result.error("缺少id参数");
                } else {
                    result = userService.findById(Integer.parseInt(idStr));
                }
                break;
            default:
                result = Result.error("无效的请求");
        }

        // 返回JSON响应
        resp.getWriter().write(JSON.toJSONString(result));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 设置响应类型
        resp.setContentType("application/json;charset=utf-8");

        // 允许跨域
        resp.setHeader("Access-Control-Allow-Origin", "*");

        // 处理OPTIONS请求（跨域预检）
        if ("OPTIONS".equals(req.getMethod())) {
            return;
        }

        // 获取请求路径
        String uri = req.getRequestURI();
        String methodName = uri.substring(uri.lastIndexOf("/") + 1);

        // 读取JSON数据
        BufferedReader reader = req.getReader();
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            json.append(line);
        }

        Result<?> result;

        if ("login".equals(methodName)) {
            // 解析登录数据
            User user = JSON.parseObject(json.toString(), User.class);
            result = userService.login(user.getUsername(), user.getPassword());
        } else if ("add".equals(methodName)) {
            // 解析用户数据
            User user = JSON.parseObject(json.toString(), User.class);
            result = userService.add(user);
        } else if ("update".equals(methodName)) {
            // 解析用户数据
            User user = JSON.parseObject(json.toString(), User.class);
            result = userService.update(user);
        } else {
            result = Result.error("无效的请求");
        }

        // 返回JSON响应
        resp.getWriter().write(JSON.toJSONString(result));
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 设置响应类型
        resp.setContentType("application/json;charset=utf-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");

        // 获取id参数
        String idStr = req.getParameter("id");
        Result<?> result;

        if (idStr == null || idStr.isEmpty()) {
            result = Result.error("缺少id参数");
        } else {
            result = userService.delete(Integer.parseInt(idStr));
        }

        resp.getWriter().write(JSON.toJSONString(result));
    }
}
