<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Sign Up</title>
    <link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/auth-style.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <style>
        .overlay-container {
            background-image: url(/assets/images/signup.jpg);
        }
    </style>
</head>

<body>
    <div class="container" id="auth-container">
        <div class="form-container sign-up-container">
            <form:form modelAttribute="user" action="/register" method="post" id="register-form">
				<a href="/">
				    <img src="/assets/images/company-logo-only.png" width="50" alt="logo">
				</a>
				<h1>Sign Up</h1>
				<p>
				    Already a member? <a href="/signin">Login</a>
				</p>
				
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
				
				<input type="text" name="username" id="username" placeholder="Username" required />
				<div class="error">
					<small id="error-username"></small>
				</div>
				
				<input type="email" name="email" id="email" placeholder="Email" required />
				<div class="error">
					<small id="error-email"></small>
				</div>
				
				<input type="password" name="password" id="password" placeholder="Password" required />
				<div class="error">
					<small id="error-password"></small>
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

				<button type="submit">Sign Up</button>
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
<!-- Custom JS Script for Password Validation -->
<script src="/js/pwdValid-script.js"></script>
<script>
	$(document).ready(function() {
		validateForm('register-form');
	});
</script>
</html>