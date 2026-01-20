# 前后端分离示例项目 - 用户管理系统

## 项目简介

这是一个完整的Java Web前后端分离示例项目，展示了：
- **后端**：Servlet + DAO + MySQL + Druid + DBUtils
- **前端**：Vue.js + Element UI + Axios
- **架构**：MVC分层 + RESTful API

## 技术栈

### 后端
- **Servlet**：Web层控制器
- **MySQL**：数据库
- **Druid**：数据库连接池
- **DBUtils**：数据库操作工具
- **Lombok**：简化实体类
- **FastJSON**：JSON处理

### 前端
- **Vue.js 2.x**：JavaScript框架
- **Element UI**：UI组件库
- **Axios**：HTTP客户端

## 项目结构

```
web-demo/
├── pom.xml                              # Maven配置
├── src/
│   └── main/
│       ├── java/com/example/
│       │   ├── controller/              # 控制器层
│       │   │   └── UserController.java
│       │   ├── service/                 # 业务层
│       │   │   ├── UserService.java
│       │   │   └── impl/
│       │   ├── dao/                     # 数据访问层
│       │   │   ├── UserDao.java
│       │   │   └── impl/
│       │   ├── entity/                  # 实体类
│       │   │   ├── Result.java
│       │   │   └── User.java
│       │   ├── filter/                  # 过滤器
│       │   ├── util/                    # 工具类
│       │   │   └── DruidUtils.java
│       │   └── config/                  # 配置类
│       ├── resources/
│       │   ├── druid.properties         # Druid配置
│       │   └── db.sql                   # 数据库脚本
│       └── webapp/
│           ├── index.html               # 前端页面
│           ├── WEB-INF/
│               └── web.xml
│           ├── js/
│           └── css/
└── README.md                            # 本文件
```

## 快速开始

### 1. 环境准备

**必需软件**：
- JDK 17+
- Maven 3.6+
- MySQL 5.7+
- Tomcat 9.x（或使用Maven插件）

### 2. 数据库初始化

```bash
# 登录MySQL
mysql -u root -p

# 执行数据库脚本
source src/main/resources/db.sql

# 或者手动执行：
# 创建数据库
CREATE DATABASE web_demo DEFAULT CHARACTER SET utf8mb4;

# 创建表
USE web_demo;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(50),
    email VARCHAR(100),
    age INT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# 插入测试数据
INSERT INTO users (username, password, nickname, email, age) VALUES
('admin', '123456', '管理员', 'admin@example.com', 30),
('user1', '123456', '用户1', 'user1@example.com', 25);
```

### 3. 修改数据库配置

编辑 `src/main/resources/druid.properties`：

```properties
url=jdbc:mysql://localhost:3306/web_demo?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8
username=root
password=你的MySQL密码
```

### 4. 编译项目

```bash
mvn clean compile
```

### 5. 运行项目

**方式1：使用Maven Tomcat插件**
```bash
mvn tomcat7:run
```

**方式2：部署到Tomcat**
```bash
# 打包
mvn clean package

# 将 target/web-demo.war 复制到 Tomcat的webapps目录
cp target/web-demo.war $TOMCAT_HOME/webapps/

# 启动Tomcat
cd $TOMCAT_HOME/bin
./startup.sh  # Linux/Mac
startup.bat   # Windows
```

### 6. 访问应用

打开浏览器访问：http://localhost:8080

**默认账号**：
- 用户名：admin
- 密码：123456

## API接口文档

### 1. 用户登录

**接口**：`POST /api/user/login`

**请求参数**：
```json
{
  "username": "admin",
  "password": "123456"
}
```

**响应示例**：
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员",
    "email": "admin@example.com",
    "age": 30
  }
}
```

### 2. 查询所有用户

**接口**：`GET /api/user/findAll`

**响应示例**：
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "username": "admin",
      "nickname": "管理员",
      "email": "admin@example.com",
      "age": 30
    }
  ]
}
```

### 3. 新增用户

**接口**：`POST /api/user/add`

**请求参数**：
```json
{
  "username": "newuser",
  "password": "123456",
  "nickname": "新用户",
  "email": "new@example.com",
  "age": 25
}
```

### 4. 更新用户

**接口**：`POST /api/user/update`

**请求参数**：
```json
{
  "id": 1,
  "nickname": "超级管理员",
  "email": "admin@example.com",
  "age": 35
}
```

### 5. 删除用户

**接口**：`DELETE /api/user/delete?id=1`

## 功能演示

### 1. 登录功能
- 输入用户名和密码
- 点击登录按钮
- 登录成功后显示用户列表

### 2. 用户管理
- **查询**：自动加载所有用户
- **新增**：点击"新增用户"按钮，填写表单
- **编辑**：点击"编辑"按钮，修改用户信息
- **删除**：点击"删除"按钮，确认后删除

## 核心代码说明

### 1. MVC分层

```
UserController (Web层)
    ↓ 调用
UserService (业务层)
    ↓ 调用
UserDao (数据访问层)
    ↓ 操作
MySQL数据库
```

### 2. 前后端通信

```javascript
// 前端发送请求
axios.post('http://localhost:8080/api/user/login', {
  username: 'admin',
  password: '123456'
})

// 后端返回JSON
{
  "code": 200,
  "message": "操作成功",
  "data": {...}
}
```

### 3. 统一响应格式

```java
Result<T>
├── code: Integer      // 状态码
├── message: String    // 提示信息
└── data: T           // 返回数据
```

## 常见问题

### 问题1：CORS跨域错误

**现象**：浏览器控制台显示跨域错误

**解决**：后端已添加跨域响应头
```java
resp.setHeader("Access-Control-Allow-Origin", "*");
```

### 问题2：数据库连接失败

**检查**：
1. MySQL是否启动
2. 数据库名、用户名、密码是否正确
3. druid.properties配置是否正确

### 问题3：404错误

**检查**：
1. URL路径是否正确
2. Servlet的@WebServlet注解路径是否正确
3. 项目是否正确部署

## 学习要点

1. **MVC分层**：Controller → Service → DAO
2. **前后端分离**：通过API通信，返回JSON数据
3. **数据库连接池**：Druid提高性能
4. **统一响应格式**：Result类统一返回
5. **Vue组件化**：使用Element UI快速开发

## 扩展练习

1. **添加分页功能**：用户列表支持分页查询
2. **添加过滤功能**：按用户名、邮箱搜索
3. **添加权限控制**：只有管理员可以删除用户
4. **添加数据验证**：前端和后端都要验证
5. **添加日志记录**：记录用户操作

## 技术进阶

完成本项目后，可以学习：
1. **Spring Boot**：简化配置，快速开发
2. **MyBatis**：更强大的ORM框架
3. **Spring Security**：权限认证框架
4. **Redis**：缓存中间件
5. **Vue3**：更新的前端框架

---

**创建时间**：2026-01-20
**作者**：Your Name
**版本**：1.0.0
