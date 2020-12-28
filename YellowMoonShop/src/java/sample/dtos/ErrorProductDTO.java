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
public class ErrorProductDTO implements Serializable {
    private String errorName;
    private String errorPrice;
    private String errorQuantity;
    private String errorImage;
    private String errorDescription;
    private String errorCreateDate;
    private String errorExpiredDate;

    public ErrorProductDTO() {
    }

    public ErrorProductDTO(String errorName, String errorPrice, String errorQuantity, String errorImage, String errorDescription, String errorCreateDate, String errorExpiredDate) {
        this.errorName = errorName;
        this.errorPrice = errorPrice;
        this.errorQuantity = errorQuantity;
        this.errorImage = errorImage;
        this.errorDescription = errorDescription;
        this.errorCreateDate = errorCreateDate;
        this.errorExpiredDate = errorExpiredDate;
    }

    public String getErrorName() {
        return errorName;
    }

    public void setErrorName(String errorName) {
        this.errorName = errorName;
    }

    public String getErrorPrice() {
        return errorPrice;
    }

    public void setErrorPrice(String errorPrice) {
        this.errorPrice = errorPrice;
    }

    public String getErrorQuantity() {
        return errorQuantity;
    }

    public void setErrorQuantity(String errorQuantity) {
        this.errorQuantity = errorQuantity;
    }

    public String getErrorImage() {
        return errorImage;
    }

    public void setErrorImage(String errorImage) {
        this.errorImage = errorImage;
    }

    public String getErrorDescription() {
        return errorDescription;
    }

    public void setErrorDescription(String errorDescription) {
        this.errorDescription = errorDescription;
    }

    public String getErrorCreateDate() {
        return errorCreateDate;
    }

    public void setErrorCreateDate(String errorCreateDate) {
        this.errorCreateDate = errorCreateDate;
    }

    public String getErrorExpiredDate() {
        return errorExpiredDate;
    }

    public void setErrorExpiredDate(String errorExpiredDate) {
        this.errorExpiredDate = errorExpiredDate;
    }
    
}
