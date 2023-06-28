<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Admin Dashboard</title>
	<link rel="icon" href="../assets/images/company-logo-only.png">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" type="text/css" href="../css/dashboard-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
	<!-- Header Include -->
	<%@ include file="component/header.jsp" %>
		
	<main id="dashboard">
		<div class="container-fluid mt-5 py-5">
			<h3 class="text-center m-4">Admin Dashboard</h3>
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<div class="card mb-3">
							<a class="text-decoration-none" href="/dashboard/users">
								<div class="card-body">
									<i class="fas fa-user fa-3x"></i>
									<h5 class="card-title mt-3">Users</h5>
									<p class="card-text">
										Total of Users
									</p>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card mb-3">
							<a class="text-decoration-none" href="/dashboard/listings">
								<div class="card-body">
									<i class="fas fa-car fa-3x"></i>
									<h5 class="card-title mt-3">Listings</h5>
									<p class="card-text">
										Total of Listings
									</p>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card mb-3">
							<a class="text-decoration-none" href="/dashboard/bids">
								<div class="card-body">
									<i class="fas fa-gavel fa-3x"></i>
									<h5 class="card-title mt-3">Bids</h5>
									<p class="card-text">
										Total of Bids
									</p>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
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