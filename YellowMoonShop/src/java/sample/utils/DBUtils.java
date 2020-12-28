/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utils;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author VYCAO
 */
public class DBUtils {
    
    public static Connection getConnection() throws NamingException, SQLException {
        Connection conn = null;
        Context context = new InitialContext();
        Context tomcat = (Context)context.lookup("java:/comp/env");
        DataSource ds = (DataSource)tomcat.lookup("LAB2");
        
        conn = ds.getConnection();
        return conn;
    }
    
}
