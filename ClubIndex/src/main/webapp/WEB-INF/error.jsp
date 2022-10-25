<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<div class="container error-page">
			<h1>Uh-Oh! Something went wrong!</h1>
			<a href="home.do">Return to home</a>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>