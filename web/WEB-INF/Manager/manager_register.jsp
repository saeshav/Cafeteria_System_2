<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Manager Registration</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body class="bg-dark">

            <div class="container mt-4">
                <h1 class="text-center  text-white">Manager Registration</h1>
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <form action="ManagerRegister" method="post">
                            <div class="form-group">
                                <label  class="text-white">Name:</label>
                                <input type="text" class="form-control" id="Name" name="Name" required>
                            </div>

                            <div class="form-group">
                                <label class="text-white">Age:</label>
                                <input type="text" class="form-control" id="Age" name="Age" required>
                            </div>

                            <div class="form-group">
                                <label  class="text-white">Gender:</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="Gender" id="Male" value="Male" required>
                                    <label class="form-check-label text-white">Male</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input"type="radio" name="Gender" id="Female" value="Female" required>
                                    <label class="form-check-label text-white" >Female</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label  class="text-white">Contact Number:</label>
                                <input type="text" class="form-control text-white" id="contact_number" name="contact_number" required>
                            </div>

                            <div class="form-group">
                                <label  class="text-white">Email:</label>
                                <input type="text" class="form-control" id="accname" name="accname" required>
                            </div>

                            <div class="form-group">
                                <label  class="text-white">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="text-center">
                                <input type="submit" class="btn btn-success btn-block" value="Register">
                            </div>

                            <c:if test="${success == 'true'}">
                                <div class="alert alert-success mt-3 text-center" role="alert">
                                    You have successfully registered an account.
                                </div>
                            </c:if>

                            <c:if test="${success == 'false'}">
                                <div class="alert alert-danger mt-3 text-center" role="alert">
                                    A user with that username already registered. Please choose another username.
                                </div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        </body>

        </html>