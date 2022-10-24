<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>	
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<!-- 
		
		This section should be a placeholder for more book information
		so a book.do?=ISBN -> java side getBookById(isbn)
		
		 -->
		 <div class="container">
		 	<div class="col-1">

		 			<table>
		 				<thead>
							<!--  will add an if exists in JSTL lingo for the URL <IMG> -->
		 					<tr><td>Book Title</tr><td>${book.title}</td>
		 					<tr><td>Book Author</td><td>${book.author }</td>
							<tr><td>Book Description</tr>td><td>${book.description}</td>
		 					<tr><td>Book Author</td><td>${book.author }</td>
		 					<tr><td>Book Pages</td><td>${book.pages}</td>
		 			<!-- 		<tr><td>Book Genre</td>${book.genre }  -->
		 			
		 					
		 								 			</table>
		 	</div>
		 	<div class="col-2">
		 		<p>${user.username}<p>
		 	</div>
		 </div>
		<jsp:include page="footer.jsp"/>	
	</body>
</html>