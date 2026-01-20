# 00. 开发环境搭建

## 概述

本章节包含 Java 开发环境搭建所需的所有资源、脚本和详细指南。

## 📋 目录

- [快速开始](#快速开始)
- [检测脚本](#检测脚本)
- [安装指南](#安装指南)
- [环境配置](#环境配置)
- [工具推荐](#工具推荐)

---

## 快速开始

### 第一步：检测 Java 环境

使用提供的脚本快速检测系统中的 Java 安装情况：

**Windows:**
```cmd
cd scripts
check-java-windows.bat
```

**Linux/macOS:**
```bash
cd scripts
chmod +x check-java-unix.sh
./check-java-unix.sh
```

### 第二步：安装 Java（如需要）

如果检测脚本提示未安装 Java，请参考 [JAVA-INSTALL-GUIDE.md](JAVA-INSTALL-GUIDE.md) 进行安装。

### 第三步：验证安装

```bash
java -version
javac -version
echo $JAVA_HOME  # Linux/macOS
echo %JAVA_HOME% # Windows
```

---

## 检测脚本

本目录包含自动化的 Java 环境检测脚本：

### [check-java-windows.bat](scripts/check-java-windows.bat)

**功能:**
- ✓ 检测 Java 命令是否可用
- ✓ 显示 Java 版本信息
- ✓ 检查 JAVA_HOME 环境变量
- ✓ 验证 javac 编译器
- ✓ 显示安装路径

**使用方法:**
```cmd
# 直接双击运行，或在命令行执行
scripts\check-java-windows.bat
```

**输出示例:**
```
========================================
       Java 环境检测工具 (Windows)
========================================

[1/5] 检测 Java 命令...
√ Java 命令已找到

[2/5] 检测 Java 版本信息...
Java 版本: "17.0.9"
...
```

### [check-java-unix.sh](scripts/check-java-unix.sh)

**功能:**
- ✓ 检测 Java 和 javac 命令
- ✓ 显示详细版本信息
- ✓ 检查 JAVA_HOME 环境变量
- ✓ 自动检测常见 Java 安装位置
- ✓ 提供安装建议（如未安装）

**使用方法:**
```bash
# 添加执行权限
chmod +x scripts/check-java-unix.sh

# 运行脚本
./scripts/check-java-unix.sh
```

---

## 安装指南

### [JAVA-INSTALL-GUIDE.md](JAVA-INSTALL-GUIDE.md)

详细的 Java 安装指南，涵盖：

- **Windows 安装**
  - 使用安装包
  - 使用 Chocolatey
  - 使用 Winget

- **Linux 安装**
  - Ubuntu/Debian
  - CentOS/RHEL
  - Arch Linux

- **macOS 安装**
  - 使用 Homebrew
  - 使用安装包
  - 使用 SDKMAN!

- **环境变量配置**
  - JAVA_HOME 设置
  - PATH 配置
  - 多版本管理

- **常见问题解决**

---

## 环境配置

### 推荐配置

#### Java 版本
- **项目推荐**: Java 17 LTS
- **备选版本**: Java 21 LTS
- **最低要求**: Java 11+

#### 环境变量

**Windows:**
```cmd
JAVA_HOME=C:\Program Files\Java\jdk-17
PATH=%JAVA_HOME%\bin;[其他路径]
```

**Linux/macOS:**
```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```

### 验证配置

创建 `HelloWorld.java`:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java World!");
    }
}
```

编译并运行:
```bash
javac HelloWorld.java
java HelloWorld
```

---

## 工具推荐

### IDE（集成开发环境）

| 工具 | 推荐度 | 说明 | 下载地址 |
|------|--------|------|----------|
| **IntelliJ IDEA** | ⭐⭐⭐⭐⭐ | 最强大的 Java IDE | [jetbrains.com/idea](https://www.jetbrains.com/idea/) |
| Eclipse | ⭐⭐⭐⭐ | 免费开源 | [eclipse.org](https://www.eclipse.org/) |
| VS Code | ⭐⭐⭐ | 轻量级，插件丰富 | [code.visualstudio.com](https://code.visualstudio.com/) |

### 构建工具

- **Maven** - [maven.apache.org](https://maven.apache.org/)
- **Gradle** - [gradle.org](https://gradle.org/)

### 版本管理

- **Git** - [git-scm.com](https://git-scm.com/)
- **GitHub** - [github.com](https://github.com)

### 多版本管理

- **SDKMAN!** (Linux/macOS) - [sdkman.io](https://sdkman.io/)
- **jEnv** (macOS/Linux) - [jenv.be](https://www.jenv.be/)

### 包管理器

- **Chocolatey** (Windows) - [chocolatey.org](https://chocolatey.org/)
- **Homebrew** (macOS/Linux) - [brew.sh](https://brew.sh/)

---

## 学习清单

使用以下清单确保开发环境完整配置：

### Java 环境
- [ ] 安装 JDK 17 或更高版本
- [ ] 配置 JAVA_HOME 环境变量
- [ ] 验证 java 和 javac 命令可用
- [ ] 运行检测脚本确认环境正常

### IDE 安装
- [ ] 安装 IntelliJ IDEA（推荐）或 Eclipse
- [ ] 配置 IDE 识别 JDK
- [ ] 安装常用插件
- [ ] 配置代码风格和编码设置

### 构建工具
- [ ] 安装 Maven 或 Gradle
- [ ] 配置本地仓库路径
- [ ] 验证构建工具可用

### 版本控制
- [ ] 安装 Git
- [ ] 配置用户信息（name 和 email）
- [ ] 生成 SSH 密钥（如需要）
- [ ] 连接 GitHub/GitLab

### 其他工具
- [ ] 安装终端工具（如 Windows Terminal）
- [ ] 配置命令行增强（如 Oh My Zsh）
- [ ] 安装 API 测试工具（Postman）

---

## 常见问题

### Q: 如何切换不同版本的 Java？

**使用 SDKMAN!（推荐）:**
```bash
sdk list java
sdk install java 17.0.9-tem
sdk default java 17.0.9-tem
```

**手动切换:**
修改 JAVA_HOME 环境变量指向新的 JDK 路径

### Q: IntelliJ IDEA 找不到 JDK？

1. File → Project Structure → SDKs
2. 点击 + 号 → Add JDK
3. 选择 JDK 安装目录
4. Apply 应用

### Q: 如何完全卸载 Java？

参考 [JAVA-INSTALL-GUIDE.md](JAVA-INSTALL-GUIDE.md#卸载-java) 章节

---

## 下一步

完成 Java 环境搭建后，建议继续学习：

1. **01. Java基础** - 学习 Java 核心语法和特性
2. **02. 设计模式** - 掌握常用设计模式
3. **03. 并发编程** - 深入理解多线程和并发

返回 [主目录](../README.md) 查看完整学习路径。

---

## 更新日志

- **2026-01-20** - 创建章节，添加检测脚本和安装指南
- **待更新** - 添加 IDE 配置指南、Maven/Gradle 安装指南

---

## 贡献

如果你有好的工具推荐或改进建议，欢迎提交 Issue 或 Pull Request！

---

**继续学习** → [01. Java基础](../01-Java基础/README.md)
