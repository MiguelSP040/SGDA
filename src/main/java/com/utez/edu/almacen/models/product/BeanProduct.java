package com.utez.edu.almacen.models.product;

public class BeanProduct {
    private Long id_product;
    private String name;
    private String description;
    private String code;

    public BeanProduct() {
    }

    public BeanProduct(Long id_product, String name, String description, String code) {
        this.id_product = id_product;
        this.name = name;
        this.description = description;
        this.code = code;
    }

    public Long getId_product() {
        return id_product;
    }

    public void setId_product(Long id_product) {
        this.id_product = id_product;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
