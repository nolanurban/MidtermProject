<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<div class="container">
		<h2>Are you sure you want to delete this account? This is a final decision</h2>
		<form action="deleteUser.do" method="POST">
				<a href="deleteUser.do" class="btn">Delete Account</a>
			</form>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>