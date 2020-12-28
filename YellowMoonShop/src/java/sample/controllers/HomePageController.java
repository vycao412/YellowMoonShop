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
import sample.daos.CategoryDAO;
import sample.daos.ProductDAO;
import sample.daos.StatusDAO;
import sample.dtos.CategoryDTO;
import sample.dtos.ProductDTO;
import sample.dtos.StatusDTO;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
public class HomePageController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(HomePageController.class);

    private static final String SUCCESS = "homepage.jsp";
    private static final String ERROR = "error.jsp";

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

        LOG.info("HomePageController");

        String url = ERROR;

        try {
            ProductDAO proDao = new ProductDAO();
            CategoryDAO catDao = new CategoryDAO();
            StatusDAO statusDao = new StatusDAO();
            HttpSession session = request.getSession();

            LOG.info("1");
            // pagination
            String indexString = request.getParameter("index");
            if (indexString == null) {
                indexString = "1";
            }
            LOG.info("2");
            int index = Integer.parseInt(indexString);
            int count = proDao.count();
            int pageSize = 20;
            int endPage = 0;
            endPage = count / pageSize;
            LOG.info("3");
            if (count % pageSize != 0) {
                endPage++;
            }
            session.setAttribute("endPage", endPage);
            session.setAttribute("index", index);

            LOG.info("4");
            // lấy danh sách categories
            List<CategoryDTO> listCat = catDao.getListCat();
            session.setAttribute("LIST_CAT", listCat);

            LOG.info("5");
            // lấy danh sách products
//            List<ProductDTO> listPro = proDao.getListProUser(index, pageSize);
            if (session.getAttribute("LIST_PRODUCT") != null) {
                session.removeAttribute("LIST_PRODUCT");
            }
            UserDTO user = (UserDTO) session.getAttribute("USER");
            if (user != null) {
                LOG.info("6");
                if (user.getRoleID().equals("R1")) {
                    LOG.info("7");
                    List<ProductDTO> listProAdmin = proDao.getListProAdmin(index, pageSize);
                    session.setAttribute("LIST_PRODUCT", listProAdmin);
                } else {
                    LOG.info("7.5");
                    List<ProductDTO> listProUser = proDao.getListProUser(index, pageSize);
                    session.setAttribute("LIST_PRODUCT", listProUser);
                }
            } else {
                
                List<ProductDTO> listPro = proDao.getListProUser(index, pageSize);
                session.setAttribute("LIST_PRODUCT", listPro);
            }

            LOG.info("8");
            // lấy danh sách status
            List<StatusDTO> listStatus = statusDao.getListStatus(3);
            if (session.getAttribute("LIST_STATUS_PRO") != null) {
                session.removeAttribute("LIST_STATUS_PRO");
            }
            LOG.info("9");
            session.setAttribute("LIST_STATUS_PRO", listStatus);
            LOG.info("10");
            // chuyển trang
            url = SUCCESS;

        } catch (Exception e) {
            LOG.error("Error at HomePageController: " + e);
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
