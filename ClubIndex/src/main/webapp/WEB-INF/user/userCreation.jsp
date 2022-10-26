<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div class="container">
			<h1>Create your account</h1>
			
			<form action="userCreation.do" method="POST">
				<jsp:include page="userProfileForm.jsp"/>
			</form>
		</div>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>