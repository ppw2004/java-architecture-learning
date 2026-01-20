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
