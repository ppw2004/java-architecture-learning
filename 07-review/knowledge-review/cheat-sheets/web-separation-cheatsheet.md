# 前后端分离快速参考卡片

## 🏗️ 架构对比

```
传统模式：
浏览器 → 服务器(JSP渲染) → 返回HTML

前后端分离：
浏览器 → 前端页面(Vue) ←→ 后端API(JSON) → 数据库
```

## 📊 技术栈

### 前端
| 技术 | 用途 | CDN地址 |
|------|------|---------|
| **Vue.js** | JS框架 | `cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js` |
| **Element UI** | UI组件库 | `unpkg.com/element-ui/lib/index.js` |
| **Axios** | HTTP请求 | `unpkg.com/axios/dist/axios.min.js` |

### 后端
| 技术 | 用途 | 版本 |
|------|------|------|
| **Servlet** | Web层控制器 | 4.0+ |
| **Druid** | 数据库连接池 | 1.2.20 |
| **DBUtils** | 数据库操作 | 1.8.1 |
| **MySQL** | 数据库 | 8.0+ |

## 🎯 MVC分层结构

```
┌─────────────────────────────────────┐
│         Controller (Web层)           │
│  Servlet: 接收请求、返回JSON         │
└────────────┬────────────────────────┘
             │ 调用
             ↓
┌─────────────────────────────────────┐
│         Service (业务层)             │
│  业务逻辑处理、事务控制               │
└────────────┬────────────────────────┘
             │ 调用
             ↓
┌─────────────────────────────────────┐
│         DAO (数据访问层)             │
│  数据库CRUD操作                      │
└────────────┬────────────────────────┘
             │ 访问
             ↓
┌─────────────────────────────────────┐
│            MySQL数据库               │
└─────────────────────────────────────┘
```

## 📁 标准项目结构

```
web-project/
├── pom.xml                    # Maven配置
├── src/main/
│   ├── java/com/example/
│   │   ├── controller/        # Servlet控制器
│   │   ├── service/           # 业务逻辑
│   │   ├── dao/               # 数据访问
│   │   ├── entity/            # 实体类
│   │   ├── filter/            # 过滤器
│   │   └── util/              # 工具类
│   ├── resources/
│   │   └── druid.properties   # 数据库配置
│   └── webapp/
│       └── index.html         # 前端页面
```

## 🔌 RESTful API规范

| 操作 | HTTP方法 | URL示例 | 说明 |
|------|----------|---------|------|
| 查询所有 | GET | `/api/user/findAll` | 获取列表 |
| 查询单个 | GET | `/api/user/findById?id=1` | 获取详情 |
| 新增 | POST | `/api/user/add` | 创建资源 |
| 修改 | POST | `/api/user/update` | 更新资源 |
| 删除 | DELETE | `/api/user/delete?id=1` | 删除资源 |

## 📦 统一响应格式

```json
{
  "code": 200,          // 状态码
  "message": "操作成功",  // 提示信息
  "data": {...}         // 返回数据
}
```

**状态码**：
- `200`：成功
- `401`：未授权
- `404`：资源不存在
- `500`：服务器错误

## 💻 后端代码模板

### Servlet控制器

```java
@WebServlet("/api/user/*")
public class UserController extends HttpServlet {

    private UserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=utf-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");

        String uri = req.getRequestURI();
        String method = uri.substring(uri.lastIndexOf("/") + 1);

        Result<?> result;
        switch (method) {
            case "findAll":
                result = service.findAll();
                break;
            default:
                result = Result.error("无效请求");
        }

        resp.getWriter().write(JSON.toJSONString(result));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 读取JSON请求体
        BufferedReader reader = req.getReader();
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            json.append(line);
        }

        // 解析并处理
        User user = JSON.parseObject(json.toString(), User.class);
        Result<?> result = service.add(user);

        resp.getWriter().write(JSON.toJSONString(result));
    }
}
```

### DAO层

