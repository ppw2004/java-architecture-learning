# 示例代码

## 目录说明

本目录存放可运行的示例代码，按知识点组织。每个示例都是完整可运行的独立程序。

### 文件结构

```
04-examples/
├── README.md                        # 本文件
├── 01-java-basics/                  # Java基础示例
│   ├── collections/                 # 集合示例
│   ├── io/                          # IO示例
│   ├── thread/                      # 线程示例
│   └── ...
├── 02-design-patterns/              # 设计模式示例
│   ├── singleton/                   # 单例模式
│   ├── factory/                     # 工厂模式
│   └── ...
├── 03-concurrency/                  # 并发编程示例
└── ...
```

## 代码规范

每个示例应包含：

1. **清晰的类名和包名**
2. **详细的注释**：说明代码的目的和关键点
3. **可运行**：确保代码能编译和运行
4. **有输出**：打印运行结果，方便理解
5. **README**：复杂示例需要说明文档

## 示例模板

```java
package com.example.xxx;

/**
 * [类/功能的简要说明]
 *
 * @author Your Name
 * @date 2026-01-20
 */
public class Example {

    public static void main(String[] args) {
        // 示例代码
        System.out.println("运行结果：");
    }
}
```

## 使用方式

```bash
# 编译
javac Example.java

# 运行
java Example

# 或使用Maven/Gradle
mvn compile exec:java
```
