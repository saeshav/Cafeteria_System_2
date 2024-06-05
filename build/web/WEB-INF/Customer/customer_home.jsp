<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Menu Page</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <style>
                .items {
                    display: flex;
                    flex-wrap: wrap;
                    justify-content: space-around;
                    margin-top: 20px;
                }
                
                .menu_item {
                    border: 1px solid #ccc;
                    border-radius: 5px;
                    margin: 10px;
                    padding: 10px;
                    width: 300px;
                    cursor: pointer;
                    transition: transform 0.3s ease-in-out;
                }
                
                .menu_item:hover {
                    transform: scale(1.05);
                }
                
                .menu_img img {
                    width: 100%;
                    height: 150px;
                    object-fit: cover;
                }
            </style>
        </head>

        <body>
            <jsp:include page="customer_header.jsp" />
            <div class="container mt-4">
                <h1>Menus</h1>

                <div class="modal" id="exampleModal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Item Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                            </div>
                            <div class="modal-body">
                                <img src="" alt="Item Image" class="item-image" style="max-width: 100%;">
                                <p><em>Price per unit: $<span class="item-price"></span></em></p>
                                <input type="hidden" class="item-id">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-success addToCartBtn">Add to Cart</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <main class="container">
                    <div class="items">
                        <c:forEach var="menu" items="${menus}">
                            <div class="menu_item" data-toggle="modal" data-target="#exampleModal">
                                <input type="hidden" name="menuId" value="${menu.id}">
                                <div class="menu_img">
                                    <img src="${menu.image}" alt="${menu.item} Image">
                                </div>
                                <div class="menu_content">
                                    <h2>${menu.item}</h2>
                                    <p><em>Price per unit: $${menu.price}</em></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </main>
            </div>

            <script>
                $(document).ready(function() {
                    $('.menu_item').click(function() {
                        var itemId = $(this).find('input[name="menuId"]').val();

                        $.ajax({
                            type: 'GET',
                            url: 'CustomerHome',
                            data: {
                                itemId: itemId
                            },
                            success: function(menu) {
                                $('#exampleModal .modal-title').text(menu.itemName);
                                $('#exampleModal .modal-body .item-image').attr('src', menu.itemImage);
                                $('#exampleModal .modal-body .item-price').text(menu.itemPrice);
                                $('#exampleModal .modal-body .item-id').val(menu.itemId);
                            },
                            error: function(err) {
                                console.error('Error fetching menu:', err);
                            }
                        });
                    });

                    $('.addToCartBtn').click(function() {
                        var itemId = $('#exampleModal .item-id').val();

                        var data = {
                            id: itemId
                        };

                        $.ajax({
                            type: 'POST',
                            url: 'CustomerHome',
                            data: data,
                            success: function(response) {
                                console.log('Item added to cart!');
                                $('#exampleModal').modal('hide');
                            },
                            error: function(err) {
                                console.error('Error adding item to cart:', err);
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>