<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hi-Fi Cars | Edit User</title>
	<link rel="icon" href="/assets/images/company-logo-only.png">
	<!-- Form Styling -->
	<link rel="stylesheet" type="text/css" href="/css/form-style.css">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
<!-- Header -->
<%@ include file="component/header.jsp" %>

<!-- Main Section -->
<main>
	<section class="py-4 container">
		<div class="row mt-5 text-center">
			<div class="col-lg-9 mx-auto my-4">
				<h2 class="fw-light">Edit User</h2>
			</div>
		</div>
		<div class="container w-75">
			<form:form modelAttribute="user" id="edit-user-form" action="/dashboard/user/update" method="post" class="mx-lg-5">
				
				<c:if test="${not empty errMsg}">
					<div class="alert alert-danger" role="alert">
						${errMsg}
					</div>
				</c:if>

				<input type="hidden" name="userId" value="${user.userId}">

				<div class="mb-3">
					<label class="form-label" for="username">Username: *</label>
					<input type="text" class="form-control" name="username" id="username" value="${user.username}" required>
					<div class="error">
						<p id="error-username"></p>
					</div>
				</div>

				<label class="form-label" for="email">Email:</label>
				<input type="text" class="form-control" name="email" id="email" value="${user.email}" disabled>

				<label class="col-form-label">Roles Assigned *</label><br>
				<c:forEach items="${roleList}" var="role">
				    <c:set var="isChecked" value="${user.roles.contains(role)}" />
				    <input type="checkbox" class="btn-check" name="roles" id="btn-check-outlined-${role.roleId}" value="${role.roleId}" autocomplete="off" ${isChecked ? 'checked' : ''}>
				    <label class="btn btn-outline-secondary" for="btn-check-outlined-${role.roleId}">${role.roleName}</label>
				</c:forEach>

			    <div class="error">
					<p id="error-roles"></p>
				</div>

				<div class="py-3 text-center">
					<a href="/dashboard/users" class="btn btn-light" id="dismiss-btn">Cancel</a>
					<button type="submit" class="btn" id="submit-btn">Save Changes</button>
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
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Custom JS Script for Form Validation -->
<script src="/js/form-script.js"></script>
<script>
    $(document).ready(function() {
        // Validate length requirements onBlur
        checkLengthOnBlur('#username', 1, 30);

        // Validate Add New User Form before submit
        $('#edit-user-form').submit(function(e) {
            e.preventDefault();
            let fields = [
                { selector: '#username', minLength: 1, maxLength: 30 }
            ];
            
            let checkboxes = $('input[type="checkbox"][name="roles"]');
            let checkedCount = checkboxes.filter(':checked').length;

            if (checkedCount != 0 && validateForm('#edit-user-form', fields)) {
                this.submit();
            } else {
            	$('#error-roles').text('Please assign at least one role');
                e.preventDefault();
            }
            
         	// Check if at least one checkbox is checked on page load
            checkIfAnyCheckboxChecked();

            // Attach event handler to checkboxes
            checkboxes.on('change', function() {
				checkIfAnyCheckboxChecked();
            });

            // Check if at least one checkbox is checked
            function checkIfAnyCheckboxChecked() {
				var checkedCount = checkboxes.filter(':checked').length;
				
				if (checkedCount > 0) {
					$('#error-roles').text('');
				} else {
					$('#error-roles').text('Please assign at least one role');
				}
            }
        });
    });
</script>
</html>
