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
public class CategoryDTO implements Serializable {
    private String catID;
    private String name;

    public CategoryDTO() {
    }

    public CategoryDTO(String catID, String name) {
        this.catID = catID;
        this.name = name;
    }

    public void setCatID(String catID) {
        this.catID = catID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCatID() {
        return catID;
    }

    public String getName() {
        return name;
    }
        
}
