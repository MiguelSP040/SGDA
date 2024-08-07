package com.utez.edu.almacen.models.area;

public class BeanArea {
    private Long id;
    private String name;
    private String description;
    private String shortName;
    private Boolean status;

    public BeanArea() {
    }

    public BeanArea(Long id, String name, String description, String shortName, boolean status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.shortName = shortName;
        this.status = status;
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

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
