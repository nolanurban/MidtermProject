<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="includes/nav.jsp"/>
		<div class="container error-page">
			<h1>Uh-Oh! Something went wrong!</h1>
			<a href="home.do">Return to home</a>
		</div>
		<jsp:include page="includes/footer.jsp"/>
	</body>
</html>