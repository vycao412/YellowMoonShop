/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CategoryDAO;
import sample.daos.ProductDAO;
import sample.dtos.CategoryDTO;
import sample.dtos.ErrorProductDTO;
import sample.dtos.ProductDTO;
import java.util.Hashtable;
import java.util.Iterator;
import javax.servlet.annotation.MultipartConfig;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import sample.dtos.UserDTO;

/**
 *
 * @author VYCAO
 */
@MultipartConfig
public class CreateController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(CreateController.class);

    private static final String SUCCESS = "HomePageController";
    private static final String ERROR = "create.jsp";

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

        LOG.info("CreateController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("USER");

            if (session.getAttribute("LIST_CAT") != null) {
                session.removeAttribute("LIST_CAT");
            }

            List<CategoryDTO> listCat = new ArrayList<CategoryDTO>();
            CategoryDAO catDao = new CategoryDAO();
            listCat = catDao.getListCat();
            session.setAttribute("LIST_CAT", listCat);

            ProductDAO dao = new ProductDAO();

            if (user != null && user.getRoleID().equals("R1")) {
                // xu ly anh
                boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
                if (!isMultiPart) {

                } else {
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List items = null;
                    try {
                        items = upload.parseRequest(request);
                    } catch (FileUploadException e) {
                        LOG.error("Error at CreateController of FileUpload: " + e.toString());
                    }
                    Iterator iter = items.iterator();
                    Hashtable params = new Hashtable();
                    String fileName = null;
                    while (iter.hasNext()) {
                        FileItem item = (FileItem) iter.next();
                        if (item.isFormField()) {
                            params.put(item.getFieldName(), item.getString());
                        } else {
                            try {
                                String itemName = item.getName();
                                fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);

                                // check existed image
                                if (dao.checkImage(fileName)) {
                                    String realPath = getServletContext().getRealPath("/")
                                            + "img\\" + fileName;

                                    File savedFile = new File(realPath);
                                    item.write(savedFile);

                                }
                            } catch (Exception e) {
                                LOG.error("Error at CreateController: " + e.toString());
                            }
                        }
                    }   // end while

                    // lay tham so tu trang create.jsp
                    String proName = (String) params.get("txtProName");
                    String proCat = (String) params.get("cmbCat");
                    String proQuan_Str = (String) params.get("txtQuantity");
                    int proQuan = Integer.parseInt(proQuan_Str);
                    String proPrice_Str = (String) params.get("txtPrice");
                    float proPrice = Float.parseFloat(proPrice_Str);
                    String proDes = (String) params.get("txtDescription");
                    String proCreateDate_Str = (String) params.get("txtCreateDate");
                    String proExpiredDate_Str = (String) params.get("txtExpiredDate");
                    //String proImage = (String) params.get("txtImage");

                    // kiem tra du lieu
                    boolean check = true;
                    ErrorProductDTO error = new ErrorProductDTO();
                    if (proName.isEmpty()) {
                        error.setErrorName("Name is required!");
                        check = false;
                    }
                    if (proDes.isEmpty()) {
                        error.setErrorDescription("Description is required!");
                        check = false;
                    }
//                    if (proImage.isEmpty()) {
//                        error.setErrorImage("Link image is required!");
//                    }
//                    if ((proImage.lastIndexOf(".png") <= 0) && (proImage.lastIndexOf(".jpg") <= 0)) {
//                        error.setErrorImage("Link image is not valid!");
//                        check = false;
//                    }
                    if (proPrice_Str.isEmpty()) {
                        error.setErrorPrice("Price is required!");
                        check = false;
                    }
                    if ((!proPrice_Str.matches("[0-9]+")) && (proPrice_Str.matches("[0]+"))) {
                        error.setErrorPrice("Price is not valid!");
                        check = false;
                    }
                    if (proQuan_Str.isEmpty()) {
                        error.setErrorQuantity("Quantity is required!");
                        check = false;
                    }
                    if ((!proQuan_Str.matches("[0-9]+")) && (proQuan_Str.matches("[0]+"))) {
                        error.setErrorQuantity("Quantity is not valid!");
                    }
                    if (proCreateDate_Str.isEmpty()) {
                        error.setErrorCreateDate("Create Date is required!");
                        check = false;
                    }
                    if (proExpiredDate_Str.isEmpty()) {
                        error.setErrorExpiredDate("Expired Date is required!");
                        check = false;
                    }

                    Date proCreateDate = null;
                    Date proExpiredDate = null;
                    if (!proCreateDate_Str.isEmpty() && !proCreateDate_Str.isEmpty()) {
                        proCreateDate = Date.valueOf(proCreateDate_Str);
                        proExpiredDate = Date.valueOf(proExpiredDate_Str);
                        if (proExpiredDate.before(proCreateDate)) {
                            error.setErrorExpiredDate("Expired date must be after created date!");
                            check = false;
                        }
                        long millis = System.currentTimeMillis();
                        Date date = new java.sql.Date(millis);
                        if (proExpiredDate.before(date)) {
                            error.setErrorExpiredDate("Expired date must be after today!");
                            check = false;
                        }
                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        java.util.Date proExpiredDate_Util = new java.util.Date(proExpiredDate.getTime());
                        java.util.Date proCreateDate_Util = new java.util.Date(proCreateDate.getTime()); // sql.Date -> util.Date
                        cal.add(java.util.Calendar.YEAR, 1); // to get previous year add -1
                        java.util.Date nextYear = cal.getTime();
                        if (proExpiredDate_Util.compareTo(nextYear) > 1) {
                            error.setErrorExpiredDate("Expired date must be less than 1 year from create date!");
                            check = false;
                        }
                    }

                    if (check) {
                        // create product
                        ProductDTO dto = new ProductDTO(proName, proPrice, proQuan, proCat, fileName, proDes, proCreateDate, proExpiredDate, 1);

                        if (dto != null) {
                            dao.create(dto);
                            url = SUCCESS;
                        }
                    } else {
                        session.setAttribute("CREATE_ERROR", error);
                    }
                }
            }// get Parameter
            else {
                url = SUCCESS;
            }

        } catch (Exception e) {
            LOG.error("Error at CreateController: " + e.toString());
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
