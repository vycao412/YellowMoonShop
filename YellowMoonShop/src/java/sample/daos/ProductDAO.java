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
import sample.dtos.ProductDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class ProductDAO implements Serializable {

    private static final Logger LOG = Logger.getLogger(ProductDAO.class);

    // đếm số sản phẩm
    public int count() throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT COUNT(productID) AS row FROM tblProduct";
                stm = cnn.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    result = rs.getInt("row");
                }
            }
        } catch (Exception e) {
            LOG.error("Count of ProductDAO: " + e);
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
    
        public int count(String search) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        LOG.info("Count of ProductDAO(1)");
        
        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT COUNT(productID) AS row FROM tblProduct WHERE name LIKE ?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, "%" + search + "%");
                rs = stm.executeQuery();

                while (rs.next()) {
                    result = rs.getInt("row");
                }
            }
            
        } catch (Exception e) {
            LOG.error("Count of ProductDAO(1): " + e);
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
    
    // liệt kê danh sách tất cả các sản phẩm cho user
    public List<ProductDTO> getListProUser(int index, int size) throws NamingException, SQLException {
        List<ProductDTO> result = new ArrayList<ProductDTO>();
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("getListProUser");
        
        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT productID,name,price,quantity,categoryID,image,"
                        + "description,createDate,expiredDate,status FROM tblProduct"
                        + " WHERE quantity > 0 AND status = 1 AND expiredDate >= GETDATE() ORDER BY expiredDate DESC"
                        + " OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, index);
                stm.setInt(2, size);
                stm.setInt(3, size);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    String categoryID = rs.getString("categoryID");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    Date createDate = rs.getDate("createDate");
                    Date expiredDate = rs.getDate("expiredDate");
                    int status = rs.getInt("status");

                    result.add(new ProductDTO(productID, name, price, quantity, categoryID, image, description, createDate, expiredDate, status));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getListProUser(int index, int size) of ProductDAO: " + e.toString());
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
    
    // liệt kê danh sách tất cả các sản phẩm cho admin
    public List<ProductDTO> getListProAdmin(int index, int size) throws NamingException, SQLException {
        List<ProductDTO> result = new ArrayList<ProductDTO>();
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("getListProAdmin");
        
        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT productID,name,price,quantity,categoryID,image,"
                        + "description,createDate,expiredDate,status FROM tblProduct"
                        + " ORDER BY expiredDate DESC"
                        + " OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, index);
                stm.setInt(2, size);
                stm.setInt(3, size);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getNString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    String categoryID = rs.getString("categoryID");
                    String image = rs.getString("image");
                    String description = rs.getNString("description");
                    Date createDate = rs.getDate("createDate");
                    Date expiredDate = rs.getDate("expiredDate");
                    int status = rs.getInt("status");

                    result.add(new ProductDTO(productID, name, price, quantity, categoryID, image, description, createDate, expiredDate, status));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getListProAdmin(int index, int size) of ProductDAO: " + e.toString());
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
    
    // search theo category, price, name
    public List<ProductDTO> getListProBySearch(String cat, float priceMin, float priceMax, String nameS, int index, int size) throws SQLException {
        List<ProductDTO> result = new ArrayList<ProductDTO>();
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("getListProBySearch");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT productID,name,price,quantity,categoryID,image,"
                        + "description,createDate,expiredDate,status FROM tblProduct"
                        + " WHERE quantity > 0 AND status = 1 AND expiredDate >= GETDATE()"
                        + " AND categoryID=? AND name LIKE ? AND price BETWEEN ? AND ?"
                        + " ORDER BY expiredDate DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, cat);
                stm.setString(2, "%" + nameS + "%");
                stm.setFloat(3, priceMin);
                stm.setFloat(4, priceMax);
                stm.setInt(5, index);
                stm.setInt(6, size);
                stm.setInt(7, size);
                rs = stm.executeQuery();

                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    String categoryID = rs.getString("categoryID");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    Date createDate = rs.getDate("createDate");
                    Date expiredDate = rs.getDate("expiredDate");
                    int status = rs.getInt("status");

                    result.add(new ProductDTO(productID, name, price, quantity, categoryID, image, description, createDate, expiredDate, status));
                }
            }
        } catch (Exception e) {
            LOG.error("getListProBySearch of ProductDAO: " + e.toString());
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
    
    // search product by ID
    public ProductDTO searchProByID(String productID) throws SQLException {
        ProductDTO result = null;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("searchProByID of ProductDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT productID,name,price,quantity,categoryID,image,"
                            + "description,createDate,expiredDate,status FROM tblProduct "
                            + "WHERE productID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, productID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    String categoryID = rs.getString("categoryID");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    Date createDate = rs.getDate("createDate");
                    Date expiredDate = rs.getDate("expiredDate");
                    int status = rs.getInt("status");
                    result = new ProductDTO(productID, name, price, quantity, categoryID, image, description, createDate, expiredDate, status);
                }
            }
        } catch (Exception e) {
            LOG.error("searchProByID of ProductDAO: " + e.toString());
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
    
    public boolean update(ProductDTO dto) throws NamingException, SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;

        LOG.info("update of ProductDAO");
        
        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "UPDATE tblProduct SET name=?,price=?,quantity=?,categoryID=?,image=?,"
                        + "description=?,createDate=?,expiredDate=?,status=? WHERE productID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setFloat(2, dto.getPrice());
                stm.setInt(3, dto.getQuantity());
                stm.setString(4, dto.getCategoryID());
                stm.setString(5, dto.getImage());
                stm.setString(6, dto.getDescription());
                stm.setDate(7, dto.getCreateDate());
                stm.setDate(8, dto.getExpiredDate());
                stm.setInt(9, dto.getStatus());
                stm.setString(10, dto.getProductID());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at update of ProductDAO: " + e.toString());
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

    // kiểm tra xem sản phẩm đã tồn tại hay không
    public boolean checkID(String productID) throws NamingException, SQLException {
        boolean result = true;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LOG.info("CheckID of ProductDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT name FROM tblProduct WHERE productID='" + productID + "'";
                stm = cnn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = false;
                }
            }
        } catch (Exception e) {
            LOG.error("CheckID of ProductDAO: " + e.toString());
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

    // tạo sản phẩm mới
    public boolean create(ProductDTO dto) throws NamingException, SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;

        LOG.info("Create of ProductDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "INSERT INTO tblProduct(name,price,quantity,categoryID,image,"
                        + "description,createDate,expiredDate,status) VALUES(?,?,?,?,?,?,?,?,?)";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setFloat(2, dto.getPrice());
                stm.setInt(3, dto.getQuantity());
                stm.setString(4, dto.getCategoryID());
                stm.setString(5, dto.getImage());
                stm.setString(6, dto.getDescription());
                stm.setDate(7, dto.getCreateDate());
                stm.setDate(8, dto.getExpiredDate());
                stm.setInt(9, dto.getStatus());
                
                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at create of ProductDAO: " + e.toString());
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
    
    // check Quantity
    public String checkQuan(ProductDTO dto) throws SQLException {
        String result = "";
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("checkQuan of ProductDao");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT quantity FROM tblProduct WHERE productID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getProductID());
                rs = stm.executeQuery();
                
                int quantity = 0;
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
                
                if (dto.getQuantity() > quantity) {
                    result = dto.getName() + " has only " + quantity + " in store!";
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at checkQuan of ProductDao: " + e.toString());
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
    
    public boolean updateQuan(ProductDTO dto) throws SQLException {
        boolean result = false;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("updateQuan of ProductDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "UPDATE tblProduct SET quantity = quantity - ? WHERE productID = ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, dto.getQuantity());
                stm.setString(2, dto.getProductID());
                
                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at updateQuan of ProductDAO: " + e.toString());
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

    public boolean checkImage(String image) throws SQLException {
        boolean result = true;
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        LOG.info("checkImage of ProductDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String url = "SELECT image FROM tblProduct WHERE image = ?";
                stm = cnn.prepareStatement(url);
                stm.setString(1, image);
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    result = false;
                }
            }         
        }
        catch (Exception e) {
            LOG.error("Error at checkImage of ProductDAO: " + e.toString());
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
