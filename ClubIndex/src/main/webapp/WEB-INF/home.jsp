<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
	<title>Club Index: A Way To Track Down a Book Club</title>
	
		<jsp:include page="header.jsp"/>
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<div class="container">
		<h2>Book Clubs!</h2>
			${SMOKETEST}


		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>