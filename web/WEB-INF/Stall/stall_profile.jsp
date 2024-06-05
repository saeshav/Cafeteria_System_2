<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Stall Staff Profile</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <jsp:include page="stall_header.jsp" />
            <div class="container mt-4">
                <h1>Stall Profile</h1>
                <div class="card">
                    <div class="card-body">
                        <form id="profileForm" method="post">
                            <div class="form-group">
                                <label for="accname">Username:</label>
                                <input type="text" class="form-control" id="accname" name="accnameDisabled" value="${stallStaff.accname}" readonly disabled>
                                <input type="hidden" name="accname" value="${stallStaff.accname}">
                            </div>
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${stallStaff.name}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="age">Age:</label>
                                <input type="text" class="form-control" id="age" name="age" value="${stallStaff.age}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender:</label>
                                <input type="text" class="form-control" id="gender" name="gender" value="${stallStaff.gender}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="contact_number">Contact Number:</label>
                                <input type="text" class="form-control" id="contact_number" name="contact_number" value="${stallStaff.contact_number}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" value="${stallStaff.password}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="status">Role:</label>
                                <input type="text" class="form-control" id="status" name="statusDisabled" value="${stallStaff.status}" readonly disabled>
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
                            url: 'StallStaffProfile',
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