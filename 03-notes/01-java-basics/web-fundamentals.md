# Java Web基础与前后端分离

## 📚 概念理解

### 什么是前后端分离？

**传统模式（前后端不分离）**：
```
浏览器 → 服务器(JSP) → 浏览器
         (返回HTML页面)
```
- 后端生成HTML页面
- 前端只是展示
- 耦合度高

**前后端分离模式**：
```
浏览器(API调用) → 后端服务器(返回JSON)
      ↕
前端页面(Vue)
```
- 后端只提供API接口（JSON数据）
- 前端负责页面展示和交互
- 通过HTTP接口通信

### 架构对比图

```
┌─────────────────────────────────────────────────┐
│          传统模式（不分离）                        │
├─────────────────────────────────────────────────┤
│                                                 │
│  浏览器 ───────────→ 服务器                      │
│         返回HTML页面     ↓                        │
│                      JSP渲染页面                  │
│                      包含HTML + CSS + JS         │
│                                                 │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│          前后端分离模式                           │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────┐       API调用        ┌──────────┐│
│  │ 前端页面 │ ←─────────────────→  │ 后端API  ││
│  │ (Vue)   │      JSON数据         │(Servlet) ││
│  └──────────┘                       └──────────┘│
│       ↓                                 ↑      │
│  独立部署                          访问数据库    │
│  (静态服务器)                      (MySQL)      │
│                                                 │
└─────────────────────────────────────────────────┘
```

## 🎯 核心要点

### 1. 前后端分离的优势

| 优势 | 说明 | 具体体现 |
|------|------|----------|
| **并行开发** | 前后端团队同时开发 | 前端用Mock数据，后端定义API |
| **职责清晰** | 前端专注UI，后端专注业务 | 降低耦合度 |
| **易于维护** | 前后端独立部署 | 前端更新不影响后端 |
| **多端复用** | 一套API服务多端 | Web、iOS、Android共用 |
| **定位Bug快** | 问题容易定位 | 前端问题看浏览器，后端看API |
| **减少服务器压力** | 静态资源CDN加速 | 静态文件独立部署 |

### 2. 技术栈

#### 前端技术栈
```
Vue.js        # 渐进式JavaScript框架
├── Element UI # UI组件库（基于Vue）
├── Axios     # HTTP客户端（发送API请求）
└── Node.js   # JavaScript运行环境（开发时）
```

#### 后端技术栈
```
Web层（控制层）
├── Servlet   # 前端控制器（处理请求）
├── Filter    # 过滤器（权限、编码等）
└── BeanUtils # 数据封装工具

Service层（业务层）
├── 业务逻辑处理
└── 事务管理

DAO层（数据访问层）
├── MySQL        # 数据库
├── Druid        # 数据库连接池
└── DBUtils      # 数据库操作工具
```

### 3. MVC分层思想

```
┌────────────────────────────────────────┐
│              浏览器                      │
└──────────────┬─────────────────────────┘
               │ HTTP请求
               ↓
┌────────────────────────────────────────┐
│         Controller层（Web层）           │
│  ┌──────────────────────────────────┐ │
│  │ Servlet / Filter                 │ │
│  │ 职责：接收请求、返回响应           │ │
│  │ 输入：HTTP请求                    │ │
│  │ 输出：JSON数据                    │ │
│  └──────────────────────────────────┘ │
└──────────────┬─────────────────────────┘
               │ 调用业务
               ↓
┌────────────────────────────────────────┐
│         Service层（业务层）             │
│  ┌──────────────────────────────────┐ │
│  │ 业务逻辑类                        │ │
│  │ 职责：处理业务逻辑、事务控制       │ │
│  │ 输入：Controller传来的数据         │ │
│  │ 输出：处理结果                     │ │
│  └──────────────────────────────────┘ │
└──────────────┬─────────────────────────┘
               │ 访问数据
               ↓
┌────────────────────────────────────────┐
│         DAO层（数据访问层）             │
│  ┌──────────────────────────────────┐ │
│  │ 数据访问对象                      │ │
│  │ 职责：CRUD操作                    │ │
│  │ 工具：DBUtils + Druid             │ │
│  └──────────────────────────────────┘ │
└──────────────┬─────────────────────────┘
               │ SQL操作
               ↓
┌────────────────────────────────────────┐
│            MySQL数据库                  │
│  ┌──────────────────────────────────┐ │
│  │ 表：users, orders, products...   │ │
│  └──────────────────────────────────┘ │
└────────────────────────────────────────┘
```

### 4. 标准项目目录结构

