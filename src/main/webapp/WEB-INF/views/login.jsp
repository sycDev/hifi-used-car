<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hi-Fi Cars | Login</title>
    <link rel="icon" href="/assets/images/company-logo-only.png">
 	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/auth-style.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <style>
        .overlay-container {
            background-image: url(/assets/images/login.jpg);
        }
    </style>
</head>

<body>
    <div class="container" id="auth-container">
        <div class="form-container sign-in-container">
            <form:form action="/login" method="post" id="login-form" novalidate="true">
				<a href="/">
				    <img src="/assets/images/company-logo-only.png" width="50" height="auto" alt="logo">
				</a>
				<h1>Welcome Back!</h1>
				<p>
				    Not yet register? <a href="/signup">Sign Up</a>
				</p>
				
				<!--  Display Success Message Start -->
				<c:if test="${successMsg != null}">
					<div class="input-group">
						<div class="alert alert-success w-100">
							<div class="d-flex align-items-center">
								<div class="me-3">
									<i class="fa fa-circle-check align-middle alert-icon"></i>
								</div>
								<div class="d-flex justify-content-between w-100">${successMsg}</div>
							</div>
						</div>
					</div>
				</c:if>
				<!--  Display Success Message End -->
				
				<!--  Display the invalid login message Start -->
				<c:if test="${param.error != null}">
					<div class="input-group">
						<div class="alert alert-danger w-100">
							<div class="d-flex align-items-center">
								<div class="me-3">
									<i class="fa fa-circle-exclamation align-middle alert-icon"></i>
								</div>
								<div class="d-flex justify-content-between w-100">
									Invalid email or password
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<!--  Display the invalid login message End -->
				
				<!--  Display the session expired message Start -->
				<c:if test="${param.expired != null}">
					<div class="input-group">
						<div class="alert alert-warning w-100">
							<div class="d-flex align-items-center">
								<div class="me-3">
									<i class="fa fa-triangle-exclamation align-middle alert-icon"></i>
								</div>
								<div class="d-flex justify-content-between w-100">
									Expired session, please login again
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<!--  Display the session expired message End -->
				
				<!--  Display the success logout message Start -->
				<c:if test="${param.logout != null}">
				<div class="input-group">
					<div class="alert alert-success w-100">
						<div class="d-flex align-items-center">
							<div class="me-3">
								<i class="fa fa-circle-check align-middle alert-icon"></i>
							</div>
							<div class="d-flex justify-content-between w-100">
								You are successfully logged out!
							</div>
						</div>
					</div>
				</div>
				</c:if>
				<!--  Display the success logout message End -->
				
				<input type="email" name="email" id="email" placeholder="Email" required />
				<div class="error">
					<small id="error-email"></small>
				</div>
				
				<input type="password" name="password" id="password" placeholder="Password" required />
				<div class="error">
					<small id="error-password"></small>
				</div>
				
				<button type="submit">Login</button>
            </form:form>
        </div>
        <div class="overlay-container">
        </div>
    </div>
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
<script>
	$(document).ready(function() {
		$('#password').on('input blur', function(e) {
			if (!$(this).val()) {
				showError('password', 'Please fill out this field');
			} else {
				hideError('password');
			}
		});

		validateForm('login-form');
	});
</script>
</html>