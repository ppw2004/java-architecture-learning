-- 创建数据库
CREATE DATABASE IF NOT EXISTS web_demo DEFAULT CHARACTER SET utf8mb4;

USE web_demo;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    nickname VARCHAR(50) COMMENT '昵称',
    email VARCHAR(100) COMMENT '邮箱',
    age INT COMMENT '年龄',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '用户表';

-- 插入测试数据
INSERT INTO users (username, password, nickname, email, age) VALUES
('admin', '123456', '管理员', 'admin@example.com', 30),
('user1', '123456', '用户1', 'user1@example.com', 25),
('user2', '123456', '用户2', 'user2@example.com', 28);
