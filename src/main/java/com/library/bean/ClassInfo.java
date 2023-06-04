package com.library.bean;

import java.io.Serializable;

public class ClassInfo implements Serializable {
    private int class_id;
    private String class_name;

    public int getId() {
        return class_id;
    }

    public void setId(int id) {
        this.class_id = id;
    }

    @Override
    public String toString() {
        return "ClassInfo{" +
                "id=" + class_id +
                ", name='" + class_name + '\'' +
                '}';
    }

    public String getName() {
        return class_name;
    }

    public void setName(String name) {
        this.class_name = name;
    }
}
