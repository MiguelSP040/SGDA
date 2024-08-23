package com.utez.edu.almacen.models.storage;

public class BeanExitProducts {
    private Long idProductExit;
    private Long idExit;
    private Long idProduct;
    private int quantity;
    private double unitPrice;
    private double totalPrice;

    public BeanExitProducts() {
    }

    public BeanExitProducts(Long idProductExit, Long idExit, Long idProduct, int quantity, double unitPrice, double totalPrice) {
        this.idProductExit = idProductExit;
        this.idExit = idExit;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    public Long getIdProductExit() {
        return idProductExit;
    }

    public void setIdProductExit(Long idProductExit) {
        this.idProductExit = idProductExit;
    }

    public Long getIdExit() {
        return idExit;
    }

    public void setIdExit(Long idExit) {
        this.idExit = idExit;
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

    @Override
    public String toString() {
        return "BeanExitProducts{" +
                "idProductExit=" + idProductExit +
                ", idExit=" + idExit +
                ", idProduct=" + idProduct +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
