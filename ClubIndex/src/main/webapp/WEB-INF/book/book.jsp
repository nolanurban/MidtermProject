<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp" />
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp" />
		<!-- 
			
			This section should be a placeholder for more bList information
			so a bList.do?=ISBN -> java side getBookById(isbn)
			
			 -->
		<form action="showBook.do" method="GET">
			<label for="bookSearch">Find a book by ISBN:</label>
			<input type="text" name="bookSearch" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="bookSearchYear">Find books by year:</label>
			<input type="text" name="bookSearchYear" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="bookSearchName">Find books by title:</label>
			<input type="text" name="bookSearchName" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="bookSearchKeyWord">Find books by key word search:</label>
			<input type="text" name="bookSearchKeyWord" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="bookSerachAuthorName">Find books by author last name:</label>
			<input type="text" name="bookSearchAuthorName" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="bookSearchGenre">Find books by genre</label>
			<input type="text" name="bookSearchGenre" />
			<input type="submit" value="Find book" />
		</form>
		<form action="showBook.do" method="GET">
			<label for="getAllBooks">Get all books</label>
			<input type="submit" name="getAllBooks" value="Find book" />
		</form>
	
		<div class="container">
			<c:if test="${! empty book }">
				<c:forEach var="bList" items="${book}">
					<table>
						<!--  will add an if exists in JSTL lingo for the URL <IMG> -->
						<tr>
							<td><em>Book Title</em></td>
							<td>${bList.title}</td>
						</tr>
						<tr>
							<td><em>Book Description</em></td>
							<td>${bList.description}</td>
						</tr>
						<c:forEach var="aList" items="${bList.authors }">
							<tr>
								<td><em>Book Author</em></td>
								<td><a href="getAuthor.do?id=${aList.id}">${aList.id} ${aList.firstName } ${aList.lastName }</a></td>
							</tr>
						</c:forEach>
						<tr>
							<td><em>Book Pages</em></td>
							<td>${bList.pages}</td>
						</tr>
						<c:forEach var="gList" items="${bList.genres }">
							<tr>
								<td>Book Genre</td>
								<td>${gList.name}</td>
							</tr>
						</c:forEach>
						<tr>
							<td><em>Book Published Year</em></td>
							<td>${bList.publishYear}</td>
						</tr>
					</table>
				</c:forEach>
			</c:if>
		</div>
		<jsp:include page="../includes/footer.jsp" />
	</body>
</html>