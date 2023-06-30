<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Listing Details</title>
	<link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/details-style.css">
	<!-- Form Styling -->
	<link rel="stylesheet" type="text/css" href="/css/form-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
	      integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<!-- LightSlider CSS -->
	<link rel="stylesheet" type="text/css" href="/css/lightslider.css">
	<style>
		
	</style>
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section class="container py-4 mt-5" id="details">
		<h1 class="display-6 text-center mt-3 mb-4">${listing.regYear} ${listing.make} ${listing.model}</h1>

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

		<!-- Listing Details Start -->
		<div class="row">
			<div class="col-lg-6">
				<div class="gallery">
				    <ul id="lightSlider">
				    	<li data-thumb="/upload/listing/${listing.image}">
				            <img class="rounded" src="/upload/listing/${listing.image}" />
				        </li>
				        <li data-thumb="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png">
				            <img class="rounded" src="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png" />
				        </li>
				        <li data-thumb="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png">
				            <img class="rounded" src="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png" />
				        </li>
				        <li data-thumb="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png">
				            <img class="rounded" src="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png" />
				        </li>
				        <li data-thumb="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png">
				            <img class="rounded" src="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png" />
				        </li>
				        <li data-thumb="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png">
				            <img class="rounded" src="https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png" />
				        </li>
				    </ul>
				</div>
				<div>
					<fmt:parseDate value="${listing.createdAt}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedListedTime" />
					<fmt:formatDate value="${parsedListedTime}" pattern="d MMMM yyyy h:mm a" var="formattedListedTime" />
					Listed Time: ${formattedListedTime}
				</div>
				<div id="seller">
					<i class="fas fa-user" title="Seller"></i> <a href="/profile/${listing.user.userId}">${listing.user.username}</a> <br>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="row">
					<div class="col-6">
						<div class="card">
							<div class="card-body">
								<fmt:formatNumber value="${listing.minPrice}" pattern="#,##0" var="formattedMinPrice" />
								<i class="fas fa-money-bill-wave fs-4" title="Minimum Price"></i> 
								<small>&nbsp;Starting Price</small> <br>
								<span class="fs-4 fw-semibold">RM${formattedMinPrice}</span>
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="card">
							<div class="card-body">
								<fmt:formatNumber value="${listing.mileage}" pattern="#,##0" var="formattedMileage" />
								<i class="fas fa-road fs-4" title="Mileage"></i>
								<small>&nbsp;Mileage</small> <br>
								<span class="fs-4 fw-semibold">${formattedMileage} km</span>
							</div>
						</div>
					</div>
				</div>

				<c:if test="${not empty listing.description}">
					<div class="my-2" id="desc">
						${listing.description}
					</div>	
				</c:if>
				
				<div class="mb-2">
					<c:if test="${listing.status == 'Active'}">
						<span class="badge text-bg-success">${listing.status}</span>
					</c:if>
					
					<c:if test="${listing.status == 'Sold'}">
						<span class="badge text-bg-warning">${listing.status}</span>
					</c:if>
					
					<c:if test="${listing.status == 'Inactive'}">
						<span class="badge text-bg-danger">${listing.status}</span>
					</c:if>
				</div>

				<div class="card">
					<div class="card-body">
						<span class="fw-semilight">Highest Bid</span>
						<h5 class="card-title">
							<c:if test="${not empty highestBid}">
								<fmt:formatNumber value="${highestBid}" pattern="#,##0" var="formattedBidPrice" />
								<h4 class="display-5">RM${formattedBidPrice} </h4>
								<span class="fw-bold">Total Bids:</span> ${listing.bids.size()}
							</c:if>
							<c:if test="${empty listing.bids}">
								<h4 class="text-danger">No Bid Placed</h4>
							</c:if>
						</h5>
						<p class="card-text">
							<i class="fas fa-clock" title="Time Left"></i> 
							<span class="badge text-bg-warning" id="countdown-${listing.listingId}"></span> 
							<br>
							<fmt:parseDate value="${listing.endTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedEndTime" />
							<fmt:formatDate value="${parsedEndTime}" pattern="d MMMM yyyy h:mm a" var="formattedEndTime" />
							End Time: ${formattedEndTime}
						</p>
					</div>
					<!-- Only USER role able to place bid -->
					<sec:authorize access="hasAuthority('USER')">
						<c:set var="currentTime" value="<%= new java.util.Date() %>" />
						<!-- 	
							Show the bid button if 
							not yet expired
							not created by the current logged-in user 
							status must be active
						-->
						<c:if test="${listing.status == 'Active' and listing.endTime ge currentTime and listing.user.userId != currentUserId}">
							<a href="#" class="btn" id="bid-btn">
								Place Bid
							</a>
						</c:if>
					</sec:authorize>
				</div>
			</div>
		</div>
		<!-- Listing Details End -->
		
		<!-- Confirmation Modal for Placing Bid Start -->
		<div class="modal fade" id="statusConfirmationModal" tabindex="-1" aria-labelledby="statusConfirmationModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		        	<form:form action="/listing/updateStatus" method="post">
			            <div class="modal-header">
			                <h5 class="modal-title" id="statusConfirmationModalLabel">Confirmation</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <span id="statusConfirmationText"></span>
			                <input type="number" name="bidPrice" id="bidPrice">
			                <input type="hidden" name="listingId" id="selectedListingIdPlaceBid">
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
			                <button type="submit" class="btn btn-danger">Yes, I'm Sure</button>
			            </div>
					</form:form>
		        </div>
		    </div>
		</div>
		<!-- Confirmation Modal for Placing Bid End -->
	</section>
