<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Manager Profile</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="manager_header.jsp" />
            <div class="container mt-4">
                <h1>Manager Profile</h1>
                <div class="card">
                    <div class="card-body">
                        <form id="profileForm">
                            <div class="form-group">
                                <input type="hidden" name="managerRelationId" value="${manager.managerRelation.id}">
                                <label for="accname">Username:</label>
                                <input type="text" class="form-control" id="accname" name="accnameDisabled" value="${manager.accname}" readonly disabled>
                                <input type="hidden" name="accname" value="${manager.accname}">
                            </div>
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${manager.name}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="age">Age:</label>
                                <input type="number" class="form-control" id="age" name="age" value="${manager.age}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender:</label>
                                <input type="text" class="form-control" id="gender" name="gender" value="${manager.gender}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="contact_number">Contact Number:</label>
                                <input type="text" class="form-control" id="contact_number" name="contact_number" value="${manager.contact_number}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" value="${manager.password}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="status">Role:</label>
                                <input type="text" class="form-control" id="status" name="statusDisabled" value="${manager.status}" readonly disabled>

                            </div>
                            <!-- Add more fields or adjust as needed -->
                            <button type="button" class="btn btn-primary" id="editButton">Edit</button>
                            <button type="submit" class="btn btn-success" id="saveButton" style="display: none;">Save</button>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script>
                $(document).ready(function() {
                    $('#editButton').click(function() {
                        $('input').removeAttr('readonly');
                        $('#saveButton').show();
                    });

                    $('#profileForm').submit(function(event) {
                        event.preventDefault();
                        var formData = $(this).serialize();
                        console.log(formData);
                        $.ajax({
                            type: 'POST',
                            url: 'ManagerProfile',
                            data: formData,
                            success: function(response) {
                                // Handle success response if needed
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>