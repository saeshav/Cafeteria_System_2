<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>User Login</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>

    <body class="bg-dark">


        <div class="container-fluid">

            <c:if test="${param.success == 'false'}">
                <div class="alert alert-danger">
                    Please check your login credentials once again.
                </div>
            </c:if>

            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <header class="text-center py-4">
                            <h1 class="text-white">Welcome to</h1>
                            <div>
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-d7ex3EVlHuljTvq_QhVdl7WnNF9ZBcZjYw&usqp=CAU" alt="Cafeteria Logo" class="img-fluid">
                            </div>
                        </header>
                        <form action="Login" method="post">
                            <div class="form-group">
                                <label for="accname" class="text-white">Username:</label>
                                <input type="text" class="form-control" id="accname" name="accname" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-white">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-success  btn-block">Login</button>
                          
                            <c:if test="${success == 'false'}">
                                <div class="alert alert-danger mt-3 text-center" role="alert">
                                    Username or Password are incorrect, please try again
                                </div>
                            </c:if>
                        </form>
                          <p class="mt-3 text-center text-white">Select a role to register</p>
                        <button class="btn btn-success  btn-block mb-2" onclick="goToPage('customer')">Customer Registration</button>
                        <button class="btn btn-success  btn-block mb-2" onclick="goToPage('stallStaff')">Stall Staff Registration</button>
                        <button class="btn btn-success  btn-block" onclick="goToPage('manager')">Manager Registration</button>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>

                            function goToPage(pageName) {
                                const CUSTOMER_PAGE = "CustomerRegister";
                                const MANAGER_PAGE = "ManagerRegister";
                                const STALL_STAFF_PAGE = "StallStaffRegister";
                                if (pageName === "customer") {
                                    window.location.href = CUSTOMER_PAGE;
                                } else if (pageName === "stallStaff") {
                                    window.location.href = STALL_STAFF_PAGE;
                                } else if (pageName === "manager") {
                                    window.location.href = MANAGER_PAGE;
                                }
                            }
        </script>

    </body>

</html>