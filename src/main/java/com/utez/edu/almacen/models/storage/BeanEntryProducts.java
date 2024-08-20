package com.utez.edu.almacen.models.storage;

public class BeanEntryProducts {
    private Long idProductEntry;
    private Long idEntry;
    private Long idProduct;
    private int quantity;
    private double unitPrice;
    private double totalPrice;

    public BeanEntryProducts() {
    }

    public BeanEntryProducts(Long idProductEntry, Long idEntry, Long idProduct, int quantity, double unitPrice, double totalPrice) {
        this.idProductEntry = idProductEntry;
        this.idEntry = idEntry;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    public Long getIdProductEntry() {
        return idProductEntry;
    }

    public void setIdProductEntry(Long idProductEntry) {
        this.idProductEntry = idProductEntry;
    }

    public Long getIdEntry() {
        return idEntry;
    }

    public void setIdEntry(Long idEntry) {
        this.idEntry = idEntry;
    }

    public Long getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Long idProduct) {
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

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}