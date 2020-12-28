/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import org.apache.log4j.Logger;
import sample.dtos.LogDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class LogDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(LogDAO.class);

    public LogDTO getLog(String productID) throws SQLException {
        LogDTO result = null;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("getLog of LogDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT logID,userID,productID,date FROM tblLog WHERE productID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, productID);
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    String logID = rs.getString("logID");
                    String userID = rs.getString("userID");
                    Date date = rs.getDate("date");
                    
                    result = new LogDTO(logID, userID, productID, date);
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at getLog of LogDAO: " + e.toString());
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
    
    // tạo log mới
    public boolean create(LogDTO dto) throws NamingException, SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;

        LOG.info("Create of LogDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "INSERT INTO tblLog(userID,productID,date)"
                        + " VALUES(?,?,?)";

                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getProductID());
                stm.setDate(3, dto.getDate());
                
                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("create of LogDAO: " + e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }
    
    public List<LogDTO> getListLog(int index, int size) throws SQLException {
        List<LogDTO> result = new ArrayList<LogDTO>();
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("getListLog of LogDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT logID,userID,productID,date FROM tblLog ORDER BY date DESC " +
                            "OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, index);
                stm.setInt(2, size);
                stm.setInt(3, size);
                rs = stm.executeQuery();
                
                while (rs.next()) {
                    String logID = rs.getString("logID");
                    String userID = rs.getString("userID");
                    String productID = rs.getString("productID");
                    Date date = rs.getDate("date");
                    
                    result.add(new LogDTO(logID, userID, productID, date));
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at getListLog of LogDAO: " + e.toString());
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
    
    public int count() throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT COUNT(logID) AS row FROM tblLog";
                stm = cnn.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    result = rs.getInt("row");
                }
            }
        } catch (Exception e) {
            LOG.error("Count of LogDAO: " + e.toString());
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
    
}
