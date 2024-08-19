
package com.utez.edu.almacen.models.storage;

public class BeanEntry {
    private int idEntry;
    private String changeDate;
    private String folioNumber;
    private String invoiceNumber;
    private String productName;
    private double totalPrice;
    private String providerName;
    private String userName;
    private String userSurname;
    private String metricName;
    private int idUser;
    private int idProvider;
    private int idProduct;
    private int quantity;
    private double unitPrice;

    public BeanEntry() {
    }

    public BeanEntry(int idEntry, String changeDate, String folioNumber, String invoiceNumber, String productName, int quantity, double unitPrice, double totalPrice, String providerName, String userName, String userSurname, String metricName) {
        this.idEntry = idEntry;
        this.changeDate = changeDate;
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.productName = productName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.providerName = providerName;
        this.userName = userName;
        this.userSurname = userSurname;
        this.metricName = metricName;
    }

    public BeanEntry(String folioNumber, String invoiceNumber, int idUser, int idProvider, int idProduct, int quantity, double unitPrice) {
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.idUser = idUser;
        this.idProvider = idProvider;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getIdEntry() {
        return idEntry;
    }

    public void setIdEntry(int idEntry) {
        this.idEntry = idEntry;
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

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdProvider() {
        return idProvider;
    }

    public void setIdProvider(int idProvider) {
        this.idProvider = idProvider;
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
