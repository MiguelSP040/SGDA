package com.utez.edu.almacen.models.storage;

public class BeanEntry {
    private Long idEntry;
    private String changeDate;
    private String folioNumber;
    private String invoiceNumber;
    private int idProvider;
    private String providerName;
    private int idUser;
    private String userName;
    private Double totalAllPrices;

    // Campos que podrían ser necesarios si se usan en el DAO para facilitar la asociación con la tabla entry products
    private int idProduct;
    private String productName;
    private String metricName;
    private double unitPrice;
    private int quantity;
    private Double totalPrice;

    // Constructor vacío
    public BeanEntry() {
    }

    // Constructor con todos los campos
    public BeanEntry(Long idEntry, String changeDate, String folioNumber, String invoiceNumber, int idProvider, String providerName, int idUser, String userName, Double totalAllPrices, int idProduct, String productName, String metricName, double unitPrice, int quantity, Double totalPrice) {
        this.idEntry = idEntry;
        this.changeDate = changeDate;
        this.folioNumber = folioNumber;
        this.invoiceNumber = invoiceNumber;
        this.idProvider = idProvider;
        this.providerName = providerName;
        this.idUser = idUser;
        this.userName = userName;
        this.totalAllPrices = totalAllPrices;
        this.idProduct = idProduct;
        this.productName = productName;
        this.metricName = metricName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // Constructor para registro de entradas
    public BeanEntry(Long idEntry, String changeDate, String invoiceNumber, String folioNumber, Double totalAllPrices, Integer idUser, Integer idProvider) {
        this.idEntry = idEntry;
        this.changeDate = changeDate;
        this.invoiceNumber = invoiceNumber;
        this.folioNumber = folioNumber;
        this.totalAllPrices = totalAllPrices;
        this.idUser = idUser;
        this.idProvider = idProvider;
    }

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

    // Método para generar una cadena de texto representativa del objeto
    @Override
    public String toString() {
        return "BeanEntry{" +
                "idEntry=" + idEntry +
                ", changeDate='" + changeDate + '\'' +
                ", folioNumber='" + folioNumber + '\'' +
                ", invoiceNumber='" + invoiceNumber + '\'' +
                ", idProvider=" + idProvider +
                ", providerName='" + providerName + '\'' +
                ", idUser=" + idUser +
                ", userName='" + userName + '\'' +
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
