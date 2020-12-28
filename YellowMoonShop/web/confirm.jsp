<%-- 
    Document   : confirm
    Created on : Dec 14, 2020, 4:10:00 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>

        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <style>
            .btn btn-success btn-block {
                text-align: center;
            }
        </style>
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
                                        <a class="nav-link" href="cart.jsp">Cart</a>
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

                    <form class="form-inline my-2 my-lg-0">
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-secondary btn-number">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <c:if test="${ (sessionScope.USER.roleID == 'R2') or (sessionScope.USER == null) }">
                            <a class="btn btn-success btn-sm ml-3" href="cart.html">
                                <i class="fa fa-shopping-cart"></i> Cart
                            </a>
                        </c:if>

                    </form>
                </div>
            </div>
        </nav>

        <div class="container-fluid main row">
            <div class="col-3"></div>
            <div class="col-6">
                <h2>CUSTOMER'S INFORMATION</h2>
                <form action="submitCart" method="POST">
                    <div class="form-group">
                        <label>Name</label>
                        <c:if test="${sessionScope.USER != null}">
                            <input type="text" class="form-control" placeholder="Enter name"  name="txtName" value="${sessionScope.SHOP.name}" style="border: 1px solid;" disabled="true"></input>
                            <input type="hidden" name="txtName" value="${sessionScope.SHOP.name}"/>
                        </c:if>
                        <c:if test="${sessionScope.USER == null}">
                            <input type="text" class="form-control" placeholder="Enter name"  name="txtName" value="${sessionScope.SHOP.name}" style="border: 1px solid;"></input>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" class="form-control" placeholder="Enter phone"  name="txtPhone" value="${sessionScope.SHOP.phone}" style="border: 1px solid;"></input>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" placeholder="Enter address"  name="txtAddress" value="${sessionScope.SHOP.address}" style="border: 1px solid;"></input>
                    </div>
                    <c:if test="${not empty sessionScope.SUBMIT_SHOP_FAIL}">
                        <font color="red"><small>${sessionScope.SUBMIT_SHOP_FAIL}</small></font> 
                        </c:if>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </div>             
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>


    </body>
</html>
