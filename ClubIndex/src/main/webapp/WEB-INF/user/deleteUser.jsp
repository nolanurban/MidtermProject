<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div class="container">
		<h2>Are you sure you want to delete this account? This is a final decision</h2>
		<form action="deleteUserConfirmation.do">
		<c:choose>
	<c:when test="${not empty user}">
		<input type="hidden" name="id" value="${user.id}"/>
	</c:when>
</c:choose>
				<input type="submit" value="Delete Account">
		
			</form>
		</div>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>