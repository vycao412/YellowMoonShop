/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashMap;

/**
 *
 * @author VYCAO
 */
public class CartDTO implements Serializable {

    private String id;
    private HashMap<String, ProductDTO> cart;
    private float total;
    private String userID;
    private String name;
    private String phone;
    private String address;
    private Date date;
    private String paymentMethod;
    private int paymentStatus;

    public CartDTO() {
        cart = new HashMap<String, ProductDTO>();
        total = 0;
        userID = null;
        paymentMethod = "Cash";
        paymentStatus = 4;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public HashMap<String, ProductDTO> getCart() {
        return cart;
    }

    public void setCart(HashMap<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public void add(ProductDTO product) {
        String productID = product.getProductID();
        int quantity = 1;
        if (cart.containsKey(productID)) {
            quantity = cart.get(productID).getQuantity() + 1;
        }
        product.setQuantity(quantity);
        total += product.getPrice();
        cart.put(productID, product);
    }
    
    public void update(String productID, int quantity) {
        for (String proID : cart.keySet()) {
            if (proID.equals(productID)) {
                int amount = cart.get(productID).getQuantity();
                cart.get(productID).setQuantity(quantity);
                total += (quantity - amount) * cart.get(productID).getPrice();
                break;
            }
        }
    }
    
    public void remove(String productID) {
        for (ProductDTO product : cart.values()) {
            if (product.getProductID().equals(productID)) {
                total -= product.getQuantity() * product.getPrice();
                break;
            }
        }
        cart.remove(productID);
    }
    
}
