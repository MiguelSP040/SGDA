package com.utez.edu.almacen.models.storage;

public class BeanEntry {
    private Long idEntry;
    private String changeDate;
    private String invoiceNumber;
    private String folioNumber;
    private String userName;
    private String userSurname;
    private String providerName;
    private Double totalPrice;
    private String metricName;

    // Campos que podrían ser necesarios si se usan en el DAO para facilitar la asociación
    private int idUser;
    private int idProvider;
    private int idProduct;
    private int quantity;
    private double unitPrice;

    @Override
    public String toString() {
        return "BeanEntry{" +
                "idEntry=" + idEntry +
                ", changeDate='" + changeDate + '\'' +
                ", invoiceNumber='" + invoiceNumber + '\'' +
                ", folioNumber='" + folioNumber + '\'' +
                ", userName='" + userName + '\'' +
                ", userSurname='" + userSurname + '\'' +
                ", providerName='" + providerName + '\'' +
                ", totalPrice=" + totalPrice +
                ", metricName='" + metricName + '\'' +
                ", idUser=" + idUser +
                ", idProvider=" + idProvider +
                ", idProduct=" + idProduct +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                '}';
    }

    public BeanEntry() {
    }
        public BeanEntry(Long idEntry, String changeDate, String invoiceNumber, String folioNumber, Double totalPrice, String metricName, int idUser, int idProvider, int idProduct, int quantity, double unitPrice) {
        this.idEntry = idEntry;
        this.changeDate = changeDate;
        this.invoiceNumber = invoiceNumber;
        this.folioNumber = folioNumber;
        this.totalPrice = totalPrice;
        this.metricName = metricName;
        this.idUser = idUser;
        this.idProvider = idProvider;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }
    public BeanEntry(Long idEntry, String changeDate, String invoiceNumber, String folioNumber, String userName, String userSurname, String providerName, Double totalPrice, String metricName, int idUser, int idProvider, int idProduct, int quantity, double unitPrice) {
        this.idEntry = idEntry;
        this.changeDate = changeDate;
        this.invoiceNumber = invoiceNumber;
        this.folioNumber = folioNumber;
        this.userName = userName;
        this.userSurname = userSurname;
        this.providerName = providerName;
        this.totalPrice = totalPrice;
        this.metricName = metricName;
        this.idUser = idUser;
        this.idProvider = idProvider;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Getters and Setters
    public Long getIdEntry() {
        return idEntry;
    }

    public void setIdEntry(Long idEntry) {
        this.idEntry = idEntry;
    }

    public String getChangeDate() {
        return changeDate;
    }

    public void setChangeDate(String changeDate) {
        this.changeDate = changeDate;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public String getFolioNumber() {
        return folioNumber;
    }

    public void setFolioNumber(String folioNumber) {
        this.folioNumber = folioNumber;
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

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
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
