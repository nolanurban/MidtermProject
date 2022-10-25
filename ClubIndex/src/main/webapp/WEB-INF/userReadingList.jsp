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
		<h2>Search For Your Favorite Reading Lists</h2>
			<form action="userReadingList.do" method="GET">
			<label for="bookSearch(FIXME)">Find a Reading List by Genre:</label> 
			<input type="text" name="bookSearch" />
			<input type="submit" value="Find Book(FIXME)" />
		</form>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>