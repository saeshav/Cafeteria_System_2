<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <nav id="menu" class="navbar navbar-expand-lg  navbar-dark bg-dark">
        <h1><a class="navbar-brand" href="CustomerHome">Home</a></h1>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto ">
                <li class="nav-item">
                    <a class="nav-link" href="CustomerProfile">
                        Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="CustomerHistory">
                        History
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#balanceModal">
                        Balance: <span id="balanceValue"><c:out value="${balance}" /></span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="CustomerCart">
                        Cart
                        <c:if test="${sessionScope.cartItems ne null}">
                            (<c:out value="${sessionScope.cartItems.size()}" />)
                        </c:if>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Logout">
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<div class="modal fade" id="balanceModal" tabindex="-1" role="dialog" aria-labelledby="balanceModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="balanceModalLabel">Edit Balance</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="balanceForm">
                    <div class="form-group">
                        <label for="newBalance">New Balance:</label>
                        <input type="number" class="form-control" id="newBalance" name="newBalance" min="0" step="1" pattern="\d+" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
                </form>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        function fetchBalance() {
                fetch('Balance')
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(data => {
                        document.getElementById('balanceValue').textContent = data;
                    })
                    .catch(error => {
                        console.error('Fetch error:', error);
                    });
        }
        fetchBalance();

        $('a[href="#"]').on('click', function(e) {
            e.preventDefault();
            $('#balanceModal').modal('show');
        });

        $('#balanceForm').submit(function(e) {
            e.preventDefault();
            var newBalance = $('#newBalance').val();
            // Perform actions to save the new balance, e.g., through AJAX or form submission
            fetch('Balance', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'balance=' + newBalance
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(data => {
                $('#balanceValue').text(newBalance);
                $('#balanceModal').modal('hide');
                $('.modal-backdrop').remove();
            })
            .catch(error => {
                console.error('Fetch error:', error);
            });
        });
    });
</script>

