<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Home</title>
	<link rel="icon" href="assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="css/index-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section class="d-none d-lg-block welcome-banner banner-desktop">
		<div class="container">
			<div class="m-auto" style="color: #eee;">
				<h1 class="fw-semibold align-left display-5">Your Ultimate Hub
					<br>for Used Cars
				</h1>
				<p class="lead">
					Dive into the exhilarating world of used car auctions, 
					<br>where you can bid, buy, or sell with confidence 
					<br>on our platform tailored for car enthusiasts like you.
				</p>
				<div class="align-left">
					<a class="btn btn-md p-3 banner-btn" id="banner-dt-btn" href="/signup">Get started today!</a>
				</div>
			</div>
		</div>
	</section>
	<section class="d-lg-none welcome-banner banner-mobile">
		<div class="container text-center mask">
			<h1 class="display-5 fw-semibold">Your Ultimate Hub
				<br>for Used Cars
			</h1>
			<p class="lead">
				Dive into the exhilarating world of used car auctions,<br>
				where you can bid, buy, or sell with confidence <br>
				on our platform tailored for car enthusiasts like you.
			</p>
			<div class="align-left">
				<a class="btn btn-md p-3 banner-btn" href="/signup">Get started today!</a>
			</div>
		</div>
	</section>
</main>

<!-- Footer -->
<%@ include file="component/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" 
	crossorigin="anonymous"></script>
</body>
</html>