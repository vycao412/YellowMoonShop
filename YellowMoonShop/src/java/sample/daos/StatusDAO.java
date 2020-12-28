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
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import org.apache.log4j.Logger;
import sample.dtos.StatusDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class StatusDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(StatusDAO.class);
    
    public List<StatusDTO> getListStatus(int id) throws NamingException, SQLException {
        List<StatusDTO> result = new ArrayList<StatusDTO>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("getListStatusPro of StatusDAO");
        
        try {
            conn = DBUtils.getConnection();
            
            if (conn != null) {
                String sql = "SELECT statusID,name FROM tblStatus WHERE statusID < ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                
                while (rs.next()) {
                    int statusID = rs.getInt("statusID");
                    String name = rs.getNString("name");
                    
                    result.add(new StatusDTO(statusID, name));
                }
            }
        }
        catch (Exception e) {
            LOG.error("getListStatusPro of StatusDAO: " + e);
        }
        finally {
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
    
}
