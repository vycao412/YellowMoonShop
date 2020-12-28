<%-- 
    Document   : cart
    Created on : Oct 18, 2020, 2:16:27 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">       

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">



    </head>
    <body>

        <!-- authentication-->
        <c:if test="${sessionScope.USER.roleID == 'R1'}">
            <c:redirect url="homePage"/>
        </c:if>

        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" style="color: yellow">YELLOW MOON SHOP</a>

                <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="homePage">Home Page</a>
                        </li>

                        <c:if test="${sessionScope.USER == null}">
                            <c:if test="${empty sessionScope.USER}">
                                <li class="nav-item">
                                    <a class="nav-link" href="login.html">Login</a>
                                </li>
                            </c:if>
                        </c:if>     

                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <c:if test="${sessionScope.USER.roleID == 'R2'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="history.jsp">Track Order</a>
                                    </li>
                                </c:if>
                            </c:if>
                        </c:if>

                        <!-- login admin-->
                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <c:if test="${sessionScope.USER.roleID == 'R1'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="create.jsp">Create</a>
                                    </li>
                                </c:if>
                            </c:if>
                        </c:if>

                        <!-- logout user-->
                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <li class="nav-item">
                                    <a class="nav-link" href="logout">Log out</a>
                                </li>
                            </c:if>
                        </c:if>

                    </ul>

                </div>
            </div>
        </nav>

        <div class="container">
            <c:if test="${sessionScope.CHECKOUT_FAIL != null}">
                <c:forEach var="msg" items="${sessionScope.CHECKOUT_FAIL}">
                    <div class="alert alert-danger" role="alert">
                        ${msg}
                    </div>
                </c:forEach>
            </c:if>
            <c:remove var="CHECKOUT_FAIL" scope="session"></c:remove>

            <c:if test="${not empty sessionScope.CHECKOUT_SUCCESS}">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.CHECKOUT_SUCCESS}
                </div>
            </c:if>
            <c:remove var="CHECKOUT_SUCCESS" scope="session"></c:remove>

            <c:if test="${ (sessionScope.SHOP != null) && (sessionScope.SHOP.cart.size() != 0) }">
                <table id="cart" class="table table-hover table-condensed">
                    <thead>
                        <tr>
                            <th style="width:5%">No</th>
                            <th style="width:40%">Product</th>
                            <th style="width:10%">Price</th>
                            <th style="width:10%">Quantity</th>
                            <th style="width:15%" class="text-center">Subtotal</th>
                            <th style="width:10%"></th>
                            <th style="width:10%"></th>
                        </tr>

                    </thead>
                    <tbody>

                        <c:forEach var="pro" items="${sessionScope.SHOP.cart.values()}" varStatus="counter">
                        <form action="updateCart">
                            <tr>
                                <td data-th="Number">${counter.count}</td>
                                <td data-th="Product">${pro.name}</td>
                                <td data-th="Price">${pro.price}</td>
                                <td data-th="Quantity">
                                    <input type="number" class="form-control text-center" name="proQuan" value="${pro.quantity}" min="1">
                                </td>
                                <td data-th="Subtotal" class="text-center">${pro.price * pro.quantity}</td>
                                <td>
                                    <input type="hidden" name="id" value="${pro.productID}"/>
                                    <input type="submit" value="Update"/>
                                </td> 

                                <td>
                                    <c:url var="delete" value="deleteCart">
                                        <c:param name="id" value="${pro.productID}"></c:param>
                                    </c:url>
                                    <a href="${delete}" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                                </td>
                            </tr>
                        </form>

                    </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="visible-xs">
                            <td class="text-center"><strong>Total ${pageScope.totalCart}</strong></td>
                        </tr>
                        <tr>
                            <td><a href="homePage" class="btn btn-warning"><i class="fa fa-angle-left"></i> Continue Shopping</a></td>
                            <td colspan="2" class="hidden-xs"></td>
                            <td class="hidden-xs text-center"><strong>Total ${sessionScope.SHOP.total}</strong></td>
                            <td><a href="checkout" class="btn btn-success btn-block">Checkout <i class="fa fa-angle-right"></i></a></td>
                        </tr>
                    </tfoot>
                </table>
            </c:if>

            <c:if test="${sessionScope.SHOP == null || sessionScope.SHOP.cart.size() == 0}">
                <c:if test="${not empty sessionScope.ORDERID  && sessionScope.USER != null}">
                    <h2>Your order ID: ${sessionScope.ORDERID}</h2>      
                </c:if>
                <c:if test="${empty sessionScope.ORDERID}">
                    <h2>Your cart is empty.</h2>      
                </c:if>
            </c:if>
        </div>

    </body>
</html>
