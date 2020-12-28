<%-- 
    Document   : create
    Created on : Oct 14, 2020, 1:17:46 PM
    Author     : VYCAO
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <style>
            legend { 
                /*            width: 70px; 
                            padding: 2px; 
                            margin-left: calc(50% - 35px - 8px);*/
                font-size: 40px;
                text-align: center;
                color: #FFD700;
            } 

            .button {
                text-align: center;
            }
            .error {
                color: red;
            }
        </style>
    </head>
    <body>

        <!-- authentication-->
        <c:if test="${sessionScope.USER.roleID != 'R1'}">
            <c:redirect url="homePage"/>
        </c:if>

        <form class="form-horizontal" action="create" enctype="multipart/form-data" method="POST">
            <fieldset>

                <c:set var="error" value="${sessionScope.CREATE_ERROR}"/>
                <!-- Form Name -->
                <legend>PRODUCTS</legend>

                <!-- Text input Name -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="product_name">PRODUCT NAME</label>  
                    <div class="col-md-4">
                        <input id="product_name" name="txtProName" value="${param.txtProName}" placeholder="PRODUCT NAME" class="form-control input-md" required="" type="text"/>
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
                        <select id="product_categorie" name="cmbCat" class="form-control">
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
                        <input id="quantity" name="txtQuantity" value="${param.txtQuantity}" placeholder="QUANTITY" class="form-control input-md" min="1" required="" type="number"/>
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
                        <input id="price" name="txtPrice" value="${param.txtPrice}" placeholder="PRICE" class="form-control input-md" min="1" required="true" type="number"/>
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
                        <textarea class="form-control" id="product_description" name="txtDescription">${param.txtDescription}</textarea>
                        <c:if test="${not empty error.errorDescription}">
                            <div class="error">
                                <font>${error.errorDescription}</font>
                            </div>                  
                        </c:if>
                    </div>

                </div>

                <!-- Create Date -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="create_date">CREATE DATE</label>
                    <div class="col-md-4">
                        <input id="create_date" name="txtCreateDate" placeholder="CREATEDATE" class="form-control input-md" required="true" type="date">
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
                        <input id="expired_date" name="txtExpiredDate" placeholder="EXPIREDDATE" class="form-control input-md" required="" type="date">
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
                        <input id="filebutton" name="txtImage" class="input-file" type="file">
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
                        <button id="singlebutton" name="singlebutton" class="btn btn-primary">CREATE</button>
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
