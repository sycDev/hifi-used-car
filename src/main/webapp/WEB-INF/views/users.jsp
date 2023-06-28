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
	<link rel="icon" href="../assets/images/company-logo-only.png">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<style>
		.form-check-input[type='checkbox']:checked {
			background-color: #f10d33;
			border-color: #f10d33;
		}
		
		.form-check-input[type=checkbox]:checked:focus {
			background-color: #f10d33;
		}
	</style>
</head>
<body>
	<main>
		<div class="container-fluid mt-5 pt-5">
			<!-- Header Include -->
			<%@ include file="component/header.jsp" %>
	
			<!-- Main Content Start -->
			<!-- User Data Listing Start -->
			<h3 class="text-center m-4">User Data</h3>
			<c:if test="${empty userList}">
				<div class="text-center mx-auto my-5">
					<h4 class="text-muted">No Registered User Yet</h4>
					<img class="img-fluid" src="../assets/images/no-result.png" alt="No User Record" width="320" height="auto">
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
									<td>${user.userId}</td>
									<td>${user.username}</td>
									<td>${user.email}</td>
									<td>
										<fmt:formatDate value="${user.joinedAt}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="p-0 text-center">
										<span data-bs-toggle="modal" data-bs-target="#edit-user-modal">
											<button type="button" class="btn btn-link btn-sm btn-rounded">
												<i class="fa fa-edit" style="color: #f10d33"></i>
											</button>
										</span>
									</td>
									<td class="p-0 text-center">
										<span data-bs-toggle="modal" data-bs-target="#delete-user-modal">
											<button type="button"
												class="btn btn-link btn-rounded btn-sm fw-bold">
												<i class="fa fa-trash" style="color: #f10d33"></i>
											</button>
										</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
			<!-- User Data Listing End -->
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