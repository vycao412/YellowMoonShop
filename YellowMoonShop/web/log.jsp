<%-- 
    Document   : log
    Created on : Dec 16, 2020, 11:56:23 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log Page</title>

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
        <c:if test="${sessionScope.USER.roleID != 'R1'}">
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

                        <!-- login admin-->
                        <c:if test="${sessionScope.USER != null}">
                            <c:if test="${not empty sessionScope.USER}">
                                <c:if test="${sessionScope.USER.roleID == 'R1'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="log.jsp">Updated</a>
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

                </div>
            </div>
        </nav>


        <c:if test="${sessionScope.LIST_LOG != null}">
            <c:if test="${not empty sessionScope.LIST_LOG}">

                <table class="table table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">Log ID</th>
                            <th scope="col">User ID</th>
                            <th scope="col">Product ID</th>
                            <th scope="col">Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${sessionScope.LIST_LOG}" varStatus="counter">
                            <tr>
                                <th scope="row">${counter.count}</th>
                                <td>${dto.logID}</td>
                                <td>${dto.userID}</td>
                                <td>${dto.productID}</td>
                                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${dto.date}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </c:if>
        </c:if>

        <!-- pagination -->
                    <div class="text-center">
                        <nav aria-label="...">
                            <c:if test="${sessionScope.endPage2 > 1}">
                                <ul class="pagination">
                                    <c:forEach begin="1" end="${sessionScope.endPage2}" var="i">
                                        <li class="page-item"><a class="page-link" href="getLog?index2=${i}">${i}</a></li>
                                        </c:forEach>
                                </ul>
                            </c:if>
                        </nav>
                    </div>

        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

    </body>
</html>
