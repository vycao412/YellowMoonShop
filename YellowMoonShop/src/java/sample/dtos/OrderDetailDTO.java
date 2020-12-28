/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;

/**
 *
 * @author VYCAO
 */
public class OrderDetailDTO implements Serializable {
    private String detailID;
    private String orderID;
    private String productID;
    private float price;
    private int quantity;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String detailID, String orderID, String productID, float price, int quantity) {
        this.detailID = detailID;
        this.orderID = orderID;
        this.productID = productID;
        this.price = price;
        this.quantity = quantity;
    }

    public void setDetailID(String detailID) {
        this.detailID = detailID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDetailID() {
        return detailID;
    }

    public String getOrderID() {
        return orderID;
    }

    public String getProductID() {
        return productID;
    }

    public float getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }
    
}
