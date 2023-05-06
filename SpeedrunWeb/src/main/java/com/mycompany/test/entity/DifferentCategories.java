package com.mycompany.test.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity(name="DifferentCategories")
public class DifferentCategories {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int id;
    private String categoryName;

    public DifferentCategories() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "DifferentCategories{" +
                "id=" + id +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}
