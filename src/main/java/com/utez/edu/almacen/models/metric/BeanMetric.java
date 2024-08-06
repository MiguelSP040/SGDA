package com.utez.edu.almacen.models.metric;

public class BeanMetric {
    private Long id;
    private String name;
    private String shortName;
    private String status;

    public BeanMetric() {
    }

    public BeanMetric(Long id, String name, String shortName, String status) {
        this.id = id;
        this.name = name;
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

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
