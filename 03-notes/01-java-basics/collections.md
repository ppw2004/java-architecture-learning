# Java集合框架

## 📚 概念理解

Java集合框架提供了一套性能优良、使用方便的接口和类，用于存储和操作对象组。主要包括Collection和Map两大接口体系。

## 🎯 核心要点

### 1. 集合体系结构
```
Collection (接口)
├── List (接口) - 有序，可重复
│   ├── ArrayList - 数组实现，查询快
│   ├── LinkedList - 链表实现，增删快
│   └── Vector - 线程安全（已过时）
├── Set (接口) - 无序，不可重复
│   ├── HashSet - 哈希表实现
│   ├── TreeSet - 红黑树实现，有序
│   └── LinkedHashSet - 保持插入顺序
└── Queue (接口) - 队列

Map (接口) - 键值对
├── HashMap - 哈希表实现
├── TreeMap - 红黑树实现，有序
├── LinkedHashMap - 保持插入顺序
└── ConcurrentHashMap - 线程安全
```

### 2. 核心区别

| 集合 | 数据结构 | 查询 | 增删 | 线程安全 | 特点 |
|------|---------|------|------|----------|------|
| ArrayList | 数组 | O(1) | O(n) | 否 | 随机访问快 |
| LinkedList | 双向链表 | O(n) | O(1) | 否 | 增删快 |
| HashMap | 数组+链表+红黑树 | O(1) | O(1) | 否 | 键值对存储 |
| ConcurrentHashMap | 数组+链表+红黑树 | O(1) | O(1) | 是 | CAS+synchronized |

## 💡 AI指导

### Q1: ArrayList和LinkedList如何选择？

**A**：
- **选ArrayList**：频繁查询、随机访问
- **选LinkedList**：频繁在头尾插入删除（如队列、栈）

大多数情况ArrayList性能更好，因为：
1. CPU缓存友好（连续内存）
2. 查询快O(1)
3. 扩容时只需要复制一次

### Q2: HashMap的put过程？

**A**：
1. 计算key的hash值
2. 找到数组下标：(n-1) & hash
3. 如果该位置无数据，直接插入
4. 如果有数据，遍历链表/红黑树：
   - key相同则覆盖value
   - key不同则插入新节点
5. 判断是否需要扩容（size > threshold）
6. 如果链表长度>8且数组长度>64，转为红黑树

### Q3: ConcurrentHashMap如何保证线程安全？

**A**：JDK 1.8采用**CAS + synchronized**
- 只锁住数组的一个节点（分段锁）
- 不像JDK 1.7那样分段锁粒度更大
- 读操作无锁
- 写操作只锁当前节点

## 💻 示例代码

### 示例1：ArrayList使用

```java
import java.util.*;

public class ArrayListExample {
    public static void main(String[] args) {
        // 创建ArrayList
        List<String> list = new ArrayList<>();

        // 添加元素
        list.add("Java");
        list.add("Python");
        list.add("Go");

        // 遍历方式1：for循环
        System.out.println("方式1：for循环");
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
        }

        // 遍历方式2：增强for
        System.out.println("\n方式2：增强for");
        for (String lang : list) {
            System.out.println(lang);
        }

        // 遍历方式3：Iterator
        System.out.println("\n方式3：Iterator");
        Iterator<String> it = list.iterator();
        while (it.hasNext()) {
            System.out.println(it.next());
        }

        // 遍历方式4：Lambda
        System.out.println("\n方式4：Lambda");
        list.forEach(System.out::println);

        // 删除元素
        list.remove("Python");
        System.out.println("\n删除后：" + list);

        // 判断包含
        System.out.println("包含Java？" + list.contains("Java"));

        // 转数组
        String[] arr = list.toArray(new String[0]);
    }
}
```

### 示例2：HashMap使用

```java
import java.util.*;

public class HashMapExample {
    public static void main(String[] args) {
        // 创建HashMap
        Map<String, Integer> map = new HashMap<>();

        // 添加键值对
        map.put("Java", 100);
        map.put("Python", 90);
        map.put("Go", 85);

        // 遍历方式1：entrySet
        System.out.println("方式1：entrySet");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getKey() + " = " + entry.getValue());
        }

        // 遍历方式2：keySet
        System.out.println("\n方式2：keySet");
        for (String key : map.keySet()) {
            System.out.println(key + " = " + map.get(key));
        }

        // 遍历方式3：forEach+Lambda
        System.out.println("\n方式3：Lambda");
        map.forEach((k, v) -> System.out.println(k + " = " + v));

        // 判断包含
        System.out.println("\n包含key 'Java'？" + map.containsKey("Java"));
        System.out.println("包含value 100？" + map.containsValue(100));

        // getOrDefault
        int score = map.getOrDefault("C++", 0);
        System.out.println("\nC++分数：" + score);

        // putIfAbsent
        map.putIfAbsent("Java", 99);  // 不会覆盖
        System.out.println("Java分数：" + map.get("Java"));
    }
}
```

### 示例3：HashSet去重

```java
import java.util.*;

public class HashSetExample {
    public static void main(String[] args) {
        List<Integer> list = Arrays.asList(1, 2, 3, 2, 1, 4, 5, 3);

        // 使用HashSet去重
        Set<Integer> set = new HashSet<>(list);
        System.out.println("去重后：" + set);

        // List去重（保持顺序用LinkedHashSet）
        Set<Integer> linkedSet = new LinkedHashSet<>(list);
        List<Integer> uniqueList = new ArrayList<>(linkedSet);
        System.out.println("保持顺序去重：" + uniqueList);
    }
}
```

## 📝 学习心得

1. **ArrayList是最常用的**：大多数情况选ArrayList
2. **HashMap核心是哈希表**：要理解hash冲突如何解决
3. **遍历优先用Lambda**：代码简洁，性能好
4. **Set用于去重**：常用HashSet或LinkedHashSet

## ❓ 疑问与解答

**Q**：为什么HashMap初始容量推荐是2的幂次方？

**A**：为了让(n-1) & hash更均匀分布，减少hash冲突。2的幂次方减1的二进制全是1（如15=1111），这样hash值的低位能直接参与计算。

## 🔗 相关资源

- [ ] [Java集合框架官方文档](https://docs.oracle.com/javase/8/docs/technotes/collections/index.html)
- [ ] ArrayList源码（java.util.ArrayList）
- [ ] HashMap源码（java.util.HashMap）

## ✅ 练习题

### 练习1：学生管理系统
使用ArrayList实现学生管理系统，要求：
- 添加学生（姓名、年龄、成绩）
- 根据姓名删除学生
- 查询所有学生
- 根据成绩排序

### 练习2：词频统计
给定一段文本，统计每个词出现的次数，使用HashMap实现。

### 练习3：手写ArrayList
实现一个简单的ArrayList，包含：
- add() 方法
- get() 方法
- size() 方法
- 动态扩容

---

**学习时间**：2小时
**掌握程度**：⭐⭐⭐ (3/5)
**复习时间**：2026-01-23, 2026-01-30
