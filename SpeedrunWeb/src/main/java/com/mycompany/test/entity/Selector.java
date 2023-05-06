package com.mycompany.test.entity;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity(name="selector")
public class Selector {
    @Id
    private int postId;
    private int catagoryId;

    public Selector() {

    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getCatagoryId() {
        return catagoryId;
    }

    public void setCatagoryId(int catagoryId) {
        this.catagoryId = catagoryId;
    }
}
