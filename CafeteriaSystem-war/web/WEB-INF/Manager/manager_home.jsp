<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manager Home</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- Include Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.0"></script>
        <style>
            /* Custom styles for cards */
            .card {
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease-in-out;
            }
            .card:hover {
                transform: translateY(-5px);
            }

            /* Custom style for admin dashboard section */
            .dashboard-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
            }

            .dashboard-section h5 {
                margin-bottom: 20px;
                font-size: 1.5rem;
            }

            .dashboard-section p {
                font-size: 1.2rem;
            }

            .dashboard-section .rating-info {
                margin-top: 15px;
            }
            .rating-stars i {
                color: #ffc107;
                font-size: 1.5rem;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="manager_header.jsp" />
        <main>
            <div>
                <div style="margin-top: 80px;">
                    <div class="container mt-4">
                        <div>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Rating and Feedback</h5>
                                    <div class="rating-summary">

                                        <!-- Display the average rating -->
                                        <h2 class="average-rating">
                                            <c:out value="${averageRating}" /> <small>/ 5</small> 
                                            <i class="fas fa-star text-warning"></i> 
                                        </h2>


                                        <div class="star-counts">
                                            <div class="row">
                                                <div class="col-sm-6 col-md-4">
                                                    <p><c:out value="${starCounts[4]}" /> <i class="fas fa-star text-warning"></i> (5 stars)</p>
                                                </div>
                                                <div class="col-sm-6 col-md-4">
                                                    <p><c:out value="${starCounts[3]}" /> <i class="fas fa-star text-warning"></i> (4 stars)</p>
                                                </div>
                                                <div class="col-sm-6 col-md-4">
                                                    <p><c:out value="${starCounts[2]}" /> <i class="fas fa-star text-warning"></i> (3 stars)</p>
                                                </div>
                                                <div class="col-sm-6 col-md-4">
                                                    <p><c:out value="${starCounts[1]}" /> <i class="fas fa-star text-warning"></i> (2 stars)</p>
                                                </div>
                                                <div class="col-sm-6 col-md-4">
                                                    <p><c:out value="${starCounts[0]}" /> <i class="fas fa-star text-warning"></i> (1 star)</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h2>Stats</h2>
                        <div class="row">
                            <!-- Card for Orders -->
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Orders</h5>
                                        <p class="card-text">Total Orders: <c:out value="${ordersCount}" /></p>
                                        <!-- Other information or visualization for Orders -->
                                    </div>
                                </div>
                            </div>

                            <!-- Card for Customers -->
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Customers</h5>
                                        <p class="card-text">Total Customers: <c:out value="${customersCount}" /></p>
                                        <!-- Other information or visualization for Customers -->
                                    </div>
                                </div>
                            </div>

                            <!-- Card for Managers -->
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Managers</h5>
                                        <p class="card-text">Total Managers: <c:out value="${managersCount}" /></p>
                                        <!-- Other information or visualization for Managers -->
                                    </div>
                                </div>
                            </div>

                            <!-- Card for Stall Staff -->
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Stalls</h5>
                                        <p class="card-text">Total Stall Staff: <c:out value="${stallStaffCount}" /></p>
                                        <!-- Other information or visualization for Stall Staff -->
                                    </div>
                                </div>
                            </div>

                            <!-- Card for Menus -->
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Menus</h5>
                                        <p class="card-text">Total Menus: <c:out value="${menusCount}" /></p>
                                        <!-- Other information or visualization for Menus -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container mt-4">
                        <canvas id="myChart" width="400" height="200"></canvas>
                    </div>
                </div>
            </div>
        </main>

        <script>
            // Data for the chart (example)
            const statistics = {
                labels: ['Orders', 'Customers', 'Managers', 'Stalls', 'Menu'],
                data: [<c:out value="${ordersCount}" />,
            <c:out value="${customersCount}" />,
            <c:out value="${managersCount}" />,
            <c:out value="${stallStaffCount}" />,
            <c:out value="${menusCount}" />]
            };

            // Get the canvas element
            const ctx = document.getElementById('myChart').getContext('2d');

            // Create the chart using Chart.js
            const myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: statistics.labels,
                    datasets: [{
                            label: '',
                            data: statistics.data,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>

        <!-- Bootstrap and jQuery scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