```
web-project/
├── pom.xml                          # Maven配置文件
├── src/
│   └── main/
│       ├── java/                    # Java源代码
│       │   └── com/
│       │       └── example/
│       │           ├── controller/  # Controller层（Web层）
│       │           │   ├── UserController.java
│       │           │   └── ProductController.java
│       │           ├── service/     # Service层（业务层）
│       │           │   ├── UserService.java
│       │           │   └── impl/
│       │           │       └── UserServiceImpl.java
│       │           ├── dao/         # DAO层（数据访问层）
│       │           │   ├── UserDao.java
│       │           │   └── impl/
│       │           │       └── UserDaoImpl.java
│       │           ├── entity/      # 实体类（对应数据库表）
│       │           │   ├── User.java
│       │           │   └── Product.java
│       │           ├── filter/      # 过滤器
│       │           │   └── EncodingFilter.java
│       │           ├── util/        # 工具类
│       │           │   ├── DruidUtils.java
│       │           │   └── JsonUtils.java
│       │           └── config/      # 配置类
│       │               └── DruidConfig.java
│       └── resources/               # 资源文件
│           ├── druid.properties     # Druid配置
│           └── db.sql               # 数据库脚本
└── web/                            # Web资源
    ├── index.html                  # 前端页面
    ├── js/
    │   ├── app.js                  # Vue应用
    │   └── axios.min.js            # Axios库
    └── css/
        └── style.css
```

### 5. API接口文档标准

每个API接口应包含以下要素：

```markdown
## 用户登录

### 接口名称
userLogin

### 接口描述
用户登录验证

### 请求URL
/api/user/login

### 请求方式
POST

### 请求参数
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | String | 是 | 用户名 |
| password | String | 是 | 密码 |

### 请求示例
```json
{
  "username": "admin",
  "password": "123456"
}
```

### 响应结果
**成功响应**：
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员"
  }
}
```

**失败响应**：
```json
{
  "code": 401,
  "message": "用户名或密码错误",
  "data": null
}
```
```

## 💡 AI指导

### Q1: 为什么需要前后端分离？

**A**：用一个类比来说明

**传统模式（餐厅）**：
- 顾客点菜 → 厨师做菜 → 厨师端上来
- 厨师既要做饭又要服务
- 顾客多时厨师忙不过来

**前后端分离（快餐店）**：
- 前台（服务员）：负责点餐、端菜
- 后厨（厨师）：只负责做饭
- 分工明确，效率高

**技术角度**：
1. **传统模式**：JSP在服务器端渲染HTML，前端和后端代码混在一起
2. **分离模式**：后端只返回数据（JSON），前端在浏览器渲染页面

### Q2: Servlet、Service、DAO各做什么？

**A**：用餐厅类比

| 层次 | 餐厅角色 | 职责 |
|------|----------|------|
| **Controller** | 服务员 | 接待顾客、接收订单、上菜 |
| **Service** | 大厨 | 决定怎么做菜（业务逻辑） |
| **DAO** | 采购员 | 从仓库取食材（访问数据库） |

**具体流程**：
```
1. Controller接收请求：服务员收到顾客订单
2. Controller调用Service：服务员告诉大厨做什么菜
3. Service处理业务：大厨决定怎么做（用什么调料）
4. Service调用DAO：大厨让采购员拿食材
5. DAO访问数据库：采购员从仓库取食材
6. DAO返回数据：采购员把食材给大厨
7. Service返回结果：大厨做好菜
8. Controller返回响应：服务员把菜端给顾客
```

### Q3: 什么是数据库连接池？

**A**：用游泳馆的例子

**不使用连接池**：
```
每次游泳 → 建一个泳池 → 游完 → 拆除
↓
太浪费时间！
```

**使用连接池**：
```
建一个公共泳池（多个泳道）
↓
需要游泳 → 领取泳道 → 游完 → 归还泳道
↓
效率高！
```

**数据库连接池**：
- 预先创建一批数据库连接
- 需要时从池中获取
- 用完归还，不关闭
- 复用连接，提高性能

**Druid连接池特点**：
- 阿里巴巴开源
- 性能好
- 监控功能强大
- 可以防止SQL注入

### Q4: 什么时候用BeanUtils？

**A**：简化数据封装

**手动封装**（繁琐）：
```java
User user = new User();
user.setName(request.getParameter("name"));
user.setAge(Integer.parseInt(request.getParameter("age")));
user.setEmail(request.getParameter("email"));
// ...几十个字段
```

**使用BeanUtils**（简单）：
```java
User user = new User();
BeanUtils.populate(user, request.getParameterMap());
```

**适用场景**：
- 表单数据很多
- 表单字段名和实体类属性名相同
- 简化代码，减少重复劳动

## 💻 示例代码

### 示例1：统一响应结果类

```java
package com.example.entity;

