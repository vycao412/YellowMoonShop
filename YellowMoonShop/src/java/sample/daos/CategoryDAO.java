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
import sample.dtos.CategoryDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class CategoryDAO implements Serializable {

    private static final Logger LOG = Logger.getLogger(CategoryDAO.class);

    public List<CategoryDTO> getListCat() throws NamingException, SQLException {
        List<CategoryDTO> result = new ArrayList<CategoryDTO>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                String sql = "SELECT catID, name FROM tblCategory";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String catID = rs.getString("catID");
                    String name = rs.getNString("name");

                    result.add(new CategoryDTO(catID, name));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getListCat of CategoryDAO: " + e);
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

    public CategoryDTO getCatByName(String name) throws NamingException, SQLException {
        CategoryDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                String sql = "SELECT catID FROM tblCategory WHERE name='" + name + "'";
                rs = stm.executeQuery();
                while (rs.next()) {
                    String catID = rs.getString("catID");

                    result = new CategoryDTO(catID, name);
                }
            }
        } catch (Exception e) {
            LOG.error("getCatByName of CategoryDAO: " + e);
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
}
