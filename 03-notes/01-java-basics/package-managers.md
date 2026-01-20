# Java包管理器（Maven/Gradle）

## 📚 概念理解

Java包管理器用于自动化构建、依赖管理和项目配置。主要工具是Maven和Gradle。

**为什么需要包管理器？**

没有包管理器时：
```
❌ 手动下载jar包到项目
❌ 手动管理版本冲突
❌ 手动编写编译脚本
❌ 手动打包部署
❌ jar包地狱（依赖地狱）
```

有了包管理器后：
```
✅ 自动下载依赖
✅ 自动管理版本
✅ 自动构建项目
✅ 统一项目结构
✅ 一键打包部署
```

## 🎯 核心要点

### 1. Maven

**特点**：
- 基于XML配置（pom.xml）
- 约定优于配置（固定目录结构）
- 生命周期管理
- 中央仓库（Maven Central）

**核心概念**：

#### 1.1 坐标（Coordinates）
唯一标识一个项目：
```xml
<groupId>com.example</groupId>    # 公司/组织域名倒写
<artifactId>my-app</artifactId>   # 项目名
<version>1.0.0</version>          # 版本号
```

#### 1.2 依赖范围
| scope | 说明 | 示例 |
|-------|------|------|
| compile | 默认范围，编译和运行都有效 | spring-core |
| provided | 编译有效，运行时由JDK/容器提供 | servlet-api |
| runtime | 运行时有效，编译时不需要 | JDBC驱动 |
| test | 测试时有效 | junit |
| system | 本地jar包，不推荐使用 | 本地jar |

#### 1.3 生命周期
```
clean 生命周期
├── pre-clean
├── clean    (清理target目录)
└── post-clean

default 生命周期
├── compile   (编译源码)
├── test      (运行测试)
├── package   (打包：jar/war)
├── install   (安装到本地仓库)
└── deploy    (部署到远程仓库)

site 生命周期
└── 生成项目文档
```

### 2. Gradle

**特点**：
- 基于Groovy/Kotlin DSL
- 灵活性高，性能更好
- 增量构建
- 支持多语言（Java、Kotlin、Python等）

**核心概念**：

#### 2.1 项目结构
```groovy
build.gradle           # 构建脚本
settings.gradle        # 项目设置（多模块）
build/                 # 构建输出目录
src/
├── main/
│   ├── java/
│   └── resources/
└── test/
    ├── java/
    └── resources/
```

#### 2.2 任务（Tasks）
```groovy
// 常用任务
gradle build          # 构建项目
gradle test           # 运行测试
gradle clean          # 清理构建
gradle bootRun        # 运行Spring Boot应用
```

### 3. Maven vs Gradle

| 特性 | Maven | Gradle |
|------|-------|--------|
| **配置文件** | XML (pom.xml) | Groovy/Kotlin DSL (build.gradle) |
| **性能** | 较慢 | 快（增量构建） |
| **灵活性** | 低（约定大于配置） | 高（高度灵活） |
| **学习曲线** | 平缓 | 较陡 |
| **社区** | 成熟、稳定 | 快速增长 |
| **默认仓库** | Maven Central | Maven Central |
| **使用率** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

**选择建议**：
- 传统项目、稳定优先 → Maven
- 微服务、现代项目、性能优先 → Gradle
- Spring Boot 3.x 推荐使用Maven

### 4. 仓库类型

```
本地仓库 (~/.m2/repository)
    ↓ 查找依赖
中央仓库 (Maven Central)
    ↓ 查找依赖
远程仓库 (公司私服/阿里云镜像)
    ↓ 查找依赖
项目仓库 (lib目录)
```

**常用镜像**：
```xml
<!-- 阿里云镜像 -->
<mirror>
  <id>aliyun</id>
  <mirrorOf>central</mirrorOf>
  <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

## 💡 AI指导

### Q1: 如何查找依赖？

**A**：三种方式

**方式1：Maven中央仓库搜索**
- 访问 https://mvnrepository.com/
- 搜索依赖（如spring boot）
- 选择版本，复制Maven/Gradle配置

**方式2：IDE自动搜索**
- IDEA：File → Project Structure → Libraries → +
- 输入依赖名，自动搜索

**方式3：Spring Initializr**
- 访问 https://start.spring.io/
- 选择依赖，自动生成项目

### Q2: 依赖冲突怎么解决？

**A**：Maven使用** shortest path**（最短路径优先）和**first declaration**（先声明优先）原则

**示例冲突**：
```
A → B → C → v1.0
A → D → C → v2.0

路径1长度：3 (A→B→C)
路径2长度：2 (A→D→C)

结果：使用v2.0（路径2更短）
```

**解决方案**：
```xml
<!-- 方案1：排除依赖 -->
<dependency>
  <groupId>com.example</groupId>
  <artifactId>A</artifactId>
  <exclusions>
    <exclusion>
      <groupId>com.example</groupId>
      <artifactId>C</artifactId>
    </exclusion>
  </exclusions>
</dependency>

<!-- 方案2：指定版本 -->
<dependency>
  <groupId>com.example</groupId>
  <artifactId>C</artifactId>
  <version>2.0.0</version>
</dependency>
```

### Q3: 传递依赖是什么？

**A**：A依赖B，B依赖C，那么A也会依赖C

```
项目 → spring-boot-starter-web
        ↓
      spring-boot-starter
        ↓
      spring-core
        ↓
      spring-jcl
```

**查看依赖树**：
```bash
# Maven
mvn dependency:tree

