package com.bean;

public class Comment {
    private int commentId;
    private int userId;
    private int animeId;
    private String content;

    // 默认构造函数
    public Comment() {
    }

    // 带参构造函数
    public Comment(int commentId, int userId, String content) {
        this.commentId = commentId;
        this.userId = userId;
        this.animeId = animeId;
        this.content = content;
    }

    // Getter 和 Setter 方法

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    public int getAnimeId() {
        return animeId;
    }

    public void setAnimeId(int animeId) {
        this.animeId = animeId;
    }
    public static boolean isCommentValid(String content) {
        // 在此添加评论的验证规则
        // 例如，评论内容不能包含敏感词汇等
        // 如果符合要求，返回 true；否则，返回 false
    	 return content.length() >= 4; 
    }
}
