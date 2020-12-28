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
public class LogDTO implements Serializable {
    private String logID;
    private String userID;
    private String productID;
    private Date date;

    public LogDTO() {
    }

    public LogDTO(String logID, String userID, String productID, Date date) {
        this.logID = logID;
        this.userID = userID;
        this.productID = productID;
        this.date = date;
    }

    public LogDTO(String userID, String productID, Date date) {
        this.userID = userID;
        this.productID = productID;
        this.date = date;
    }

    public String getLogID() {
        return logID;
    }

    public void setLogID(String logID) {
        this.logID = logID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
}
