<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Order History</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <!-- Include your header or navigation section -->
            <jsp:include page="customer_header.jsp" />

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

            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        </body>

        </html>