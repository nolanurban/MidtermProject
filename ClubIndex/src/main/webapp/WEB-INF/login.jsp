<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Club Index Login Page</title>
<jsp:include page="header.jsp" />
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<form action="login.do" method="POST">
			<input type="text" name="username" value="username"><br>
			<input type="password" name="password" value="password"><br>
			<input type="submit" value="Log In">
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>

