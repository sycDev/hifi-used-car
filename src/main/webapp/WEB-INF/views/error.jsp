<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${errorName}</title>
	<link rel="icon" href="../assets/images/company-logo-only.png">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>

<div class="d-flex align-items-center justify-content-center vh-100">
	<div class="text-center">
		<c:if test="${not empty errorImg}">
			<img class="img-fluid" src="../assets/images/${errorImg}" alt="${errorName}" width="360px">
		</c:if>
		<p class="fs-3 fw-bold">${errorMsg}</p>
		<p class="lead">${errorDesc}</p>
		<a href="/" class="btn px-5" style="background-color: #f10d33; color: #fff;">HOME</a>
	</div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
</body>
</html>