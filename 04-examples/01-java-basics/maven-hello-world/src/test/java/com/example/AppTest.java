package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * App类的测试
 */
class AppTest {

    @Test
    void testGreet() {
        App app = new App();
        app.greet("Java");
        // 如果没有抛出异常，测试通过
    }

    @Test
    void testAdd() {
        App app = new App();

        // 测试加法
        assertEquals(5, app.add(2, 3));
        assertEquals(0, app.add(0, 0));
        assertEquals(-1, app.add(2, -3));
    }

    @Test
    void testAddWithNegative() {
        App app = new App();
        assertEquals(-10, app.add(-5, -5));
    }
}
