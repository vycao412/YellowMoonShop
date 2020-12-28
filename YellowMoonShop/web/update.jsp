<%-- 
    Document   : update
    Created on : Oct 16, 2020, 5:25:19 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <style>
            legend { 
                font-size: 40px;
                text-align: center;
                color: #FFD700;
            } 

            .button {
                text-align: center;
            }
        </style>

        <title>Update Page</title>
    </head>
    <body>

        <!-- authentication-->
        <c:if test="${sessionScope.USER.roleID != 'R1'}">
            <c:redirect url="homePage"/>
        </c:if>
        

        <form  class="form-horizontal" action="updateProduct" enctype="multipart/form-data" method="POST">
            <fieldset>
                
                <c:set var="dto" value="${sessionScope.PRODUCT_UPDATE}"/>
                <c:set var="error" value="${sessionScope.ERROR_UPDATE}"/>
                <!-- Form Name -->
                <legend>UPDATE PRODUCT</legend>

                <!-- Text input Name-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="product_id">PRODUCT NAME</label>  
                    <div class="col-md-4">
                        <input id="product_name" name="proID" value="${dto.productID}" class="form-control input-md" type="text" readonly="true">
                    </div>
                </div>

                <!-- Text input Name-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="product_name">PRODUCT NAME</label>  
                    <div class="col-md-4">
                        <input id="product_name" name="proName" value="${dto.name}" class="form-control input-md" required="true" type="text">
                        <c:if test="${not empty error.errorName}">
                            <div class="error">
                                <font>${error.errorName}</font>
                            </div>                  
                        </c:if>
                    </div>           
                </div>

                <!-- Select Basic Category -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="cmbCat">PRODUCT CATEGORY</label>
                    <div class="col-md-4">
                        <select id="product_categorie" name="proCat" class="form-control" required="true">
                            <c:forEach var="cat" items="${sessionScope.LIST_CAT}">
                                <option value="${cat.catID}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Text input Quantity -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="quantity">QUANTITY</label>  
                    <div class="col-md-4">
                        <input id="quantity" name="proQuan" value="${dto.quantity}" class="form-control input-md" min="1" required="true" type="number">
                        <c:if test="${not empty error.errorQuantity}">
                            <div class="error">
                                <font>${error.errorQuantity}</font>
                            </div>                  
                        </c:if>
                    </div>                   
                </div>

                <!-- Text input Price -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="price">PRICE</label>  
                    <div class="col-md-4">
                        <input id="price" name="proPrice" value="${dto.price}" class="form-control input-md" min="1" required="true" type="number">
                        <c:if test="${not empty error.errorPrice}">
                            <div class="error">
                                <font>${error.errorPrice}</font>
                            </div>                  
                        </c:if>
                    </div>

                </div>

                <!-- Textarea Description -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="product_description">DESCRIPTION</label>
                    <div class="col-md-4">                     
                        <textarea class="form-control" id="product_description" name="proDes" required="true">${dto.description}</textarea>
                        <c:if test="${not empty error.errorDescription}">
                            <div class="error">
                                <font>${error.errorDescription}</font>
                            </div>                  
                        </c:if>
                    </div>                   
                </div>

                <!-- Select Basic Status -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="cmbStatus">STATUS</label>
                    <div class="col-md-4">
                        <select id="product_categorie" name="proStatus" class="form-control" required="true">
                            <c:forEach var="status" items="${sessionScope.LIST_STATUS_PRO}">
                                <option value="${status.statusID}">${status.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Create Date -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="create_date">CREATE DATE</label>
                    <div class="col-md-4">
                        <input id="create_date" name="proCreateDate" value="${dto.createDate}" class="form-control input-md" required="true" type="date">
                        <c:if test="${not empty error.errorCreateDate}">
                            <div class="error">
                                <font>${error.errorCreateDate}</font>
                            </div>                  
                        </c:if>
                    </div>                  
                </div>

                <!-- Expired Date -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="expired_date">EXPIRED DATE</label>
                    <div class="col-md-4">
                        <input id="expired_date" name="proExpiredDate" value="${dto.expiredDate}" class="form-control input-md" required="true" type="date">
                        <c:if test="${not empty error.errorExpiredDate}">
                            <div class="error">
                                <font>${error.errorExpiredDate}</font>
                            </div>                  
                        </c:if>
                    </div>              
                </div>

                <!-- File Button --> 
                <div class="form-group">
                    <label class="col-md-4 control-label" for="filebutton">IMAGE</label>
                    <div class="col-md-4">
                        <input id="filebutton" value="${dto.image}" name="proImage" class="input-file" required="true" type="file">
                        <c:if test="${not empty error.errorImage}">
                            <div class="error">
                                <font>${error.errorImage}</font>
                            </div>                  
                        </c:if>
                    </div>
                </div>

                <!-- Button -->
                <div class="form-group">
                    <div class="button">
                        <button id="singlebutton" name="singlebutton" class="btn btn-primary">UPDATE</button>
                    </div>
                </div>

                <div class="form-group">
                    <div class="button">
                        <a href="homePage">Back to Home Page</a>
                    </div>
                </div>
                
            </fieldset>
        </form>

        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

    </body>
</html>
