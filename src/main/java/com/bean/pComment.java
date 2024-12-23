package com.bean;

public class pComment {
    private int pcommentId;
    private int userId;
    private int postId;
    private String pcommnet;

    // 默认构造函数
    public pComment() {
    }


    // Getter 和 Setter 方法

    public int getpCommentId() {
        return pcommentId;
    }

    public void setpCommentId(int pcommentId) {
        this.pcommentId = pcommentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPcommnet() {
        return pcommnet;
    }

    public void setPcommnet(String pcommnet) {
        this.pcommnet = pcommnet;
    }
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

}
