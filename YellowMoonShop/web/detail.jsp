<%-- 
    Document   : detail
    Created on : Oct 18, 2020, 1:36:26 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail Page</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">       

        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <style>
            .gallery-wrap .img-big-wrap img {
                height: 600px;
                width: 458px;
                display: inline-block;
            }
        </style>
    </head>
    <body>

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

                        <!-- login admin-->
                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <c:if test="${sessionScope.USER.roleID == 'R1'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="getLog">Updated</a>
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
                            <a class="btn btn-success btn-sm ml-3" href="cart.jsp">
                                <i class="fa fa-shopping-cart"></i> Cart
                            </a>
                        </c:if>


                    </form>
                </div>
            </div>
        </nav>

        <div class="container">

            <div class="card">
                <div class="row">
                    <c:set var="dto" value="${sessionScope.PRODUCT}"/>
                    <aside class="col-sm-5 border-right">
                        <article class="gallery-wrap"> 
                            <div class="img-big-wrap">
                                <c:url var="image" value="${dto.image}"></c:url>
                                <div><img src="./img/${image}" style="height: 250px; background: transparent no-repeat center; background-size: cover"/></div>
                            </div> <!-- slider-product.// -->
                        </article> <!-- gallery-wrap .end// -->
                    </aside>
                    <aside class="col-sm-7">
                        <article class="card-body p-5">
                            <h3 class="title mb-3">${dto.name}</h3>

                            <p class="price-detail-wrap"> 
                                <span class="price h3 text-warning"> 
                                    <span class="num">${dto.price}</span><span class="currency"> VND</span>
                                </span> 
                            </p> <!-- price-detail-wrap .// -->
                            <dl class="item-property">
                                <dt>Description</dt>
                                <dd><p>${dto.description}</p></dd>
                            </dl>
                            <dl class="param param-feature">                             
                                <dt>Create Date</dt>
                                <dd><fmt:formatDate pattern="dd-MM-yyyy" value="${dto.createDate}"/></dd>
                            </dl>  <!-- item-property-hor .// -->
                            <dl class="param param-feature">
                                <dt>Expired Date</dt>
                                <dd><fmt:formatDate pattern="dd-MM-yyyy" value="${dto.expiredDate}"/></dd>
                            </dl>  <!-- item-property-hor .// -->
                            <hr>
                            <div class="row">
                                <div class="col-sm-5">
                                    <dl class="param param-inline">
                                        <dt>Quantity: </dt>
                                        <dd>
                                            <input class="form-control form-control-sm" style="width:70px;" type="text"/>
                                        </dd>
                                    </dl>  <!-- item-property .// -->
                                </div> <!-- col.// -->
                            </div> <!-- row.// -->
                            <hr>


                            <a href="#" class="btn btn-lg btn-outline-primary text-uppercase"> <i class="fas fa-shopping-cart"></i> Add to cart </a>
                        </article> <!-- card-body.// -->
                    </aside> <!-- col.// -->
                </div> <!-- row.// -->
            </div> <!-- card.// -->

        </div>

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

    </body>
</html>
