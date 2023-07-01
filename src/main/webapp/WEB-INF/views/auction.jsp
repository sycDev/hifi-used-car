<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Live Auction</title>
	<link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/auction-style.css">
	<!-- Form Styling -->
	<link rel="stylesheet" type="text/css" href="/css/form-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
	      integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<!-- Bootstrap Datepicker -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"
		integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw=="
		crossorigin="anonymous" referrerpolicy="no-referrer">
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section class="container py-4 mt-5">
		<h1 class="display-6 text-center my-3">Auction</h1>

		<!-- Navigation Start -->
		<div class="pill-nav mb-3">
			<a class="active" href="/auction">Ongoing</a>
			<a href="/past-auction">Past</a>
		</div>
		<!-- Navigation End -->

		<!-- Filter Listing Start -->
		<div class="filter-search">
			<div class="mb-2">
				<button class="btn" type="button" id="filter-btn"
					data-bs-toggle="collapse" data-bs-target=".multi-collapse" 
					aria-expanded="false" aria-controls="filter-year-collapse filter-price-collapse filter-submit">
						
						Filter by Year & Price
				</button>
			</div>

			<div class="row">
				<!-- Filter by Registration Year Start -->
				<div class="col-lg-6 mb-lg-0 mb-2">
					<div class="collapse multi-collapse" id="filter-year-collapse">
						<div class="card card-body">
							Registration Year:
							<div class="row">
								<div class="col-6">
									<input type="text" id="yearFrom" name="yearFrom" placeholder="From" class="form-control my-1" data-date-format="yyyy">
								</div>
								<div class="col-6">
									<input type="text" id="yearTo" name="yearTo" placeholder="To" class="form-control my-1" data-date-format="yyyy" disabled>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Filter by Registration Year End -->
				
				<!-- Filter by Price Start -->
				<div class="col-lg-6">
					<div class="collapse multi-collapse" id="filter-price-collapse">
						<div class="card card-body">
							Price:
							<div class="row">
								<div class="col-6">
									<input type="number" id="priceFrom" name="priceFrom" placeholder="From" class="form-control my-1">	
								</div>
								<div class="col-6">
									<input type="number" id="priceTo" name="priceTo" placeholder="To" class="form-control my-1">
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Filter by Price End -->
			</div>

			<!-- Filter Search Button Start -->
			<div class="row my-2">
				<div class="col-12">
					<div class="collapse multi-collapse" id="filter-submit">
						<button class="btn w-100 mb-4" id="filter-submit-btn">Search</button>
					</div>
				</div>
			</div>
			<!-- Filter Search Button End -->
		</div>
		<!-- Filter Listing End -->

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

		<!-- Listing Start -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:if test="${empty listingList}">
				<div class="text-center mx-auto mt-5">
					<h4>No Listing Yet</h4>
					<img class="img-fluid" src="/assets/images/no-result.png" alt="No Listing Record" width="320">
				</div>
			</c:if>

			<c:if test="${not empty listingList}">
				<c:forEach items="${listingList}" var="listing">
					<div class="col">
						<div class="card h-100">
							<a href="/listing/${listing[0].listingId}">
								<img src="/upload/listing/${listing[0].image}" class="card-img-top position-relative" alt="${listing[0].regYear} ${listing[0].make} ${listing[0].model}" width="100%" height="auto">
							</a>
							
							<div class="card-body">
								<h5 class="card-title text-center">
									<a href="/listing/${listing[0].listingId}">${listing[0].regYear} ${listing[0].make} ${listing[0].model}</a>
								</h5>

								<i class="fas fa-user" title="Seller"></i> <a href="/profile/${listing[0].user.userId}">${listing[0].user.username}</a> <br>
								
								<fmt:formatNumber value="${listing[0].minPrice}" pattern="#,##0" var="formattedMinPrice" />
								<i class="fas fa-money-bill-wave" title="Minimum Price"></i> RM${formattedMinPrice} <br>

								<fmt:formatNumber value="${listing[0].mileage}" pattern="#,##0" var="formattedMileage" />
								<i class="fas fa-road" title="Mileage"></i> ${formattedMileage} km<br>

								<i class="fas fa-clock" title="Time Left"></i> <span class="badge text-bg-warning" id="countdown-${listing[0].listingId}"></span> <br>
							</div>
							
							<div class="card-footer">
								<div class="row">
									<div class="col-6 my-auto">
										<div class="price">
											<span>Highest Bid</span>
											<c:if test="${empty listing[0].bids}">
												<h4 class="text-danger">No Bid Placed</h4>
											</c:if>
											<c:if test="${not empty listing[0].bids}">
												<fmt:formatNumber value="${listing[1]}" pattern="#,##0" var="formattedBidPrice" />
												<h4>RM${formattedBidPrice} </h4>
											</c:if>
										</div>
									</div>
									<sec:authorize access="hasRole('USER')">
										<div class="col-6 my-auto text-end">
											<a href="/listing/${listing[0].listingId}" class="btn" id="bid-btn">Place Bid</a>
										</div>
									</sec:authorize>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<!-- Listing End -->
	</section>
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
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!-- Bootstrap Datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"
	integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Custom JS Script for Auction -->
<script src="/js/auction-script.js"></script>
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

	/* Update time left dynamically */
	// Get the start time and end time passed from the controller
	<c:forEach items="${listingList}" var="listing">
		let startTime${listing[0].listingId} = new Date('${listing[0].createdAt}');
		let endTime${listing[0].listingId} = new Date('${listing[0].endTime}');
		
		// Update the countdown every second
		setInterval(function() {
			let now = new Date().getTime();
			
			// Calculate the time remaining between now and the end time
			let timeRemaining = endTime${listing[0].listingId} - now;
			
			// If the end time has passed, display a message
			if (timeRemaining <= 0) {
				$('#countdown-${listing[0].listingId}').text('Expired');
			} else {
				// Calculate the days, hours, minutes, and seconds
				let days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
				let hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				let minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
				let seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

				// Build the countdown text
				let countdownText = '';
				if (days > 0) {
					countdownText += days + 'd ';
				}

				if (hours > 0 || countdownText !== '') {
					countdownText += hours + 'h ';
				}

				if (minutes > 0 || countdownText !== '') {
					countdownText += minutes + 'm ';
				}

				countdownText += seconds + 's';

				// Display the countdown
				$('#countdown-${listing[0].listingId}').text(countdownText);
			}
		}, 1000);
	</c:forEach>
</script>
</html>
