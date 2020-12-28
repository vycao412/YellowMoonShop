/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import org.apache.log4j.Logger;
import sample.dtos.UserDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class UserDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(UserDAO.class);
    
    public UserDTO checkLogin(String userID, String password) throws NamingException, SQLException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name,phone,address,roleID,status FROM tblUser WHERE userID=? AND password=? AND status='Active'";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String roleID = rs.getString("roleID");
                    String status = rs.getString("status");
                    result = new UserDTO(userID, name, "", address, phone, roleID, status);
                }
            }
        } catch (Exception e) {
            LOG.error("Error at checkLogin of UserDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
   
    public boolean checkID(String userID) throws NamingException, SQLException {
        boolean result = true;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name FROM tblUser WHERE userID='" + userID + "'";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = false;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at checkID of UserDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
    
    public void create(UserDTO dto) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stm = null;

        LOG.info("create of UserDAO");
        
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUser(userID,name,password,address,phone,roleID,status) VALUES(?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getName());
                stm.setString(3, dto.getPassword());
                stm.setString(4, dto.getAddress());               
                stm.setString(5, dto.getPhone());
                stm.setString(6, dto.getRoleID());
                stm.setString(7, dto.getStatus());
                stm.executeUpdate();
            }
        } catch (Exception e) {
            LOG.error("Error at Create of UserDAO: " + e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
   
    
}
