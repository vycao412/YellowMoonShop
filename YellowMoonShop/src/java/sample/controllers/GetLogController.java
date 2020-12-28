/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.LogDAO;
import sample.dtos.LogDTO;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
public class GetLogController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(GetLogController.class);

    private static final String SUCCESS = "log.jsp";
    private static final String ERROR = "error.jsp";
    private static final String HOME = "HomePageController";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        LOG.info("GetLogController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("USER");
            
            if ( user != null && user.getRoleID().equals("R1") ) {
                LogDAO dao = new LogDAO();

                // pagination
                String indexString = request.getParameter("index2");
                if (indexString == null) {
                    indexString = "1";
                }
                int index = Integer.parseInt(indexString);
                int count = dao.count();
                int pageSize = 5;
                int endPage = 0;
                endPage = count / pageSize;
                if (count % pageSize != 0) {
                    endPage++;
                }
                session.setAttribute("endPage2", endPage);
                session.setAttribute("index2", index);

                List<LogDTO> listLog = dao.getListLog(index, pageSize);
                session.setAttribute("LIST_LOG", listLog);
                url = SUCCESS;
            }
            else {
                url = HOME;
            }

        } catch (Exception e) {
            LOG.error("Error at GetLogController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
