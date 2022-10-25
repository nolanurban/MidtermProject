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
		<form action="getAuthor.do" method="GET">
			Find an Author by ISBN: <input type="text" name="isbn" /> <input
				type="submit" value="Find Author" />
		</form>
		<form action="getAuthor.do" method="GET">
			Find an Author by Last Name: <input type="text" name="authorName" />
			<input type="submit" value="Find Author" />
		</form>
		<form action="getAuthor.do" method="GET">
			Find an Author by Genre: <input type="text" name="authorGenre" /> <br>
			<input type="submit" value="Find Author" />
		</form>

		<div class="container">
			<div class="col-1">

				<div class="col-1">

					<table>
						<c:if test="${! empty author }">
							<!--  will add an if exists in JSTL lingo for the URL <IMG> -->
							<tr>
								<c:forEach var="aList" items="${author}">
									<td><em>Author</em></td>
									<td>${aList.firstName}${aList.lastName}</td>
							</tr>
							<tr>
								<td><em>Author Biography</em></td>
								<td>${aList.biography}</td>
							</tr>
							<c:forEach var="bookList" items="${aList.books }">
								<tr>
									<td><em>Book Author, Year, & Genre</em></td>
									<td>ISBN: ${bookList.isbn} Title: <a
										href="showBook.do?bookSearch=${bookList.isbn}">${bookList.title}</a>
										Genre: <c:forEach var="gList" items="${bookList.genres }">${gList.name}</c:forEach>
										Year: ${bookList.publishYear } Pages: ${bookList.pages }
									</td>
								</tr>
							</c:forEach>
							</c:forEach>
						</c:if>




					</table>
				</div>
				<div class="col-2">
					<p>${user.username}
					<p>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
</body>
</html>