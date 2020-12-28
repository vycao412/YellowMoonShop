/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import sample.daos.UserDAO;
import sample.dtos.ErrorUserDTO;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
public class RegisterController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(RegisterController.class);

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "login.html";

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

        LOG.info("RegisterController");
        String url = ERROR;

        try {
            String userID = request.getParameter("txtUserID");
            String name = request.getParameter("txtName");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String password = request.getParameter("txtPassword");
            String rePassword = request.getParameter("txtRePassword");

            boolean check = true;
            ErrorUserDTO error = new ErrorUserDTO();

            if (userID.length() < 0) {
                check = false;
                error.setErrorUserID("User ID is required!");
            }
            if (userID.length() > 10) {
                check = false;
                error.setErrorUserID("The length of userID is from 1 to 10!");
            }
            if (name.length() < 0) {
                check = false;
                error.setErrorName("Name is required!");
            }
            if (name.length() > 100) {
                check = false;
                error.setErrorName("The length of name is from 1 to 100!");
            }
            if (phone.length() < 0) {
                check = false;
                error.setErrorName("Phone is required!");
            }
            if (!phone.matches("(03|05|07|08|09)+([0-9]{8})")) {
                check = false;
                error.setErrorName("Phone number contains 10 digits and begin with 03 or 05 or 07 or 08 or 09!");
            }
            if (address.length() < 0) {
                check = false;
                error.setErrorName("Name is required!");
            }
            if (password.length() < 8) {
                check = false;
                error.setErrorPassword("The length of password is at least 8!");
            }
            if (!rePassword.equals(password)) {
                check = false;
                error.setErrorRePassword("This is not match!");
            }

            UserDAO dao = new UserDAO();
            boolean exist = dao.checkID(userID);
            if (!exist) {
                check = false;
                error.setErrorUserID("UserID is duplicated!");
            }

            if (check) {
                UserDTO dto = new UserDTO(userID, name, password, address, phone, "R2", "Active");
                dao.create(dto);
                url = SUCCESS;
            } else {
                request.setAttribute("ERROR_USER", error);
            }
        } catch (Exception e) {
            LOG.error("RegisterController" + e.toString());
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
