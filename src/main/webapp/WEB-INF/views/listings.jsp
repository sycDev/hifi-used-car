<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Manage Listings</title>
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
		
		<!-- Listings Data Listing Start -->
		<h3 class="text-center m-4">Listing Data</h3>

		<c:if test="${empty listingList}">
			<div class="text-center mx-auto my-5">
				<h4 class="text-muted">No Listing Yet</h4>
				<img class="img-fluid" src="/assets/images/no-result.png" alt="No Listing Record" width="320" height="auto">
			</div>
		</c:if>
		
		<c:if test="${not empty listingList}">
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
							<th scope="col" colspan="2" class="text-center">Status</th>				
							<th scope="col">Listing ID</th>
							<th scope="col">Listing Name</th>
							<th scope="col">Minimum Price</th>
							<th scope="col">Time Left</th>
							<th scope="col">Highest Bid</th>
							<th scope="col">Seller ID</th>
							<th scope="col">Seller</th>
							<th scope="col">Transact</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listingList}" var="listing" varStatus="loop">
							<tr>
								<th scope="row">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" />
									</div>
								</th>
								<td>${loop.index + 1}</td>
								<td class="pb-2">
									<c:if test="${listing[0].status == 'Active'}">
										<span class="badge text-bg-success">${listing[0].status}</span>
									</c:if>
									
									<c:if test="${listing[0].status == 'Sold'}">
										<span class="badge text-bg-warning">${listing[0].status}</span>
									</c:if>
									
									<c:if test="${listing[0].status == 'Inactive'}">
										<span class="badge text-bg-danger">${listing[0].status}</span>
									</c:if>
								</td>
								<td class="pt-3">
									<div class="form-check form-switch">
										<input class="form-check-input status-toggle" type="checkbox" role="switch" 
											id="statusToggle-${listing[0].listingId}"
											data-id="${listing[0].listingId}"
											
											<c:if test="${listing[0].status == 'Active'}">
									            checked
									        </c:if>
									        <c:if test="${listing[0].status == 'Sold'}">
									            disabled
									        </c:if>
										>
										<label class="form-check-label" for="statusToggle--${listing[0].listingId}"></label>
									</div>
								</td>
								<td>
									<a href="/listing/${listing[0].listingId}">${listing[0].listingId}</a>
								</td>
								<td>${listing[0].regYear} ${listing[0].make} ${listing[0].model}</td>
								<td>
									<fmt:formatNumber value="${listing[0].minPrice}" pattern="#,##0" var="formattedMinPrice" />
									RM${formattedMinPrice} <br>
								</td>
								<td>
									<span class="badge text-bg-warning" id="countdown-${listing[0].listingId}"></span>	
								</td>
								<td>
									<c:if test="${empty listing[0].bids}">
										<span class="text-danger">No Bid Placed</span>
									</c:if>
									<c:if test="${not empty listing[0].bids}">
										<fmt:formatNumber value="${listing[1]}" pattern="#,##0" var="formattedBidPrice" />
										<span>RM${formattedBidPrice} </span>
									</c:if>
								</td>
								<td>
									<a href="/dashboard/edit-user/${listing[0].user.userId}">${listing[0].user.userId}</a>
								</td>
								<td>${listing[0].user.username}</td>
								<td class="p-0 text-center">
									<a class="btn btn-link btn-rounded btn-sm fw-bold"
										href="/dashboard/edit-listing/${listing[0].listingId}">

										<i class="fas fa-dollar-sign" title="Transact"></i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		<!-- Listings Data Listing End -->
		
		<!-- Confirmation Modal for Changing Status Start -->
		<div class="modal fade" id="statusConfirmationModal" tabindex="-1" aria-labelledby="statusConfirmationModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		        	<form:form action="/dashboard/listing/statusUpdate" method="post">
			            <div class="modal-header">
			                <h5 class="modal-title" id="statusConfirmationModalLabel">Confirmation</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <span id="statusConfirmationText"></span>
			                <input type="hidden" name="listingId" id="selectedListingIdUpdateStatus">
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
			                <button type="submit" class="btn btn-danger">Yes, I'm Sure</button>
			            </div>
					</form:form>
		        </div>
		    </div>
		</div>
		<!-- Confirmation Modal for Changing Status End -->
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
		 
		// Handle the modal dismissal
		$("#statusConfirmationModal").on("hidden.bs.modal", function() {
			// Restore the previous status
			location.reload();
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

	$('#select-all').click(function() {
		$('tbody input[type="checkbox"]').prop('checked',
				$(this).prop('checked'));
	});

	$('tbody input[type="checkbox"]').click(function() {
		if (!$(this).prop('checked')) {
			$('#select-all').prop('checked', false);
		}
	});
	
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