<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Club Index Login Page</title>
<jsp:include page="../includes/header.jsp" />
</head>
<body>
	<jsp:include page="../includes/nav.jsp" />
	<div class="container">
		<form action="login.do" method="POST">
			<input type="text" name="username" required><br> <input
				type="password" name="password" required><br> <input
				type="submit" value="Log In">
		</form>
		<a href="userCreation.do" class="btn btn-dark">Create Account Now</a>
	</div>
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>

