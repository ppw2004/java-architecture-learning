# Maven Hello World 示例项目

## 项目说明

这是一个简单的Maven项目示例，演示了：
- Maven项目结构
- pom.xml配置
- 依赖管理（JUnit、Lombok、Apache Commons）
- 编译、测试、打包流程

## 项目结构

```
maven-hello-world/
├── pom.xml                          # Maven配置文件
├── README.md                        # 本文件
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── App.java    # 主程序
│   │   └── resources/
│   └── test/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── AppTest.java # 测试类
│       └── resources/
└── target/                          # 编译输出目录（自动生成）
```

## 使用说明

### 前置要求
- JDK 17+
- Maven 3.6+

### 常用命令

```bash
# 1. 清理之前的编译
mvn clean

# 2. 编译源代码
mvn compile

# 3. 运行测试
mvn test

# 4. 打包（生成jar文件）
mvn package

# 5. 安装到本地仓库
mvn install

# 6. 跳过测试打包
mvn package -DskipTests

# 7. 运行主程序
mvn exec:java -Dexec.mainClass="com.example.App"

# 8. 查看依赖树
mvn dependency:tree

# 9. 清理 + 打包（最常用）
mvn clean package
```

### 运行程序

**方式1：使用Maven插件**
```bash
mvn exec:java -Dexec.mainClass="com.example.App"
```

**方式2：使用java命令（需先打包）**
```bash
mvn clean package
java -cp target/maven-hello-world-1.0.0.jar com.example.App
```

### 预期输出

```
Hello, World!
字符串为空（使用Apache Commons Lang3）
使用Lombok的@Slf4j注解记录日志
10 + 20 = 30
```

## 项目依赖

本项目使用了以下Maven依赖：

| 依赖 | 版本 | 说明 |
|------|------|------|
| junit-jupiter | 5.10.1 | 测试框架 |
| commons-lang3 | 3.14.0 | 工具类库 |
| lombok | 1.18.30 | 简化Java代码 |

## 学习要点

### 1. Maven坐标
```xml
<groupId>com.example</groupId>
<artifactId>maven-hello-world</artifactId>
<version>1.0.0</version>
```

### 2. 依赖管理
```xml
<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>5.10.1</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 3. Maven生命周期
- clean：清理target目录
- compile：编译源代码
- test：运行测试
- package：打包
- install：安装到本地仓库

### 4. 标准目录结构
- src/main/java：源代码
- src/main/resources：资源文件
- src/test/java：测试代码
- src/test/resources：测试资源
- target：编译输出

## 常见问题

### 问题1：Maven下载依赖慢
**解决**：配置阿里云镜像（在~/.m2/settings.xml中）

### 问题2：找不到主类
**解决**：确保使用正确的类名 `com.example.App`

### 问题3：编译报错
**解决**：
1. 检查JDK版本（需要JDK 17+）
2. 清理并重新编译：`mvn clean compile`

## 扩展练习

1. **添加新依赖**：在pom.xml中添加Hutool工具类
2. **创建新类**：创建一个Calculator类，实现加减乘除
3. **编写测试**：为Calculator类编写单元测试
4. **打包运行**：打包成jar文件并运行

## 参考资源

- [Maven官方文档](https://maven.apache.org/guides/)
- [Maven中央仓库](https://mvnrepository.com/)
- [JUnit 5用户指南](https://junit.org/junit5/docs/current/user-guide/)

---

**创建时间**：2026-01-20
**作者**：Your Name
