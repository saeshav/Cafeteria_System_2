<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Manager Management</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="manager_header.jsp" />
            <div class="container mt-4">
                <h1>Manager Management</h1>
                <!-- Add Manager Button to Trigger Modal -->
                <button type="button" class="btn btn-success mb-2" data-toggle="modal" data-target="#addManagerModal">Add Manager</button>

                <!-- Modal for adding a manager -->
                <div class="modal fade" id="addManagerModal" tabindex="-1" role="dialog" aria-labelledby="addManagerModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addManagerModalLabel">Add Manager</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                            </div>
                            <!-- Form to Add Manager -->
                            <form id="addManagerForm" method="post" action="ManagerDetails">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="accname">Username</label>
                                        <input type="text" class="form-control" id="accname" name="accname" placeholder="accname" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" placeholder="Name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="age">Age</label>
                                        <input type="number" class="form-control" id="age" name="age" placeholder="Age" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select class="form-control" id="gender" name="gender" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="contactNumber">Contact Number</label>
                                        <input type="text" class="form-control" id="contact_number" name="contact_number" placeholder="Contact Number" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary" name="action" value="add">Add Manager</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end mb-3">
                    <form class="form-inline" action="ManagerDetails" method="get">
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
                            <c:when test="${empty managers}">
                                <tr>
                                    <td colspan="8" class="text-center">No results found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="manager" items="${managers}">
                                    <tr>
                                        <form action="ManagerDetails" method="post">
                                            <input type="hidden" name="accname" value="${manager.accname}">
                                            <td><input type="text" class="form-control" name="name" value="${manager.name}" readonly></td>
                                            <td><input type="number" class="form-control" name="age" value="${manager.age}" readonly></td>
                                            <td><input type="text" class="form-control" name="gender" value="${manager.gender}" readonly></td>
                                            <td><input type="text" class="form-control" name="contact_number" value="${manager.contact_number}"></td>
                                            <td><input type="text" class="form-control" name="password" value="${manager.password}"></td>
                                            <input type="hidden" name="status" value="${manager.status}">
                                            <td>
                                                <button type="submit" class="btn btn-primary btn-sm" name="action" value="update">Update</button>
                                            </td>
                                            <td>
                                                <button type="submit" class="btn btn-danger btn-sm" name="action" value="delete">Delete</button>
                                            </td>
                                        </form>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                    </tbody>
                </table>
            </div>

            <!-- jQuery and Bootstrap JS -->
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        </body>

        </html>