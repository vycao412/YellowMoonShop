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
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;
import sample.dtos.ProductDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class CartDAO implements Serializable{

    private static final Logger LOG = Logger.getLogger(CartDAO.class);

    public void add(CartDTO dto) throws SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("add of CartDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "INSERT INTO tblOrder(orderID,userID,total,date,name,phone,address,paymentMethod,status)"
                        + " VALUES(?,?,?,?,?,?,?,?,?)";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getId());
                stm.setString(2, dto.getUserID());
                stm.setFloat(3, dto.getTotal());
                stm.setDate(4, dto.getDate());
                stm.setString(5, dto.getName());
                stm.setString(6, dto.getPhone());
                stm.setString(7, dto.getAddress());
                stm.setString(8, dto.getPaymentMethod());
                stm.setInt(9, dto.getPaymentStatus());

                stm.executeUpdate();

                for (ProductDTO product : dto.getCart().values()) {
                    sql = "INSERT INTO tblOrderDetail(orderID,productID,price,quantity) VALUES (?,?,?,?)";
                    stm = cnn.prepareStatement(sql);
                    stm.setString(1, dto.getId());
                    stm.setString(2, product.getProductID());
                    stm.setFloat(3, product.getPrice());
                    stm.setInt(4, product.getQuantity());

                    stm.executeUpdate();
                }
            }
        } catch (Exception e) {
            LOG.error("Error at add of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
    }

    public CartDTO search(String orderID) throws SQLException {
        CartDTO result = null;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("search of CartDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql1 = "SELECT orderID,userID,total,date,name,phone,address,paymentMethod,status"
                        + " FROM tblOrder WHERE orderID=?";
                stm = cnn.prepareStatement(sql1);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = new CartDTO();
                    result.setId(orderID);
                    result.setUserID(rs.getString("userID"));
                    result.setTotal(rs.getFloat("total"));
                    result.setDate(rs.getDate("date"));
                    result.setName(rs.getString("name"));
                    result.setAddress(rs.getString("address"));
                    result.setPhone(rs.getString("phone"));
                    result.setPaymentMethod(rs.getString("paymentMethod"));
                    result.setPaymentStatus(rs.getInt("status"));
                }

                String sql2 = "SELECT tblOrderDetail.productID,tblProduct.name,tblOrderDetail.price,tblOrderDetail.quantity"
                        + " FROM tblOrderDetail JOIN tblProduct ON tblOrderDetail.productID = tblProduct.productID AND tblOrderDetail.orderID=?";
                stm = cnn.prepareStatement(sql2);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");

                    result.getCart().put(productID, new ProductDTO(productID, name, price, quantity));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at search of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }
    
    public boolean searchOrderUser(String userID, String orderID) throws SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("searchOrderUser of CatDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT userID,orderID FROM tblOrder WHERE orderID=? AND userID IS NOT NULL AND userID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, orderID);
                stm.setString(2, userID);
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    result = true;
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at searchOrderUser of CatDAO: " + e.toString());
        }
        finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }

}
