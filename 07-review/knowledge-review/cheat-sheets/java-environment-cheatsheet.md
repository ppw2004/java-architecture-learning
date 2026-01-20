# Java环境与包管理器 - 快速参考卡片

## 📦 JDK/JRE/JVM 快速对比

| 组件 | 全称 | 用途 | 包含 |
|------|------|------|------|
| **JVM** | Java Virtual Machine | 执行字节码 | 解释器、JIT、GC |
| **JRE** | Java Runtime Environment | 运行Java程序 | JVM + 核心类库 |
| **JDK** | Java Development Kit | 开发Java程序 | JRE + 开发工具 |

**记忆口诀**：JDK > JRE > JVM （包含关系）

## 🔧 常用命令

### Java编译与运行
```bash
# 编译
javac HelloWorld.java

# 运行
java HelloWorld

# 查看版本
java -version
javac -version
```

### JVM参数
```bash
# 堆内存配置
-Xms512m          # 初始堆内存512MB
-Xmx1024m         # 最大堆内存1024MB
-Xmn256m          # 新生代256MB

# GC日志
-XX:+PrintGCDetails    # 打印GC详情
-Xlog:gc*:file=g.log   # JDK9+日志配置

# 查看参数
java -XX:+PrintFlagsFinal -version | grep HeapSize
```

### Maven命令
```bash
# 清理 + 编译 + 打包
mvn clean package

# 跳过测试打包
mvn package -DskipTests

# 查看依赖树
mvn dependency:tree

# 强制更新依赖
mvn clean install -U

# 运行Spring Boot
mvn spring-boot:run
```

### Gradle命令
```bash
# 构建
gradle build

# 运行测试
gradle test

# 运行Spring Boot
gradle bootRun

# 查看依赖
gradle dependencies
```

## 📁 Maven项目标准结构

```
my-project/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/          # 源代码
│   │   └── resources/     # 配置文件
│   └── test/
│       ├── java/          # 测试代码
│       └── resources/     # 测试配置
└── target/                # 编译输出
```

## 🎯 pom.xml核心结构

```xml
<project>
    <!-- 坐标 -->
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.0</version>

    <!-- 属性 -->
    <properties>
        <java.version>17</java.version>
    </properties>

    <!-- 依赖 -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <!-- 构建 -->
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

## 🔍 依赖范围（Scope）

| scope | 编译期 | 测试期 | 运行期 | 示例 |
|-------|--------|--------|--------|------|
| **compile**（默认） | ✅ | ✅ | ✅ | spring-core |
| **provided** | ✅ | ✅ | ❌ | servlet-api |
| **runtime** | ❌ | ✅ | ✅ | JDBC驱动 |
| **test** | ❌ | ✅ | ❌ | junit |

## 🏪 常用仓库

### Maven Central（中央仓库）
```xml
<repository>
    <id>central</id>
    <url>https://repo.maven.apache.org/maven2</url>
</repository>
```

### 阿里云镜像（推荐）
```xml
<mirror>
    <id>aliyun</id>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

### Spring仓库
```xml
<repository>
    <id>spring-milestones</id>
    <url>https://repo.spring.io/milestone</url>
</repository>
```

## 📚 常用依赖

### Spring Boot
```xml
<!-- Web开发 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- 数据库 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<!-- Redis -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>

<!-- 测试 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

### 工具类
```xml
<!-- Lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <scope>provided</scope>
</dependency>

<!-- Hutool工具类 -->
<dependency>
    <groupId>cn.hutool</groupId>
    <artifactId>hutool-all</artifactId>
    <version>5.8.23</version>
</dependency>

<!-- Apache Commons -->
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
</dependency>
```

## 🐛 常见问题

### 问题1：依赖下载慢
**解决**：配置阿里云镜像

### 问题2：依赖冲突
**排查**：
```bash
mvn dependency:tree
```
**解决**：使用`<exclusions>`排除依赖

### 问题3：版本管理混乱
**解决**：使用`<dependencyManagement>`统一管理版本

### 问题4：打包后运行报错
**排查**：
```bash
# 查看jar包内容
jar tf my-app.jar

# 查看MANIFEST.MF
unzip -p my-app.jar META-INF/MANIFEST.MF
```

## 📝 最佳实践

1. **使用父POM**：继承spring-boot-starter-parent
2. **统一版本管理**：使用properties定义版本号
3. **依赖范围明确**：测试依赖加`<scope>test</scope>`
4. **排除无用依赖**：使用`<exclusions>`
5. **本地仓库清理**：遇到问题时删除`~/.m2/repository`对应目录

## 🔗 有用的链接

- [Maven中央仓库搜索](https://mvnrepository.com/)
- [Spring Initializr](https://start.spring.io/)
- [Maven官方文档](https://maven.apache.org/guides/)
- [Gradle官方文档](https://docs.gradle.org/)

---

**最后更新**：2026-01-20
