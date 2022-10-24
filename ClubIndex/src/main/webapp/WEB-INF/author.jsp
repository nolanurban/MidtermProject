<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp" />
</head>
<body>
	<jsp:include page="nav.jsp" />

	<div class="container">
		<div class="col-1">

			<table>
				<!--  will add an if exists in JSTL lingo for the URL <IMG> -->
				<tr>
					<td><em>Author</em>
					<td>${author.firstName}${author.lastName}</td>
				</tr>
				<tr>
					<td><em>Author Biography</em>
					<td>${author.biography}</td>
				</tr>
				<c:forEach var="bookList" items="${author.books }">
					<tr>
						<td><em>Book Author, Year, & Genre</em></td>
						<td>ISBN: ${bookList.isbn}</td>
						<td>Title: <a href="showBook.do?bookSearch=${bookList.isbn}">${bookList.title}</a></td>
						<td>Genre: 
							<c:forEach var="gList" items="${bookList.genres }">
								${gList.name} 
							</c:forEach>
						</td>
						<td>Year: ${bookList.publishYear } Pages: ${bookList.pages }</td>
				</c:forEach>
			</table>
		</div>
		<div class="col-2">
			<p>${user.username}<p>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>