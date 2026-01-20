package com.example;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

/**
 * Maven Hello World 示例
 *
 * @author Your Name
 * @date 2026-01-20
 */
@Slf4j
public class App {

    public static void main(String[] args) {
        log.info("Maven Hello World 项目启动！");

        // 创建App实例
        App app = new App();

        // 示例1：基本问候
        app.greet("World");

        // 示例2：使用StringUtils（来自Maven依赖）
        String empty = "";
        if (StringUtils.isEmpty(empty)) {
            log.info("字符串为空（使用Apache Commons Lang3）");
        }

        // 示例3：使用Lombok @Slf4j
        log.info("使用Lombok的@Slf4j注解记录日志");

        // 示例4：计算两个数的和
        int result = app.add(10, 20);
        log.info("10 + 20 = {}", result);

        log.info("Maven Hello World 项目结束！");
    }

    /**
     * 问候方法
     *
     * @param name 名字
     */
    public void greet(String name) {
        if (StringUtils.isEmpty(name)) {
            name = "World";
        }
        System.out.println("Hello, " + name + "!");
    }

    /**
     * 加法运算
     *
     * @param a 第一个数
     * @param b 第二个数
     * @return 两数之和
     */
    public int add(int a, int b) {
        return a + b;
    }
}
