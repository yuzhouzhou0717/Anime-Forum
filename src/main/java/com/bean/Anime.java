package com.bean;

public class Anime {
    private int id;
    private String name;
    private String imagePath;
    private String description;
    private String tags;

    // 无参构造函数
    public Anime() {
    }

    // 带参构造函数
    public Anime(int id, String name, String imagePath, String description, String tags) {
        this.id = id;
        this.name = name;
        this.imagePath = imagePath;
        this.description = description;
        this.tags = tags;
    }

    // Getter和Setter方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }
}
