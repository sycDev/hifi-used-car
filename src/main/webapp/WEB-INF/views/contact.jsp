<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Contact Us</title>
	<link rel="icon" href="../assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="../css/contact-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section id="contact-sec">
		<div class="container">
			<h2 class="pt-5 pb-3 text-center">Contact Us</h2>
			<div class="row">
				<div class="col-md-6 col-sm-12 info-map">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3972.0066407723743!2d100.33918977615106!3d5.415956994563249!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac342acce72e1%3A0x9c29a8120eb9585d!2sSchool%20of%20Digital%20Technology%2C%20Wawasan%20Open%20University!5e0!3m2!1sen!2smy!4v1684727687432!5m2!1sen!2smy"
						width="100%" height="100%" style="border:0;" frameborder="0" allowfullscreen="" loading="lazy"
						referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
				<div class="col-md-6 col-sm-12">
					<div class="row">
						<div class="col-md-12">
							<div class="info">
								<div class="info-item">
									<div class="info-icon">
										<i class="fas fa-map-marked"></i>
									</div>
									<div class="info-text">
										<h2>Address</h2>
										<span>7, 9, 13, Gat Lebuh China,</span>
										<span>10300 George Town,</span>
										<span>Pulau Pinang, Malaysia.</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="info">
								<div class="info-item">
									<div class="info-icon">
										<i class="fas fa-envelope"></i>
									</div>
									<div class="info-text">
										<h2>E-mail</h2>
										<a href="mailto:info@hificars.com">info@hificars.com</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="info">
								<div class="info-item">
									<div class="info-icon">
										<i class="fas fa-phone"></i>
									</div>
									<div class="info-text">
										<h2>Contact Number</h2>
										<a href="tel:1-300-88-8968">1-300-88-8968</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="info">
								<div class="info-item">
									<div class="info-icon">
										<i class="fas fa-clock"></i>
									</div>
									<div class="info-text">
										<h2>Business Hours</h2>
										<span>Mon to Fri 9:00am - 6:00pm</span>
										<span>Sat & Sun 10.00am - 6.00pm</span>
										<span>Excluding Public Holidays</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
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