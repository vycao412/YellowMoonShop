/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author VYCAO
 */
public class ProductDTO implements Serializable {
    private String productID;
    private String name;
    private float price;
    private int quantity;
    private String categoryID;
    private String image;
    private String description;
    private Date createDate;
    private Date expiredDate;
    private int status;

    public ProductDTO() {
    }

    public ProductDTO(String productID, String name, float price, int quantity, String categoryID, String image, String description, Date createDate, Date expiredDate, int status) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.categoryID = categoryID;
        this.image = image;
        this.description = description;
        this.createDate = createDate;
        this.expiredDate = expiredDate;
        this.status = status;
    }

    public ProductDTO(String name, float price, int quantity, String categoryID, String image, String description, Date createDate, Date expiredDate, int status) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.categoryID = categoryID;
        this.image = image;
        this.description = description;
        this.createDate = createDate;
        this.expiredDate = expiredDate;
        this.status = status;
    }

    public ProductDTO(String productID, String name, float price, int quantity) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
}
