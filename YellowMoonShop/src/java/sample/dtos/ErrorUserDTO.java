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
public class ErrorUserDTO implements Serializable {
    private String errorUserID;
    private String errorName;
    private String errorPassword;
    private String errorRePassword;
     private String errorAddress;
    private String errorPhone;    
    

    public ErrorUserDTO() {
    }

    public ErrorUserDTO(String errorUserID, String errorName, String errorPassword, String errorRePassword, String errorAddress, String errorPhone) {
        this.errorUserID = errorUserID;
        this.errorName = errorName;
        this.errorPassword = errorPassword;
        this.errorRePassword = errorRePassword;
        this.errorAddress = errorAddress;
        this.errorPhone = errorPhone;
    }

    public String getErrorUserID() {
        return errorUserID;
    }

    public void setErrorUserID(String errorUserID) {
        this.errorUserID = errorUserID;
    }

    public String getErrorName() {
        return errorName;
    }

    public void setErrorName(String errorName) {
        this.errorName = errorName;
    }

    public String getErrorPassword() {
        return errorPassword;
    }

    public void setErrorPassword(String errorPassword) {
        this.errorPassword = errorPassword;
    }

    public String getErrorRePassword() {
        return errorRePassword;
    }

    public void setErrorRePassword(String errorRePassword) {
        this.errorRePassword = errorRePassword;
    }

    public String getErrorAddress() {
        return errorAddress;
    }

    public void setErrorAddress(String errorAddress) {
        this.errorAddress = errorAddress;
    }

    public String getErrorPhone() {
        return errorPhone;
    }

    public void setErrorPhone(String errorPhone) {
        this.errorPhone = errorPhone;
    }
    
}
