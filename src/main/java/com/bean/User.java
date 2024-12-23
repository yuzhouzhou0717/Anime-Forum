package com.bean;

public class User {
    private Integer uid;
    private String username;
    private String password;
    private int key;
 
    public User() {
    }
    public User(Integer uid, String username, String password,int key) {
        this.uid = uid;
        this.username = username;
        this.password = password;
        this.key = key;
    }
    public Integer getUserId() {
        return uid;
    }
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
 
    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }
    public int getkey() {
        return key;
    }
 
    public void setkey(int key) {
        this.key = key;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", key ='" + key +'}';
    
    }
}
