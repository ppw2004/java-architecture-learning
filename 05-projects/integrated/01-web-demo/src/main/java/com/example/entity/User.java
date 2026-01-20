package com.example.entity;

import lombok.Data;
import java.sql.Timestamp;

/**
 * 用户实体类
 */
@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private Integer age;
    private Timestamp createTime;
}
