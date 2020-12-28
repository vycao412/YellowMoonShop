<%-- 
    Document   : search
    Created on : Oct 12, 2020, 5:25:26 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">YELLOW MOON SHOP</h1>
                <p class="lead text-muted mb-0">Hope you fun!</p>
                <c:if test="${sessionScope.USER != null}">
                    <c:if test="${not empty sessionScope.USER}">
                        <h3>Welcome: ${sessionScope.USER.name}</h3>
                    </c:if>
                </c:if>
            </div>
        </section>


        <div class="container">
            <div class="row">
                <form action="search?index1=1" class="col-12 col-sm-3">
                    <div class="card bg-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                        <select id="product_categorie" name="cmbCatSearch" class="form-control">
                            <c:forEach var="cat" items="${sessionScope.LIST_CAT}">
                                <option value="${cat.catID}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="card bg-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Price (vnd)</div>
                        <select id="product_price" name="cmbPriceSearch" class="form-control">
                            <option value="0 - 199000">0 - 199 000</option>
                            <option value="200000 - 499000">200 000 - 499 000</option>
                            <option value="500000 - 1000000">500 000 - 1 000 000</option>
                            <option value="1000000 - 10000000">1 000 000 - 10 000 000</option>
                        </select>
                    </div>

                    <div class="card bg-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Name</div>
                        <input class="form-control" type="text" name="nameSearch" value="${param.txtSearch}" placeholder="Search . . ."/>
                    </div>

                    <div class="card bg-light mb-3">
                        <input type="submit" value="Search"/>
                    </div>

                    <c:if test="${not empty sessionScope.CART_MESSAGE}">
                        <div class="alert alert-success" role="alert">
                            ${sessionScope.CART_MESSAGE}
                        </div>
                    </c:if>

                </form>


                <div class="col">
                    <div class="row">
                        <c:if test="${requestScope.LIST_PRO != null}">
                            <c:if test="${not empty requestScope.LIST_PRO}">
                                <c:forEach var="dto" items="${requestScope.LIST_PRO}">
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <div class="card">
                                            <c:if test="${not empty dto.image}">
                                                <c:url value="img/" var="img"></c:url>
                                                <img src="${img}${dto.image}" class="card-img-top" alt="Card image cap">
                                            </c:if>
                                            <div class="card-body">
                                                <c:url var="detail" value="detail">
                                                    <c:param name="txtProID" value="${dto.productID}"></c:param>
                                                </c:url>
                                                <h4 class="card-title"><a href="${detail}" title="View Product">${dto.name}</a></h4>
                                                <p class="card-text">${dto.description}</p>
                                                <p class="card-text"> <b>MFG: <fmt:formatDate pattern="dd-MM-yyyy" value="${dto.createDate}"/></b></p>
                                                <p class="card-text"> <b>EXP : <fmt:formatDate pattern="dd-MM-yyyy" value="${dto.expiredDate}"/></b></p>
                                                <div class="row">
                                                    <div class="col">
                                                        <p class="btn btn-danger btn-block">${dto.price}</p>
                                                    </div>

                                                    <div class="col">
                                                        <c:if test="${sessionScope.USER.roleID != 'R1'}">
                                                            <a href="#" class="btn btn-success btn-block">Add to cart</a>
                                                        </c:if>
                                                    </div>

                                                    <div class="col">
                                                        <c:if test="${sessionScope.USER != null}">
                                                            <c:if test="${not empty sessionScope.USER}">
                                                                <c:if test="${sessionScope.USER.roleID == 'R1'}">
                                                                    <a href="update.jsp" class="btn btn-success btn-block">UPDATE</a>
                                                                </c:if>
                                                            </c:if>
                                                        </c:if>                                           
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <br>

                                <br>
                                <!-- pagination -->
                                <div class="col-12 text-center">
                                    <nav aria-label="...">
                                        <c:if test="${sessionScope.endPage1 > 1}">
                                            <ul class="pagination">
                                                <c:forEach begin="1" end="${sessionScope.endPage1}" var="i">
                                                    <li class="page-item"><a class="page-link" href="search?index1=${i}">${i}</a></li>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </nav>
                                </div>

                            </c:if>
                        </c:if>

                        <c:if test="${empty requestScope.LIST_PRO}">
                            <div class="col-12 col-md-6 col-lg-4">
                                <h2>There is no product!</h2>
                            </div>
                        </c:if>

                    </div>

                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>


    </body>
</html>
