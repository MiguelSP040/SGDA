package com.utez.edu.almacen.models.storage;

public class BeanExit {
    private Long idExit;
    private String changeDate;
    private String folioNumber;
    private String invoiceNumber;
    private int idProvider;
    private String providerName;
    private int idUser;
    private String userName;
    private int idArea;
    private String areaName;
    private String buyerName;
    private Double totalAllPrices;

    // Campos que podrían ser necesarios si se usan en el DAO para facilitar la asociación con la tabla entry products
    private int idProduct;
    private String productName;
    private String metricName;
    private double unitPrice;
    private int quantity;
    private Double totalPrice;

    public BeanExit() {
    }

    public BeanExit(Long idExit, String changeDate, String folioNumber, String invoiceNumber, int idProvider, String providerName, int idUser, String userName, int idArea, String areaName, String buyerName, Double totalAllPrices, int idProduct, String productName, String metricName, double unitPrice, int quantity, Double totalPrice) {
        this.idExit = idExit;
        this.changeDate = changeDate;
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.idProvider = idProvider;
        this.providerName = providerName;
        this.idUser = idUser;
        this.userName = userName;
        this.idArea = idArea;
        this.areaName = areaName;
        this.buyerName = buyerName;
        this.totalAllPrices = totalAllPrices;
        this.idProduct = idProduct;
        this.productName = productName;
        this.metricName = metricName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    public Long getIdExit() {
        return idExit;
    }

    public void setIdExit(Long idExit) {
        this.idExit = idExit;
    }

    public String getChangeDate() {
        return changeDate;
    }

    public void setChangeDate(String changeDate) {
        this.changeDate = changeDate;
    }

    public String getFolioNumber() {
        return folioNumber;
    }

    public void setFolioNumber(String folioNumber) {
        this.folioNumber = folioNumber;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public int getIdProvider() {
        return idProvider;
    }

    public void setIdProvider(int idProvider) {
        this.idProvider = idProvider;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getIdArea() {
        return idArea;
    }

    public void setIdArea(int idArea) {
        this.idArea = idArea;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public Double getTotalAllPrices() {
        return totalAllPrices;
    }

    public void setTotalAllPrices(Double totalAllPrices) {
        this.totalAllPrices = totalAllPrices;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getMetricName() {
        return metricName;
    }

    public void setMetricName(String metricName) {
        this.metricName = metricName;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "BeanExit{" +
                "idExit=" + idExit +
                ", changeDate='" + changeDate + '\'' +
                ", folioNumber='" + folioNumber + '\'' +
                ", invoiceNumber='" + invoiceNumber + '\'' +
                ", idUser=" + idUser +
                ", userName='" + userName + '\'' +
                ", idArea=" + idArea +
                ", areaName='" + areaName + '\'' +
                ", buyerName='" + buyerName + '\'' +
                ", totalAllPrices=" + totalAllPrices +
                ", idProduct=" + idProduct +
                ", productName='" + productName + '\'' +
                ", metricName='" + metricName + '\'' +
                ", unitPrice=" + unitPrice +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