```java
public class UserDao {
    private QueryRunner runner = new QueryRunner(DruidUtils.getDataSource());

    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM users";
        return runner.query(sql, new BeanListHandler<>(User.class));
    }

    public User findById(Integer id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id=?";
        return runner.query(sql, new BeanHandler<>(User.class), id);
    }

    public boolean add(User user) throws SQLException {
        String sql = "INSERT INTO users(username, password) VALUES(?, ?)";
        int rows = runner.update(sql, user.getUsername(), user.getPassword());
        return rows > 0;
    }
}
```

### Druid工具类

```java
public class DruidUtils {
    private static DruidDataSource dataSource;

    static {
        try {
            InputStream is = DruidUtils.class.getClassLoader()
                .getResourceAsStream("druid.properties");
            Properties props = new Properties();
            props.load(is);
            dataSource = (DruidDataSource) DruidDataSourceFactory
                .createDataSource(props);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DruidDataSource getDataSource() {
        return dataSource;
    }
}
```

## 🌐 前端代码模板

### Axios请求

```javascript
// GET请求
axios.get('http://localhost:8080/api/user/findAll')
    .then(response => {
        const result = response.data;
        if (result.code === 200) {
            this.users = result.data;
        }
    })
    .catch(error => {
        this.$message.error('请求失败');
    });

// POST请求
axios.post('http://localhost:8080/api/user/add', {
    username: 'admin',
    password: '123456'
})
.then(response => {
    const result = response.data;
    if (result.code === 200) {
        this.$message.success('添加成功');
    }
});
```

### Vue数据绑定

```javascript
new Vue({
    el: '#app',
    data: {
        users: [],
        userForm: {
            username: '',
            password: ''
        }
    },
    methods: {
        loadUsers() {
            axios.get('http://localhost:8080/api/user/findAll')
                .then(response => {
                    this.users = response.data.data;
                });
        }
    },
    mounted() {
        this.loadUsers();
    }
});
```

## 🗄️ 数据库配置

### Druid配置 (druid.properties)

```properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/web_demo?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8
username=root
password=123456

initialSize=5
maxActive=10
maxWait=3000
```

### 常用SQL

```sql
-- 创建表
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(50),
    email VARCHAR(100),
    age INT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 插入数据
INSERT INTO users (username, password, nickname, email, age) VALUES
('admin', '123456', '管理员', 'admin@example.com', 30);
```

## 🚀 快速启动

```bash
# 1. 创建数据库
mysql -u root -p < src/main/resources/db.sql

# 2. 修改配置
vim src/main/resources/druid.properties

# 3. 编译运行
mvn clean compile
mvn tomcat7:run

# 4. 访问
# 浏览器打开 http://localhost:8080
```

## 🐛 常见问题

| 问题 | 原因 | 解决方法 |
|------|------|----------|
| **CORS跨域错误** | 浏览器同源策略 | 添加响应头：`Access-Control-Allow-Origin: *` |
| **404错误** | URL路径错误 | 检查@WebServlet注解路径 |
| **数据库连接失败** | 配置错误 | 检查druid.properties配置 |
| **500错误** | 代码异常 | 查看服务器日志，检查异常堆栈 |

## 📝 开发清单

### 后端开发
- [ ] 创建Maven项目
- [ ] 配置pom.xml依赖
- [ ] 创建实体类（Entity）
- [ ] 创建DAO层
- [ ] 创建Service层
- [ ] 创建Controller（Servlet）
- [ ] 配置Druid
- [ ] 创建数据库和表

### 前端开发
- [ ] 引入Vue.js
- [ ] 引入Element UI
- [ ] 引入Axios
- [ ] 创建页面结构
- [ ] 实现数据绑定
- [ ] 实现API调用
- [ ] 处理响应数据

## 🔗 有用的资源

- [Servlet官方文档](https://javaee.github.io/servlet/)
- [Vue.js官方文档](https://vuejs.org/)
- [Element UI文档](https://element.eleme.io/)
- [Axios文档](https://axios-http.com/)
- [Druid文档](https://github.com/alibaba/druid)

---

**最后更新**：2026-01-20
