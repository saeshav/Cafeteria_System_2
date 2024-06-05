<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Cart</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <!-- Include your header or navigation section -->
            <jsp:include page="customer_header.jsp" />

            <div class="container mt-4">
                <h1>Cart</h1>
                <table class="table table-striped table-dark">
                    <thead class="thead-dark">
                        <tr>
                            <th>Menu</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty cartItems}">
                                <tr>
                                    <td colspan="4" class="text-center">No items found in the cart.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${cartItems}" var="item">
                                    <tr>
                                        <td>
                                            <c:out value="${item.item}" />
                                        </td>
                                        <td>
                                            <!-- Quantity selector -->
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                            <button type="button" class="btn btn-secondary quantity-minus">-</button>
                                        </span>
                                                <span>
                                            <input type="text" class="form-control quantity text-center" value="1" readonly>
                                        </span>
                                                <span class="input-group-btn">
                                            <button type="button" class="btn btn-secondary quantity-plus">+</button>
                                        </span>
                                            </div>
                                        </td>
                                        <td><span class="totalPrice" data-price="${item.price}">${item.price}</span></td>
                                        <td>
                                            <!-- Button to remove item from cart -->
                                            <button class="btn btn-danger removeItem" data-itemid="${item.id}">Remove</button>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:otherwise>
                        </c:choose>
                    </tbody>
                    <tfoot>
                        <!-- Total price row -->
                        <tr>
                            <td colspan="2"></td>
                            <td><strong>Total: <span id="totalPrice">0.00</span></strong></td>
                            <td></td>
                        </tr>
                        <!-- Checkout button row -->
                        <tr>
                            <td colspan="4" class="text-center">
                                <button class="btn btn-primary checkoutBtn">Checkout</button>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <!-- Checkout Modal -->
            <div class="modal fade " id="checkoutModal" tabindex="-1" role="dialog" aria-labelledby="checkoutModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="checkoutModalLabel">Checkout Summary</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                        </div>
                        <div class="modal-body">
                            <!-- Summary of items -->
                            <div class="summary-items">
                                <!-- Dynamically populated by JavaScript -->
                            </div>
                            <!-- Rating and feedback -->
                            <div class="rating-feedback">
                                <label for="ratingStars">Rate your experience:</label>
                                <input type="number" class="form-control" id="ratingStars" min="1" max="5">
                                <label for="feedbackTextarea">Feedback:</label>
                                <textarea class="form-control" id="feedbackTextarea" rows="4"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Pay</button>
                        </div>
                    </div>
                </div>
            </div>



            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script>
                $(document).ready(function() {
                    function updateTotalPrice(row) {
                        var quantity = parseInt(row.find('.quantity').val(), 10);
                        var price = parseFloat(row.find('.totalPrice').attr('data-price'));
                        var totalPrice = quantity * price;

                        if (!isNaN(totalPrice)) {
                            row.find('.totalPrice').text(totalPrice.toFixed(2));
                            updateTotal(); // Update total price of all items
                        }
                    }

                    // Increment quantity
                    $('.quantity-plus').click(function() {
                        var input = $(this).closest('tr').find('.quantity');
                        var value = parseInt(input.val(), 10);
                        input.val(value + 1);
                        updateTotalPrice($(this).closest('tr'));
                    });

                    // Decrement quantity
                    $('.quantity-minus').click(function() {
                        var input = $(this).closest('tr').find('.quantity');
                        var value = parseInt(input.val(), 10);
                        if (value > 1) {
                            input.val(value - 1);
                            updateTotalPrice($(this).closest('tr'));
                        }
                    });

                    // Update total price when quantity changes
                    $('.quantity').on('input', function() {
                        updateTotalPrice($(this).closest('tr'));
                    });

                    // Remove item from cart
                    $('.removeItem').click(function() {
                        var itemId = $(this).data('itemid');
                        console.log(itemId);
                        // Remove item from the cart list in UI
                        $(this).closest('tr').remove();

                        // Send a POST request to the servlet to delete the item from the cart
                        $.ajax({
                            type: 'POST',
                            url: 'CustomerCart',
                            data: {
                                itemId: itemId
                            },
                            success: function(response) {
                                console.log('Item removed from cart!');
                            },
                            error: function(err) {
                                console.error('Error removing item from cart:', err);
                            }
                        });
                        updateTotal(); // Update total price after removing item
                    });

                    // Calculate and update the total price of all items
                    function updateTotal() {
                        var total = 0;
                        $('.totalPrice').each(function() {
                            total += parseFloat($(this).text());
                        });
                        $('#totalPrice').text(total.toFixed(2));
                    }

                    // Initial update of total price
                    updateTotal();

                    // Checkout button click event
                    $('.checkoutBtn').click(function() {
                        var totalPrice = parseFloat($('#totalPrice').text());
                        var balance = parseFloat($('#balanceValue').text());

                        if (totalPrice > balance || totalPrice === 0) {
                            // Disable checkout if total price exceeds balance or if there are no items
                            $('#checkoutModal').modal('hide');
                            return;
                        }

                        var items = [];
                        $('.totalPrice').each(function() {
                            var itemName = $(this).closest('tr').find('td:first').text().trim();
                            var itemPrice = parseFloat($(this).text());
                            items.push({
                                name: itemName,
                                price: itemPrice
                            });
                        });

                        var modalContent = '<div class="modal-dialog modal-dialog-centered modal-lg" role="document">';
                        modalContent += '<div class="modal-content">';
                        modalContent += '<div class="modal-header">';
                        modalContent += '<h5 class="modal-title">Checkout Summary</h5>';
                        modalContent += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
                        modalContent += '<span aria-hidden="true">&times;</span></button></div>';
                        modalContent += '<div class="modal-body">';

                        items.forEach(function(item) {
                            modalContent += "<p>" + item.name + ": " + item.price.toFixed(2) + "</p>";
                        });

                        modalContent += '<div class="rating-section">';
                        modalContent += '<label for="ratingStars">Rate your experience:</label>';
                        modalContent += '<input type="number" min="1" max="5" id="rating">';
                        modalContent += '</div>';

                        modalContent += '<div class="feedback-section">';
                        modalContent += '<label for="feedbackTextarea">Feedback:</label>';
                        modalContent += '<textarea class="form-control" rows="4" id="feedbackTextarea"></textarea>';
                        modalContent += '</div>';

                        modalContent += '</div>';
                        modalContent += '<div class="modal-footer">';
                        modalContent += '<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>';
                        modalContent += '<button type="button" class="btn btn-primary">Pay</button>';
                        modalContent += '</div></div></div>';

                        $('#checkoutModal .modal-dialog').html(modalContent);
                        $('#checkoutModal').modal('show');

                        // Handle click on the "Pay" button in the modal
                        $('.modal-footer .btn-primary').click(function() {
                            var itemsSummary = "";
                            var totalQuantity = 0;
                            $('.totalPrice').each(function() {
                                var itemName = $(this).closest('tr').find('td:first').text().trim();
                                var itemQuantity = $(this).closest('tr').find('.quantity').val();
                                totalQuantity += parseFloat(itemQuantity);
                                itemsSummary += itemName + "x" + itemQuantity + " ";
                            });

                            console.log(itemsSummary);

                            var rating = $('#rating').val();
                            var feedback = $('#feedbackTextarea').val();

                            var dataToSend = {
                                menu: itemsSummary,
                                quantity: totalQuantity,
                                rating: rating,
                                feedback: feedback,
                                totalPrice: totalPrice,
                                balance: balance
                            };

                            $.ajax({
                                type: 'POST',
                                url: 'CustomerCart',
                                data: dataToSend,
                                success: function(response) {
                                    console.log('Payment successful!');
                                    window.location.href = "CustomerHome";
                                },
                                error: function(err) {
                                    console.error('Error making payment:', err);
                                }
                            });

                            // Close the modal after submitting payment
                            $('#checkoutModal').modal('hide');
                        });

                    });

                });
            </script>
        </body>

        </html>