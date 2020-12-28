<%-- 
    Document   : history
    Created on : Dec 15, 2020, 1:18:31 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Cart Page</title>

        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    </head>
    <body>

        <!-- authentication-->
        <c:if test="${sessionScope.USER.roleID != 'R2'}">
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
                                        <a class="nav-link" href="history.jsp">Cart</a>
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

                        <!-- login user-->
                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <c:if test="${sessionScope.USER.roleID == 'R2'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="history.jsp">Track Order</a>
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

                    <form class="form-inline my-2 my-lg-0" action="trackOrder">
                        <div class="input-group input-group-sm">
                            <input type="text" name="txtSearchOrder" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search order...">
                            <input type="submit" class="fa fa-search" value="Search"/>
                        </div>
                    </form>
                </div>
            </div>
        </nav>

        <div class="container">

            <c:if test="${sessionScope.TRACK_ORDER != null}">
                <c:if test="${not empty sessionScope.TRACK_ORDER}">
                    <h2>Information of your orders</h2>
                    <div class="alert alert-secondary order" role="alert">
                        <div class="row">
                            <div class="col-6">
                                <h5 class="alert-heading">Customer Name: ${sessionScope.USER.name}</h5>
                                <h5 class="alert-heading">Order Date: ${sessionScope.TRACK_ORDER.date}</h5>
                                <h5 class="alert-heading">Payment Method: ${sessionScope.TRACK_ORDER.paymentMethod}</h5>
                                <h5 class="alert-heading">Phone: ${sessionScope.TRACK_ORDER.phone}</h5>
                            </div>
                            <div class="col-6">
                                <h5></h5>
                                <h5 class="alert-heading">Order ID: ${sessionScope.TRACK_ORDER.id}</h5>                   
                                <c:if test="${sessionScope.TRACK_ORDER.paymentStatus == 3}">
                                    <h5 class="alert-heading">Payment Status: Done</h5>
                                </c:if>
                                <c:if test="${sessionScope.TRACK_ORDER.paymentStatus == 4}">
                                    <h5 class="alert-heading">Payment Status: Not yet</h5>
                                </c:if>
                                <h5 class="alert-heading">Address: ${sessionScope.TRACK_ORDER.address}</h5>
                            </div>
                        </div>
                        <hr>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${sessionScope.TRACK_ORDER.cart.values()}" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${product.name}</td>
                                        <td>${product.price}</td>
                                        <td>${product.quantity}</td>
                                        <td>${product.price * product.quantity}</td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>Total: </td>
                                    <td>${sessionScope.TRACK_ORDER.total} VND</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </c:if>
            </c:if>

                    <c:if test="${sessionScope.TRACK_ORDER == null}">
                        
                    </c:if>
                    
            <c:if test="${not empty sessionScope.TRACK_FAIL}">
                <br>
                <h2>${sessionScope.TRACK_FAIL}</h2>
            </c:if>
            <c:remove var="TRACK_FAIL" scope="session"></c:remove>
        </div>         

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>


    </body>
</html>
