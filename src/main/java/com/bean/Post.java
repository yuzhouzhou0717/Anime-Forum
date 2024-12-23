package com.bean;

import java.sql.Timestamp;

public class Post {
    private int postId;
    private int userId;
    private String postText;
    private Timestamp postDate;

    // 构造方法
    public Post() {
    }

    public Post(int userId, String postText) {
        this.userId = userId;
        this.postText = postText;
    }

    // Getter 和 Setter 方法
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPostText() {
        return postText;
    }

    public void setPostText(String postText) {
        this.postText = postText;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }
    public static boolean isPostValid(String postText) {
        // 在此添加评论的验证规则
        // 例如，评论内容不能包含敏感词汇等
        // 如果符合要求，返回 true；否则，返回 false
    	 return postText.length() >= 4; 
    }
}
