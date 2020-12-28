/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.ProductDAO;
import sample.dtos.CartDTO;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
public class CheckoutController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(CheckoutController.class);

    private static final String SUCCESS = "confirm.jsp";
    private static final String ERROR = "cart.jsp";
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

        String url = ERROR;
        LOG.info("CheckoutController");

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("USER");
            
            if (!(user != null && user.getRoleID().equals("R1"))) {
                CartDTO dto = (CartDTO) session.getAttribute("SHOP");
                ProductDAO proDao = new ProductDAO();
                List<String> message = new ArrayList<String>();

                if (dto != null) {
                    for (String productID : dto.getCart().keySet()) {
                        String checkQuan = proDao.checkQuan(dto.getCart().get(productID));
                        if (!checkQuan.equals("")) {
                            message.add(checkQuan);
                        }
                    }
                }

                if (message.isEmpty()) {
                    if (user != null) {
                        dto.setUserID(user.getUserID());
                        dto.setName(user.getName());
                        dto.setPhone(user.getPhone());
                        dto.setAddress(user.getAddress());
                    }
                    url = SUCCESS;
                } else {
                    session.setAttribute("CHECKOUT_FAIL", message);
                }

            } else {
                url = HOME;
            }
        } catch (Exception e) {
            LOG.error("Error at CheckoutController: " + e.toString());
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
