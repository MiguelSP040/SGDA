
package com.utez.edu.almacen.models.storage;

public class BeanExit {
    private int idExit;
    private String changeDate;
    private String folioNumber;
    private String invoiceNumber;
    private String productName;
    private double totalPrice;
    private String providerName;
    private String userName;
    private String userSurname;
    private String metricName;
    private String areaName;
    private String buyerName;
    private int idUser;
    private int idArea;
    private int idProduct;
    private int quantity;
    private double unitPrice;

    public BeanExit() {
    }

    public BeanExit(int idExit, String changeDate, String invoiceNumber, String folioNumber, int idUser, String userName, String userSurname, int idArea, String areaName, String buyerName, int idProduct, String productName, String metricName, int quantity, double unitPrice, double totalPrice ) {
        this.idExit = idExit;
        this.changeDate = changeDate;
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.productName = productName;
        this.totalPrice = totalPrice;
        this.userName = userName;
        this.userSurname = userSurname;
        this.metricName = metricName;
        this.areaName = areaName;
        this.buyerName = buyerName;
        this.idUser = idUser;
        this.idArea = idArea;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public BeanExit(String folioNumber, String invoiceNumber, int idUser, int idArea, String buyerName, int idProduct, int quantity, double unitPrice) {
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.idUser = idUser;
        this.idArea = idArea;
        this.buyerName = buyerName;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getIdExit() {
        return idExit;
    }

    public void setIdExit(int idExit) {
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserSurname() {
        return userSurname;
    }

    public void setUserSurname(String userSurname) {
        this.userSurname = userSurname;
    }

    public String getMetricName() {
        return metricName;
    }

    public void setMetricName(String metricName) {
        this.metricName = metricName;
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

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdArea() {
        return idArea;
    }

    public void setIdArea(int idArea) {
        this.idArea = idArea;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
}
