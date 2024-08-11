package com.utez.edu.almacen.models.product;

public class BeanProduct {
    private Long id;
    private String name;
    private String code;
    private String description;
    private String id_metric;
    private Boolean status;

    public BeanProduct() {
    }

    public BeanProduct(Long id, String name, String code, String description, String id_metric, Boolean status) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.description = description;
        this.id_metric = id_metric;
        this.status = status;
    }

    public Long getId() {return id;}

    public void setId(Long id) {this.id = id;}

    public String getName() {return name;}

    public void setName(String name) {this.name = name;}

    public String getCode() {return code;}

    public void setCode(String code) {this.code = code;}

    public String getDescription() {return description;}

    public void setDescription(String description) {this.description = description;}

    public String getId_metric() {return id_metric;}

    public void setId_metric(String id_metric) {this.id_metric = id_metric;}

    public Boolean getStatus() {return status;}

    public void setStatus(Boolean status) {this.status = status;}
}
