<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Manage Users</title>
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
		
		<!-- User Data Listing Start -->
		<h3 class="text-center m-4">User Data</h3>
		
		<div class="text-end">
			<a class="btn my-3 me-5" id="add-btn" href="/dashboard/register-admin">
				Register as Admin
			</a>
		</div>
		
		<c:if test="${empty userList}">
			<div class="text-center mx-auto my-5">
				<h4 class="text-muted">No Registered User Yet</h4>
				<img class="img-fluid" src="/assets/images/no-result.png" alt="No User Record" width="320" height="auto">
			</div>
		</c:if>
		
		<c:if test="${not empty userList}">
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
							<th scope="col">Roles</th>
							<th scope="col">User ID</th>
							<th scope="col">Username</th>
							<th scope="col">Email</th>
							<th scope="col">Joined At</th>
							<th scope="col" colspan="2" class="text-center">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList}" var="user" varStatus="loop">
							<tr>
								<th scope="row">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" />
									</div>
								</th>
								<td>${loop.index + 1}</td>
								<td>
									<c:forEach items="${user.roles}" var="role">
										<c:if test="${role.roleName == 'ADMIN'}">
											<span class="badge text-bg-dark">${role.roleName}</span>
										</c:if>
										<c:if test="${role.roleName == 'USER'}">
											<span class="badge text-bg-secondary">${role.roleName}</span>
										</c:if>
									</c:forEach>
								</td>
								<td>${user.userId}</td>
								<td>${user.username}</td>
								<td>${user.email}</td>
								<td>
									<fmt:formatDate value="${user.createdAt}" pattern="dd MMMM yyyy"/>
								</td>
								<td class="p-0 text-center">
									<a class="btn btn-link btn-rounded btn-sm fw-bold"
										href="/dashboard/edit-user/${user.userId}">

										<i class="fas fa-pen-to-square"></i>
									</a>
								</td>
								<td class="p-0 text-center">
									<a class="btn btn-link btn-rounded btn-sm fw-bold delete-user-btn" 
										data-id="${user.userId}" 
										data-bs-toggle="modal" 
										data-bs-target="#delete-user-modal">
										
										<i class="fas fa-circle-xmark"></i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		<!-- User Data Listing End -->
		
		<!-- Delete User Confirmation Modal Start -->
		<div class="modal fade" id="delete-user-modal" tabindex="-1"
			aria-labelledby="delete-user-modal-label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form:form action="/dashboard/user/delete" method="post">
						<div class="modal-header">
							<h5 class="modal-title" id="delete-user-modal-label">Delete User</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							Are you sure you want to delete this user?
							<input type="hidden" name="userId" id="selectedUserIdDelete">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal"
								style="color: #818181; background-color: transparent;">Cancel</button>
							<button type="submit" class="btn btn-danger">Delete</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
		<!-- Delete User Confirmation Modal End -->
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
	
	// To get the selected user to delete
	$(".delete-user-btn").click(function() {
		let userId = $(this).data('id');
		$('#selectedUserIdDelete').val(userId);
	});
</script>
</html>