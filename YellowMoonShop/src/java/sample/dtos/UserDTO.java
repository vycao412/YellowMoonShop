/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

/**
 *
 * @author VYCAO
 */
public class UserDTO implements Serializable {
    @SerializedName(value = "id")
    private String userID;
    @SerializedName(value = "name")
    private String name;
    private String password;
    private String address;   
    private String phone;   
    private String roleID;
    private String status;
    
    public UserDTO() {
    }

    public UserDTO(String userID, String name, String password, String address, String phone, String roleID, String status) {
        this.userID = userID;
        this.name = name;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.roleID = roleID;
        this.status = status;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    
    
}
