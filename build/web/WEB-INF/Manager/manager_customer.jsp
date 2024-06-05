<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Customer Management</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="manager_header.jsp" />
            <div class="container mt-4">
                <h1>Customer Management</h1>
                <div class="d-flex justify-content-end mb-3">
                    <form class="form-inline" action="ManagerCustomer" method="get">
                        <div class="form-group">
                            <input type="text" class="form-control" name="search" id="searchInput" placeholder="Search by username">
                        </div>
                        <button type="submit" class="btn btn-primary ml-2">Search</button>
                    </form>
                </div>
                <table  class="table table-striped table-dark">
                    <thead class="thead-dark">
                        <tr>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Contact Number</th>
                            <th>Password</th>
                            <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users}">
                                <tr>
                                    <td colspan="7" class="text-center">No results found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <form action="ManagerCustomer" method="post">
                                            <input type="hidden" name="accname" value="${user.accname}">
                                            <td><input type="text" class="form-control" name="name" value="${user.name}"></td>
                                            <td><input type="number" class="form-control" name="age" value="${user.age}"></td>
                                            <td><input type="text" class="form-control" name="gender" value="${user.gender}"></td>
                                            <td><input type="text" class="form-control" name="contact_number" value="${user.contact_number}"></td>
                                            <td><input type="text" class="form-control" name="password" value="${user.password}"></td>
                                            <input type="hidden" name="status" value="${user.status}">
                                            <td>
                                                <button type="submit" class="btn btn-primary" name="action" value="update">Update</button>
                                            </td>
                                            <td>
                                                <button type="submit" class="btn btn-danger" name="action" value="delete">Delete</button>
                                            </td>
                                        </form>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                    </tbody>
                </table>
            </div>
        </body>

        </html>