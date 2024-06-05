<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stall Staff Home</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

            <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.0"></script>
            <style>
                /* Styles for rating section */

                .rating-section {
                    margin-top: 20px;
                    padding: 20px;
                    background-color: #f8f9fa;
                    border-radius: 10px;
                }

                .rating-info h5 {
                    margin-bottom: 20px;
                    font-size: 1.5rem;
                }

                .rating-stars i {
                    color: #ffc107;
                    font-size: 1.5rem;
                    margin-right: 5px;
                }
                /* Custom styles for stats section */

                .stats-section {
                    margin-top: 20px;
                }

                .stats-section .card {
                    margin-bottom: 20px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    transition: transform 0.3s ease-in-out;
                }

                .stats-section .card:hover {
                    transform: translateY(-5px);
                }
            </style>
    </head>

    <body>
        <c:choose>
            <c:when test="${sessionScope.status eq 'inactive'}">
                <div class="container d-flex justify-content-center align-items-center vh-100">
                    <div class="text-center">
                        <h1 class="inactive-message">Your profile isn't active right now. Please wait for an administrator to review it.</h1>
                        <div class="logout-btn mt-4">
                            <a href="Logout" class="btn btn-danger">Logout</a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:when test="${sessionScope.status eq 'active'}">
                <jsp:include page="stall_header.jsp" />

                <main>
                    <div style="margin-top: 100px;">
                        <div class="container rating-section">
                            <div class="rating-info">
                                <h5>Average Rating</h5>
                                <h2>
                                    <c:out value="${averageRating}" /> <small>/ 5</small>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                        <c:choose>
                                            <c:when test="${loop.index <= averageRating}">
                                                <i class="fas fa-star text-warning"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star text-warning"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </h2>

                                <div class="star-counts">
                                    <div class="row">
                                        <c:forEach var="count" items="${starCounts}" varStatus="loop">
                                            <div class="col-sm-6 col-md-4">
                                                <p>
                                                    <c:out value="count" /> <i class="fas fa-star text-warning"></i> (
                                                    <c:out value="${loop.index}" /> stars)</p>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container stats-section">
                            <h2>Statistics</h2>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Gender</h5>
                                            <p class="card-text">Male:
                                                <c:out value="${maleCount}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Gender</h5>
                                            <p class="card-text">Female:
                                                <c:out value="${femaleCount}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Orders</h5>
                                            <p class="card-text">Total Orders:
                                                <c:out value="${ordersCount}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


<div class="container mt-4">
                <h1>Order History</h1>
                <table class="table table-striped table-dark">
                    <thead class="thead-dark">
                        <tr>
                            <th>Date</th>
                            <th>Menu</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th>Rating</th>
                            <th>Feedback</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty orderHistory}">
                                <tr>
                                    <td colspan="6" class="text-center">No orders yet</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${orderHistory}" var="order">
                                    <tr>
                                        <td>
                                            <c:out value="${order.date}" />
                                        </td>
                                        <td>
                                            <c:out value="${order.menu}" />
                                        </td>
                                        <td>
                                            <c:out value="${order.quantity}" />
                                        </td>
                                        <td>
                                            <c:out value="${order.price}" />
                                        </td>
                                        <td>
                                            <c:out value="${order.rating}" />
                                        </td>
                                        <td>
                                            <c:out value="${order.feedback}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>




                </main>
            </c:when>
        </c:choose>

        <!-- Bootstrap JS and jQuery links -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>