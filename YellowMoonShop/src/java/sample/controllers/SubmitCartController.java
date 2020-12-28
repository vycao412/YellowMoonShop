/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CartDAO;
import sample.daos.ProductDAO;
import sample.dtos.CartDTO;
import sample.dtos.ProductDTO;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
public class SubmitCartController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(SubmitCartController.class);

    private static final String SUCCESS = "cart.jsp";
    private static final String ERROR = "confirm.jsp";
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
        LOG.info("SubmitCartController");

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("USER");

            if (!(user != null && user.getRoleID().equals("R1"))) {
                String name = request.getParameter("txtName");
                String phone = request.getParameter("txtPhone");
                String address = request.getParameter("txtAddress");

                String message = "";
                if (!phone.matches("[\\d]+")) {
                    message = "Phone is not valid!";
                }
                if (name.isEmpty() || phone.isEmpty() || address.isEmpty()) {
                    message = "All filed is required!";
                }

                if (message.equals("")) {
                    CartDTO dto = (CartDTO) session.getAttribute("SHOP");
                    if (dto != null && dto.getCart().size() != 0) {
                        long id = System.currentTimeMillis();
                        dto.setId(id + "");
                        Date date = new Date(id);
                        dto.setDate(date);
                        ProductDAO proDAO = new ProductDAO();
                        for (ProductDTO product : dto.getCart().values()) {
                            proDAO.updateQuan(product);
                        }
                        dto.setName(name.trim());
                        dto.setPhone(phone.trim());
                        dto.setAddress(address.trim());
                        dto.setPaymentStatus(4);

                        CartDAO cartDAO = new CartDAO();
                        cartDAO.add(dto);
                        session.setAttribute("CHECKOUT_SUCCESS", "Check out successfully!");
                        session.setAttribute("ORDERID", id);
                        
                        session.removeAttribute("SHOP");
                        url = SUCCESS;
                    }
                } else {
                    session.setAttribute("SUBMIT_SHOP_FAIL", message);
                }
            }
            else {
                url = HOME;
            }

        } catch (Exception e) {
            LOG.error("Error at SubmitCartController: " + e.toString());
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
