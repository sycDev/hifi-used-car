<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Manage Bids</title>
	<link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/table-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
<!-- Header Include -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<div class="container-fluid mt-5 pt-5">
		<div class="back ms-5">
			<a href="/dashboard" class="text-decoration-none">
				<i class="fas fa-arrow-left"></i> Back to Dashboard
			</a>
		</div>
		
		<!-- Toast Return Message Start -->
		<div class="fixed-bottom m-3">
			<div class="toast align-items-center position-relative" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-content d-flex align-items-center p-3">
					<div class="me-3" id="toast-icon"></div>
					<div class="d-flex justify-content-between w-100 fs-6" id="toast-message"></div>
					<div>
						<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
					</div>
				</div>
			</div>
		</div>
		<!-- Toast Return Message End -->
		
		<!-- Bid Data Listing Start -->
		<h3 class="text-center m-4">Bid Data</h3>
		
		<c:if test="${empty bidList}">
			<div class="text-center mx-auto my-5">
				<h4 class="text-muted">No Bid Record Yet</h4>
				<img class="img-fluid" src="/assets/images/no-result.png" alt="No Bid Record" width="320" height="auto">
			</div>
		</c:if>
		
		<c:if test="${not empty bidList}">
			<div class="table-responsive mx-5 mb-5">
				<table class="table table-striped table-hover align-middle mb-5 bg-white">
					<thead class="table-light">
						<tr>
							<th scope="col">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="select-all" />
								</div>
							</th>
							<th scope="col">No.</th>
							<th scope="col">Bid ID</th>							
							<th scope="col">Listing ID</th>
							<th scope="col">Listing Name</th>
							<th scope="col">Bidder ID</th>
							<th scope="col">Bidder</th>
							<th scope="col">Bid Price</th>
							<th scope="col">Placed Time</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bidList}" var="bid" varStatus="loop">
							<tr>
								<th scope="row">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" />
									</div>
								</th>
								<td>${loop.index + 1}</td>
								<td>${bid.bidId}</td>
								<td>
									<a href="/listing/${bid.listing.listingId}">${bid.listing.listingId}</a>
								</td>
								<td>${bid.listing.regYear} ${bid.listing.make} ${bid.listing.model}</td>
								<td>
									<a href="/dashboard/edit-user/${bid.user.userId}">${bid.user.userId}</a>
								</td>
								<td>${bid.user.username}</td>
								<td>
									<fmt:formatNumber value="${bid.bidPrice}" pattern="#,##0" var="formattedBidPrice" />
									RM${formattedBidPrice} <br>
								</td>
								<td>
									<fmt:formatDate value="${bid.createdAt}" pattern="dd MMMM yyyy hh:mm:ss aa"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		<!-- Bid Data Listing End -->
	</div>
</main>

<!-- Footer -->
<%@ include file="component/footer.jsp" %>
</body>
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/e19fcdf015.js" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous">
</script>
<script>
	$(document).ready(function() {
	    // Showing the success message from controller
	    <c:if test="${not empty successMsg}">
	        showToast("${successMsg}", true);
	    </c:if>
	    
	 	// Showing the error message from controller
	    <c:if test="${not empty errorMsg}">
	        showToast("${errorMsg}", false);
	    </c:if>
	});

	function showToast(message, isSuccess) {
	    if (isSuccess) {
	        $('#toast-icon').html('<i class="fa fa-circle-check fa-xl d-flex" style="color: #228B22"></i>');
	    } else {
	        $('#toast-icon').html('<i class="fa fa-circle-exclamation fa-xl d-flex" style="color: #D90429"></i>');
	    }
	    $('#toast-message').html(message);
	    $('.toast').toast('show');
	}

	$('#select-all').click(function() {
		$('tbody input[type="checkbox"]').prop('checked',
				$(this).prop('checked'));
	});

	$('tbody input[type="checkbox"]').click(function() {
		if (!$(this).prop('checked')) {
			$('#select-all').prop('checked', false);
		}
	});
</script>
</html>