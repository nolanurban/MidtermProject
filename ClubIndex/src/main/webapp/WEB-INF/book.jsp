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
		 Find a book:
		    <form action="showBook.do" method="GET">
        <input type="text" name="bookSearch"/> <input
            type="submit" value="Find Book" />
   		 </form>
		 <div class="container">
		 	<div class="col-1">
		 	
			<c:if test="${! empty book }">
		 			<table>
							<!--  will add an if exists in JSTL lingo for the URL <IMG> -->
		 					<tr><td><em>Book Title</em><td>${book.title}</td></tr>
							<tr><td><em>Book Description</em><td>${book.description}</td></tr>
							<c:forEach var="aList" items="${book.authors }">
		 					<tr><td><em>Book Author</em></td><td><a href="getAuthor.do?id=${aList.id}">${aList.firstName } ${aList.lastName }</a></td></c:forEach>
		 					<tr><td><em>Book Pages</em></td><td>${book.pages}</td>
		 					<c:forEach var="gList" items="${book.genres }">
		 					<tr><td>Book Genre</td><td>${gList.name}</td></tr></c:forEach>
		 					<tr><td><em>Book Published Year</em><td>${book.publishYear}</td></tr>
		 			
		 					
		 								 			</table></c:if>
		 	</div>
		 	<div class="col-2">
		 		<p>${user.username}<p>
		 	</div>
		 </div>
		<jsp:include page="footer.jsp"/>	
	</body>
</html>