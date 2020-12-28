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
import sample.daos.ProductDAO;
import sample.dtos.ProductDTO;

/**
 *
 * @author VYCAO
 */
public class SearchController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(SearchController.class);

    private static final String SUCCESS = "search.jsp";
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

        LOG.info("SearchController");
        String url = ERROR;

        try {
            ProductDAO dao = new ProductDAO();
            HttpSession session = request.getSession();

            // lấy thông tin để search
            String cat = request.getParameter("cmbCatSearch");
            String priceStr = request.getParameter("cmbPriceSearch");
            String tmp[] = priceStr.split(" - ");
            String priceMinStr = tmp[0];
            float priceMin = Float.parseFloat(priceMinStr);
            String priceMaxStr = tmp[1];
            float priceMax = Float.parseFloat(priceMaxStr);
            String name = request.getParameter("nameSearch");

            // pagination
            String indexString = request.getParameter("index1");
            if (indexString == null) {
                indexString = "1";
            }
            int index = Integer.parseInt(indexString);
            int count = dao.count(name);
            int pageSize = 20;
            int endPage = 0;
            endPage = count / pageSize;
            if (count % pageSize != 0) {
                endPage++;
            }

            // lấy danh sách products
            List<ProductDTO> listPro = dao.getListProBySearch(cat, priceMin, priceMax, name, index, pageSize);

            if (listPro != null) {
                request.setAttribute("LIST_PRO", listPro);
                session.setAttribute("endPage1", endPage);
                session.setAttribute("index1", index);

                // chuyển trang
                url = SUCCESS;
            }

        } catch (Exception e) {
            LOG.error("Error at SearchController: " + e.toString());
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
