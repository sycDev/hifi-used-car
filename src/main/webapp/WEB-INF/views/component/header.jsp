<!-- Header Styling -->
<link rel="stylesheet" type="text/css" href="css/header-style.css">

<nav class="navbar navbar-expand-lg fixed-top" aria-label="Navbar">
	<div class="container-fluid">
		<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#top-nav"
		        aria-controls="top-nav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<span class="navbar-brand col-lg-3 me-0 d-lg-none">
            <a href="/">
                <img src="assets/images/company-logo-full.png" width="200" alt="logo">
            </a>
        </span>

		<div class="navbar-collapse d-lg-flex collapse" id="top-nav">
            <span class="navbar-brand col-lg-3 me-0 d-none d-lg-block">
                <a href="/">
                    <img src="assets/images/company-logo-full.png" width="200" alt="logo">
                </a>
            </span>
			<ul class="navbar-nav col-lg-6 justify-content-lg-center fw-semibold">
				<li class="nav-item">
					<a class="nav-link" href="/">Home</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/about">About</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/contact">Contact</a>
				</li>
			</ul>
			<div class="d-lg-flex col-lg-3 justify-content-lg-end">
				<a class="btn mx-1" id="signup-btn" href="/signup">Sign Up</a>
				<a class="btn" id="login-btn" href="/signin">Login</a>
			</div>
		</div>
	</div>
</nav>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>

<script>
    $(document).ready(function() {
        // Get current path and find target link
        let currentUrl = window.location.pathname;
        // Add active class to target link
        $('#top-nav .nav-link[href="' + currentUrl + '"]').addClass('active');
    });
</script>
