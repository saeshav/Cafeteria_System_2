<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Menu Management</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="stall_header.jsp" />
            <div class="container mt-4">
                <h1>Menu Management</h1>

                <!-- Add Menu Button to Trigger Modal -->
                <button type="button" class="btn btn-success mb-2" data-toggle="modal" data-target="#addMenuModal">Add Menu</button>

                <!-- Modal for adding a menu item -->
                <div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="addMenuModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addMenuModalLabel">Add Menu</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                            </div>
                            <!-- Form to Add Menu -->
                            <form id="addMenuForm" method="post" action="StallStaffMenu">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="item">Item</label>
                                        <input type="text" class="form-control" id="item" name="item" placeholder="Item" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Price</label>
                                        <input type="number" step="0.01" class="form-control" id="price" name="price" placeholder="Price" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="image">Image</label>
                                        <input type="text" class="form-control" id="image" name="image" placeholder="Image URL" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary" name="action" value="add">Add Menu</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end mb-3">
                    <!-- Search Menu Form -->
                    <form class="form-inline" action="StallStaffMenu" method="get">
                        <div class="form-group">
                            <input type="text" class="form-control" name="search" id="searchInput" placeholder="Search by item">
                        </div>
                        <button type="submit" class="btn btn-primary ml-2">Search</button>
                    </form>
                </div>

                <!-- Menu Items Table -->
                <table class="table table-striped table-dark">
                    <thead class="thead-dark">
                        <tr>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty menuItems}">
                                <tr>
                                    <td colspan="4" class="text-center">No results found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="menuItem" items="${menuItems}">
                                    <tr>
                                        <form action="StallStaffMenu" method="post">
                                            <input type="hidden" name="id" value="${menuItem.id}">
                                            <td><input type="text" class="form-control" name="item" value="${menuItem.item}"></td>
                                            <td><input type="number" step="0.01" class="form-control" name="price" value="${menuItem.price}"></td>
                                            <td><input type="text" class="form-control" name="image" value="${menuItem.image}"></td>
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