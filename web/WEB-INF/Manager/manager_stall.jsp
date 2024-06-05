<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Staff Details</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="manager_header.jsp" />
            <div class="container mt-4">
                <h1>Staff Details</h1>
                <div class="d-flex justify-content-end mb-3">
                    <form class="form-inline" action="ManagerStallStaff" method="get">
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
                            <th>Status</th>
                            <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty staffList}">
                                <tr>
                                    <td colspan="8" class="text-center">No results found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="staff" items="${staffList}">
                                    <tr>
                                        <form action="ManagerStallStaff" method="post">
                                            <input type="hidden" name="accname" value="${staff.accname}">
                                            <input type="hidden" name="stallProfile" value="${staff.stallProfile.id}">
                                            <td><input type="text" class="form-control" name="name" value="${staff.name}"></td>
                                            <td><input type="number" class="form-control" name="age" value="${staff.age}"></td>
                                            <td><input type="text" class="form-control" name="gender" value="${staff.gender}"></td>
                                            <td><input type="text" class="form-control" name="contact_number" value="${staff.contact_number}"></td>
                                            <td><input type="text" class="form-control" name="password" value="${staff.password}"></td>
                                            <td>
                                                <select class="form-control" name="status">
                                            <option value="active" <c:if test="${staff.status eq 'active'}">selected</c:if>>Active</option>
                                            <option value="inactive" <c:if test="${staff.status eq 'inactive'}">selected</c:if>>Inactive</option>
                                        </select>
                                            </td>
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