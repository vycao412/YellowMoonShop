/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.listeners;

import java.io.File;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.apache.log4j.PropertyConfigurator;

/**
 *
 * @author VYCAO
 */
@WebListener("application context listener")
public class ContextListener implements ServletContextListener  {
    
    @Override
    public void contextInitialized(ServletContextEvent event) {
        //initialize log4j
        ServletContext context = event.getServletContext();
        String log4jConfigFile = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("") + File.separator + log4jConfigFile;
        System.setProperty("rootPath", context.getRealPath(""));
        PropertyConfigurator.configure(fullPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
    }
    
}
