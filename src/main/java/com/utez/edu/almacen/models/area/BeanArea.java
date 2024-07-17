package com.utez.edu.almacen.models.area;

public class BeanArea {
    private Long id;
    private String name;
    private String description;
    private String shortName;

    public BeanArea() {
    }

    public BeanArea(Long id, String name, String description, String shortName) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.shortName = shortName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }
}
