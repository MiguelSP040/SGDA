package com.utez.edu.almacen.models.product;

public class BeanProduct {
    private Long id;
    private Long IdStock;
    private String name;
    private String code;
    private String description;
    private String id_metric;
    private String metricName;
    private Long idProvider;
    private String providerName;
    private int quantity;
    private Boolean status;

    public BeanProduct() {
    }

    public BeanProduct(Long id, String name, String code, String metricName, String providerName, int quantity) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.metricName = metricName;
        this.providerName = providerName;
        this.quantity = quantity;
    }

    public BeanProduct(Long id, Long idStock, String name, String code, String metricName, String providerName, int quantity) {
        this.id = id;
        this.IdStock = idStock;
        this.name = name;
        this.code = code;
        this.metricName = metricName;
        this.providerName = providerName;
        this.quantity = quantity;
    }

    public BeanProduct(Long id, String name, String code, String description, String id_metric, Boolean status) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.description = description;
        this.id_metric = id_metric;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getId_metric() {
        return id_metric;
    }

    public void setId_metric(String id_metric) {
        this.id_metric = id_metric;
    }

    public String getMetricName() {
        return metricName;
    }

    public void setMetricName(String metricName) {
        this.metricName = metricName;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Long getIdStock() {
        return IdStock;
    }

    public void setIdStock(Long idStock) {
        IdStock = idStock;
    }

    public Long getIdProvider() {
        return idProvider;
    }

    public void setIdProvider(Long idProvider) {
        this.idProvider = idProvider;
    }
}