/**
 * 统一响应结果
 */
public class Result<T> {
    private Integer code;      // 状态码：200成功，其他失败
    private String message;    // 提示信息
    private T data;           // 返回数据

    public Result() {}

    public Result(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    // 成功响应
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "操作成功", data);
    }

    // 失败响应
    public static <T> Result<T> error(String message) {
        return new Result<>(500, message, null);
    }

    // Getters and Setters
    public Integer getCode() { return code; }
    public void setCode(Integer code) { this.code = code; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public T getData() { return data; }
    public void setData(T data) { this.data = data; }
}
```

### 示例2：用户实体类（使用Lombok）

```java
package com.example.entity;

import lombok.Data;

/**
 * 用户实体类
 */
@Data  // Lombok自动生成getter/setter/toString等方法
public class User {
    private Integer id;           // 用户ID
    private String username;      // 用户名
    private String password;      // 密码
    private String nickname;      // 昵称
    private String email;         // 邮箱
    private Integer age;          // 年龄
    private String createTime;    // 创建时间
}
```

### 示例3：用户DAO层

```java
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
     * 查询所有用户
     */
    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM users";
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
```

### 示例4：用户Service层

```java
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
}
```

### 示例5：用户Controller（Servlet）

```java
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

        // 获取请求路径
        String uri = req.getRequestURI();
        String methodName = uri.substring(uri.lastIndexOf("/") + 1);

        Result<?> result;

        switch (methodName) {
            case "findAll":
                result = userService.findAll();
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
        } else {
            result = Result.error("无效的请求");
        }

        // 返回JSON响应
        resp.getWriter().write(JSON.toJSONString(result));
    }
}
```

### 示例6：Druid工具类

```java
package com.example.util;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Druid数据库连接池工具类
 */
public class DruidUtils {

    private static DruidDataSource dataSource;

    static {
        try {
            // 加载配置文件
            InputStream is = DruidUtils.class.getClassLoader()
                .getResourceAsStream("druid.properties");
            Properties props = new Properties();
            props.load(is);

            // 创建数据源
            dataSource = (DruidDataSource) DruidDataSourceFactory
                .createDataSource(props);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取数据源
     */
    public static DruidDataSource getDataSource() {
        return dataSource;
    }

    /**
     * 获取连接
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
```

### 示例7：Druid配置文件

```properties
# druid.properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/web_demo?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8
username=root
password=123456

# 初始化连接数
initialSize=5

# 最大连接数
maxActive=10

# 最大等待时间
maxWait=3000
```

## 📝 学习心得

1. **MVC分层是核心**：Controller → Service → DAO，职责清晰
2. **前后端分离是趋势**：通过API通信，解耦合
3. **连接池很重要**：Druid提高性能，监控方便
4. **统一响应格式**：Result类统一返回格式
5. **Lombok减少代码**：@Data注解放省getter/setter

## ❓ 疑问与解答

**Q**：Servlet和Spring MVC有什么区别？

**A**：
- **Servlet**：Java Web标准技术，需要手动配置
- **Spring MVC**：基于Servlet封装的框架，更方便

**学习路径**：先学Servlet理解原理，再学Spring MVC提高效率

**Q**：为什么需要统一响应格式？

**A**：
- 前端处理方便（统一解析）
- 易于扩展（添加新字段）
- 便于封装错误处理

## 🔗 相关资源

- [ ] [Servlet官方文档](https://javaee.github.io/servlet/)
- [ ] [Druid文档](https://github.com/alibaba/druid)
- [ ] [DBUtils文档](https://commons.apache.org/proper/commons-dbutils/)
- [ ] [Vue.js官方文档](https://vuejs.org/)
- [ ] [Element UI文档](https://element.eleme.io/)

## ✅ 练习题

### 练习1：搭建项目结构
创建一个包含MVC分层的Maven项目

### 练习2：实现用户模块
实现用户的增删改查API

### 练习3：前端集成
使用Vue + Axios调用后端API

### 练习4：添加过滤链
添加字符编码过滤器和权限过滤器

---

**学习时间**：4小时
**掌握程度**：⭐⭐⭐⭐ (4/5)
**复习时间**：2026-01-27, 2026-02-10
**关联知识点**：Servlet、JDBC、MVC设计模式、前端开发
