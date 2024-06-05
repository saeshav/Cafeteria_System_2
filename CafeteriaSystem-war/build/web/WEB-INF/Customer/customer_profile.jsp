<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Customer Profile</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <!-- Include your header -->
            <jsp:include page="customer_header.jsp" />

            <div class="container mt-4">
                <h1>Customer Profile</h1>
                <div class="card">
                    <div class="card-body">
                        <form id="profileForm" method="post">
                            <div class="form-group">
                                <label for="accname">Username:</label>
                                <input type="text" class="form-control" id="accname" name="accnameDisabled" value="${customer.accname}" readonly disabled>
                                <input type="hidden" name="accname" value="${customer.accname}">
                            </div>
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${customer.name}" readonly disabled>
                            </div>
                            <div class="form-group">
                                <label for="contact_number">Contact Number:</label>
                                <!--<input type="text" class="form-control" id="contact_number" name="contact_number" value="${customer.contact_number}" readonly>-->
                            </div>
                            <div class="form-group">
                                <label for="contactNumber">Password:</label>
                                <input type="text" class="form-control" id="contact_number" name="password" value="${customer.password}" readonly>
                            </div>
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
                        $.ajax({
                            type: 'POST',
                            url: 'CustomerProfile', // 
                            data: formData,
                            success: function(response) {
                                console.log("Success");
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>