</main>

<!-- Footer -->
<%@ include file="component/footer.jsp" %>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/e19fcdf015.js" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous">
</script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!-- LightSlider JS -->
<script src="/js/lightslider.js"></script>
<script>
    $(document).ready(function() {
		// Enable image slider
		$('#lightSlider').lightSlider({
		    gallery: true,
		    item: 1,
		    loop: true,
		    slideMargin: 0,
		    thumbItem: 6,
		    adaptiveHeight: true
		});  
    	
    	// Enable tooltips
    	const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
    	
        // Showing the success message from controller
        <c:if test="${not empty successMsg}">
            showToast("${successMsg}", true);
        </c:if>
        
     	// Showing the error message from controller
        <c:if test="${not empty errorMsg}">
            showToast("${errorMsg}", false);
        </c:if>
        
     	// To get the selected lising to update status
    	$('.status-toggle').click(function() {
    		let listingId = $(this).data('id');
    		$('#selectedListingIdUpdateStatus').val(listingId);
    	});

		// Change status of listing
		$(".status-toggle").on("change", function() {
			let status = $(this).is(":checked") ? "Active" : "Inactive";
		
			let confirmationText = "Are you sure you want to ";
		
			if (status === "Active") {
				confirmationText += "activate this listing?";
			} else {
				confirmationText += "deactivate this listing?";
			}
			$("#statusConfirmationText").text(confirmationText);
		
			// Show the confirmation modal
			$("#statusConfirmationModal").modal("show");
		});
		
		// Handle the form submission confirmation
		$("#statusConfirmSubmit").on("click", function() {
			// Submit the form
			$("#update-status-form").submit();
		});
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
	// Get the end time passed from the controller
	let endTime${listing.listingId} = new Date('${listing.endTime}');
	
	// Update the countdown every second
	setInterval(function() {
		let now = new Date().getTime();
		
		// Calculate the time remaining between now and the end time
		let timeRemaining = endTime${listing.listingId} - now;
		
		// If the end time has passed, display a message
		if (timeRemaining <= 0) {
			$('#countdown-${listing.listingId}').text('Expired');
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
			$('#countdown-${listing.listingId}').text(countdownText);
		}
	}, 1000);
</script>
</body>
</html>
