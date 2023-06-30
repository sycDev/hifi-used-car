<!DOCTYPE html>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Sell Car</title>
	<link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Form Styling -->
	<link rel="stylesheet" type="text/css" href="/css/form-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section class="py-4 container">
		<div class="row mt-5 text-center">
			<div class="col-lg-9 mx-auto my-4">
				<h2 class="fw-light">Sell Car</h2>
			</div>
		</div>
		<div class="container w-75">
			<form:form modelAttribute="listing" id="add-new-listing-form" action="/listing/add" method="post" class="mx-lg-5" enctype="multipart/form-data" novalidate="true">

				<c:if test="${not empty errMsg}">
					<div class="alert alert-danger" role="alert">
						${errMsg}
					</div>
				</c:if>

				<div class="mb-3">
					<label class="form-label" for="make">Make: *</label>
					<input type="text" class="form-control" name="make" id="make" placeholder="Max 30 characters" required>
					<div class="error">
						<p id="error-make"></p>
					</div>
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="model">Model: *</label>
					<input type="text" class="form-control" name="model" id="model" placeholder="Max 50 characters" required>
					<div class="error">
						<p id="error-model"></p>
					</div>
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="regYear">Registration Year: *</label>
					<input type="number" class="form-control" name="regYear" id="regYear" placeholder="No future year" required>
					<div class="error">
						<p id="error-regYear"></p>
					</div>
				</div>
				
				<label class="form-label" for="mileage">Mileage: *</label>
				<div class="input-group">
					<input type="number" class="form-control" name="mileage" id="mileage" placeholder="Current mileage" required>
					<span class="input-group-text">km</span>
				</div>
				<div class="error">
					<p id="error-mileage"></p>
				</div>
				
				<div class="mb-3">
					<label for="description" class="col-form-label">Description</label>
					<textarea class="form-control" id="description" name="description" placeholder="Tell us more about your car..." rows="4"></textarea>
				</div>
				
				<label class="form-label" for="minPrice">Minimum Price: *</label>
				<div class="input-group">
					<span class="input-group-text">RM</span>
					<input type="number" class="form-control" name="minPrice" id="minPrice" placeholder="Set a starting price" required>
				</div>
				<div class="error ms-5">
					<p id="error-minPrice"></p>
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="endTime">End Time: *</label>
					<input type="datetime-local" class="form-control" id="endTime" name="endTime" required>
					<small>Expired time for auction</small>
					<div class="error">
						<p id="error-endTime"></p>
					</div>
				</div>

				<div>
					<label class="form-label" for="imageFile">Pictures: </label>
					<input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*" required>
					<small>Only Allowed: JPEG, PNG (Max 2MB)</small>
					<div class="error">
						<p id="error-imageFile"></p>
					</div>
				</div>

				<div id="img-preview-div" class="mb-3 d-none">
					Preview:
					<img class="img-thumbnail" id="imgPreview" alt="Store Image Preview" width="200" src="">
					<a class="btn btn-outline-secondary" id="clear-img-btn">Clear</a>
				</div>

				<input type="hidden" name="status" value="Active">

				<div class="py-3 text-center">
					<a href="/auction" class="btn btn-light">Cancel</a>
					<button type="submit" class="btn" id="submit-btn">Submit</button>
				</div>
			</form:form>
		</div>
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
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Custom JS Script for Form Validation -->
<script src="/js/form-script.js"></script>
<script>
    $(document).ready(function() {
        // Validate length of storeName onBlur
	    checkLengthOnBlur('#make', 1, 30);
	    checkLengthOnBlur('#model', 1, 50);

	    // Only enable future date for datepicker
		let now = new Date();
		let minDateTime = now.toISOString().slice(0, 16);
		$('#endTime').on('focus', function() {
			$(this).attr('min', minDateTime);
		});
	    
        // Validate Add New Listing Form before submit
        $('#add-new-listing-form').submit(function(e) {
            e.preventDefault();
            let fields = [
                { selector: '#make', minLength: 1, maxLength: 30 }, 
                { selector: '#model', minLength: 1, maxLength: 50 }
            ];

            if (validateForm('#add-new-listing-form', fields)) {
                this.submit();
            } else {
                e.preventDefault();
            }
        });
    });
</script>
</html>