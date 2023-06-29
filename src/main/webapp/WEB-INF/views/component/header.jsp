<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- Header Styling -->
<link rel="stylesheet" type="text/css" href="/css/header-style.css">

<nav class="navbar navbar-expand-lg fixed-top" aria-label="Navbar">
	<div class="container-fluid">
		<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#top-nav"
		        aria-controls="top-nav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<span class="navbar-brand me-0 d-lg-none">
            <a href="/">
                <img src="/assets/images/company-logo-full.png" width="200" alt="logo">
            </a>
        </span>

		<div class="navbar-collapse d-lg-flex collapse" id="top-nav">
            <span class="navbar-brand col-lg-3 me-0 d-none d-lg-block">
                <a href="/">
                    <img src="/assets/images/company-logo-full.png" width="200" alt="logo">
                </a>
            </span>
            
            <div class="col-lg-6 d-lg-flex justify-content-lg-center">
	            <ul class="navbar-nav fw-semibold">
					<li class="nav-item">
						<a class="nav-link" href="/">Home</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/auction">Auction</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/about">About</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/contact">Contact</a>
					</li>
				</ul>
	
	            <sec:authorize access="isAuthenticated()">
		            <ul class="navbar-nav fw-semibold ms-lg-4 my-auto">
			            <li>
							<!-- Search Form Start -->
							<form:form class="input-group w-auto my-auto d-flex" id="search-form" action="/search" method="get">
								<input autocomplete="off" id="search-input" name="q" type="search" class="form-control rounded" 
									placeholder="Search Make or Model" title="Search Make or Model">
								<span class="input-group-text border-0 d-flex" id="search-icon">
									<label for="search">
										<i class="fas fa-search"></i>
									</label>
									<input class="d-none" type="submit" id="search">
								</span>
							</form:form>
							<!-- Search Form End -->
						</li>
		            </ul>
	            </sec:authorize>
            </div>
			
			<div class="d-lg-flex col-lg-3 justify-content-lg-end mt-0 mt-xs-5">
				<sec:authorize access="!isAuthenticated()">
					<a class="btn mx-1" id="signup-btn" href="/signup">Sign Up</a>
					<a class="btn" id="login-btn" href="/signin">Login</a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<sec:authorize access="hasAuthority('USER')">
						<div class="me-3 my-auto">
							<a href="/sell-car" class="btn" id="sell-btn">Sell Your Car</a>
						</div>
					</sec:authorize>
					<ul class="list-unstyled my-auto">
						<li class="nav-item dropdown my-2">
							<a class="nav-link dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								<img src="/assets/images/default-profile-pic.png" alt="User Profile Picture" class="rounded-circle" height="35">
							</a>
							<ul class="dropdown-menu dropdown-menu-end mt-3" aria-labelledby="navbarDropdownMenuLink">
								<li>
									<sec:authentication property="name" var="email" />
									<button class="dropdown-item" disabled>${email}</button>
								</li>
								<li>
									<a class="dropdown-item" href="/profile">Profile</a>
								</li>
								<sec:authorize access="hasAuthority('ADMIN')">
									<li>
										<a class="dropdown-item" href="/dashboard">Dashboard</a>
									</li>
								</sec:authorize>
								<sec:authorize access="hasAuthority('USER')">
									<li>
										<a class="dropdown-item" href="/my-listings">My Listings</a>
									</li>
								</sec:authorize>
								<li>
									<form:form id="logout-form" action="/logout" method="post">
										<input type="submit" name="Logout" value="Logout" class="dropdown-item link-danger"></input>
									</form:form>
								</li>
							</ul>
						</li>
					</ul>
				</sec:authorize>
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
