<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Register as Admin</title>
    <link rel="icon" href="/assets/images/company-logo-only.png">
    <!-- Form Styling -->
	<link rel="stylesheet" type="text/css" href="/css/form-style.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<style>
		/* For password requirements */
		.wrong .fa-check {
		    display: none;
		}
		
		.good .fa-times {
		    display: none;
		}
	</style>
</head>

<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
<section class="py-4 container">
		<div class="row mt-5 text-center">
			<div class="col-lg-9 mx-auto my-4">
				<h2 class="fw-light">Admin Registration</h2>
			</div>
		</div>
		<div class="container w-75">
			<form:form modelAttribute="user" id="register-admin-form" action="/dashboard/admin/register" method="post" class="mx-lg-5">
				
				<!--  Display Error Message Start -->
				<c:if test="${errMsg != null}">
					<div class="input-group">
						<div class="alert alert-danger w-100">
							<div class="d-flex align-items-center">
								<div class="me-3">
									<i class="fa fa-circle-exclamation align-middle alert-icon"></i>
								</div>
								<div class="d-flex justify-content-between w-100">${errMsg}</div>
							</div>
						</div>
					</div>
				</c:if>
				<!--  Display Error Message End -->

				<div class="mb-3">
					<label class="form-label" for="username">Username: *</label>
					<input type="text" class="form-control" name="username" id="username" required>
					<div class="error">
						<p id="error-username"></p>
					</div>
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="email">Email: *</label>
					<input type="text" class="form-control" name="email" id="email" required>
					<div class="error">
						<p id="error-email"></p>
					</div>
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="password">Password: *</label>
					<input type="password" class="form-control" name="password" id="password" required>
					<div class="error">
						<p id="error-password"></p>
					</div>
				</div>
				
				<div class="d-none text-start" id="password-alert">
					<ul class="list-unstyled mb-0">
						<li class="requirements length">
							<i class="fas fa-check text-success me-2"></i>
							<i class="fas fa-times text-danger me-3"></i>
							At least 8 characters
						</li>
						<li class="requirements lowercase">
							<i class="fas fa-check text-success me-2"></i>
							<i class="fas fa-times text-danger me-3"></i>
							At least 1 lowercase letter
						</li>
						<li class="requirements uppercase">
							<i class="fas fa-check text-success me-2"></i>
							<i class="fas fa-times text-danger me-3"></i>
							At least 1 uppercase letter
						</li>
						<li class="requirements num">
							<i class="fas fa-check text-success me-2"></i>
							<i class="fas fa-times text-danger me-3"></i>
							At least 1 number
						</li>
						<li class="requirements special-char">
							<i class="fas fa-check text-success me-2"></i>
							<i class="fas fa-times text-danger me-3"></i>
							At least 1 special character
						</li>
					</ul>
				</div>

				<div class="py-3 text-center">
					<a href="/dashboard/users" class="btn btn-light" id="dismiss-btn">Cancel</a>
					<button type="submit" class="btn" id="submit-btn">Register</button>
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
<!-- Custom JS Script for Auth Form Validation -->
<script src="/js/authform-script.js"></script>
<!-- Custom JS Script for Password Validation -->
<script src="/js/pwdValid-script.js"></script>
<script>
	$(document).ready(function() {
		validateForm('register-admin-form');
	});
</script>
</html>