# Gradle
gradle dependencies
```

### Q4: snapshot和release版本有什么区别？

**A**：

| 版本类型 | 说明 | 示例 |
|----------|------|------|
| **Snapshot** | 快照版本，开发中 | 1.0.0-SNAPSHOT |
| **Release** | 正式版本，稳定 | 1.0.0 |

**区别**：
- **Snapshot**：每次构建都会下载最新版本（带时间戳）
- **Release**：只在本地不存在时下载一次

**使用场景**：
- 开发阶段：依赖SNAPSHOT版本
- 生产环境：只使用Release版本

## 💻 示例代码

### 示例1：Maven项目结构

```
my-maven-project/
├── pom.xml                  # Maven配置文件
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── App.java
│   │   └── resources/
│   │       └── application.yml
│   └── test/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── AppTest.java
│       └── resources/
└── target/                  # 构建输出目录（自动生成）
```

### 示例2：pom.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- 项目坐标 -->
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <!-- 属性配置 -->
    <properties>
        <java.version>17</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <!-- 父项目（Spring Boot） -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
    </parent>

    <!-- 依赖管理 -->
    <dependencies>
        <!-- Spring Boot Web -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- 测试依赖 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <!-- 构建配置 -->
    <build>
        <plugins>
            <!-- Spring Boot Maven插件 -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

### 示例3：Gradle配置

```groovy
// build.gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
}

group = 'com.example'
version = '1.0.0'
sourceCompatibility = '17'

repositories {
    mavenCentral()      // 中央仓库
    maven { url 'https://maven.aliyun.com/repository/public' }  // 阿里云镜像
}

dependencies {
    // Spring Boot Web
    implementation 'org.springframework.boot:spring-boot-starter-web'

    // Lombok
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'

    // 测试
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
```

### 示例4：常用Maven命令

```bash
# 清理构建
mvn clean

# 编译
mvn compile

# 运行测试
mvn test

# 打包（跳过测试）
mvn package -DskipTests

# 安装到本地仓库
mvn install

# 部署到远程仓库
mvn deploy

# 查看依赖树
mvn dependency:tree

# 查看有效POM
mvn help:effective-pom

# 指定配置文件打包
mvn package -Pprod

# 强制更新快照版依赖
mvn clean install -U
```

### 示例5：常用Gradle命令

```bash
# 构建项目
gradle build

# 运行测试
gradle test

# 清理构建
gradle clean

# 打包
gradle bootRun

# 查看依赖
gradle dependencies

# 查看项目报告
gradle tasks --all

# 后台运行（不阻塞终端）
gradle bootRun &
```

## 📝 学习心得

1. **Maven更常用**：传统项目和Spring Boot推荐Maven
2. **依赖管理是核心**：不要手动下载jar包，用包管理器
3. **配置国内镜像**：阿里云镜像下载更快
4. **理解依赖冲突**：学会用dependency:tree排查问题
5. **约定优于配置**：遵循Maven的标准目录结构

## ❓ 疑问与解答

**Q**：.m2目录是什么？

**A**：Maven本地仓库目录
- 位置：~/.m2/repository（用户主目录下）
- 作用：存放下载的jar包
- 好处：同一依赖不用重复下载

**Q**：pom.xml中parent标签有什么用？

**A**：继承父项目的配置
```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.0</version>
</parent>
```

**好处**：
- 继承依赖版本管理（不用写version）
- 继承插件配置
- 统一配置管理

**Q**：spring-boot-starter-*是什么？

**A**：Spring Boot的启动器，包含了一组相关依赖

```xml
<!-- 一个依赖包含多个jar包 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- 等价于引入：
- spring-boot-starter
- spring-boot-starter-tomcat
- spring-web
- spring-webmvc
- jackson-databind
...
-->
```

**常用starter**：
- spring-boot-starter-web：Web开发
- spring-boot-starter-data-jpa：数据库操作
- spring-boot-starter-test：测试

## 🔗 相关资源

- [ ] [Maven官方文档](https://maven.apache.org/guides/)
- [ ] [Gradle官方文档](https://docs.gradle.org/current/userguide/userguide.html)
- [ ] [Maven中央仓库搜索](https://mvnrepository.com/)
- [ ] [Spring Initializr](https://start.spring.io/)
- [ ] [阿里云Maven镜像](https://developer.aliyun.com/mvn/)

## ✅ 练习题

### 练习1：创建Maven项目
1. 使用IDEA创建Maven项目
2. 配置pom.xml，添加spring-boot-starter-web依赖
3. 编写一个简单的Controller
4. 运行并访问 http://localhost:8080

### 练习2：依赖管理
1. 在pom.xml中添加lombok依赖
2. 创建一个User类，使用@Data注解
3. 创建测试类测试User类

### 练习3：查看依赖树
```bash
mvn dependency:tree > dependency.txt
```
查看项目的依赖关系，找出spring-boot-starter-web包含哪些依赖。

### 练习4：打包和运行
```bash
# 打包
mvn clean package -DskipTests

# 运行jar包
java -jar target/my-app-1.0.0.jar
```

### 练习5：创建多模块项目
创建一个包含3个模块的项目：
- parent：父项目
- common：公共模块
- web：Web应用模块（依赖common）

---

**学习时间**：2小时
**掌握程度**：⭐⭐⭐⭐ (4/5)
**复习时间**：2026-01-23, 2026-01-30, 2026-02-20
**关联知识点**：Spring Boot、项目构建、依赖注入
