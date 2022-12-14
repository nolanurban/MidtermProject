<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>	
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div class="container">
			<table class="table">
				<tr>
					<th scope="row">Reading List Name:</th>
					<td>${readingList.name}</td>
				</tr>
				<tr>
					<th>Title</th>
					<th>Author(s)</th>
					<th>Description</th>
				</tr>
				<c:forEach var="book" items="${readingList.books}">
					<tr>
						<td>${book.title}</td>
						<td>
							<c:forEach var="author" items="${book.authors}">
								${author.firstName} ${author.lastName}  
							</c:forEach>
						</td>
						<td>${book.description}</td>
					</tr>
				</c:forEach>
			</table>
			<c:choose>
				<c:when test="${not empty bookClub}">
					<c:if test="${not empty user }">	
						<c:if test="${user.username == readingList.bookClub.owner.username}">
							<form action="addBookToRL.do" method="POST">
								<label for="bookTitle">Title of the book to Add</label>
								<input type="text" name="bookTitle" required/><br>
								
								<input type="hidden" name="bcrlId" value="${readingList.id}"/>
								
								<input type="submit" value="Submit"/>
							</form>
							<a href="updateRL.do" class="btn btn-primary">Update this Reading List</a>
							<a href="deleteRL.do?bcrlId=${readingList.id}" class="btn btn-danger">Delete this Reading List</a>
						</c:if>
					</c:if>
				</c:when>
				<c:when test="${not empty user}">
					<c:if test="${user.username == readingList.user.username}">
						<form action="addBookToRL.do" method="POST">
							<label for="bookTitle">Title of the book to Add</label>
							<input type="text" name="bookTitle" required/><br>
							
							<input type="hidden" name="urlId" value="${readingList.id}"/>
							
							<input type="submit" value="Submit"/>
						</form>
						<a href="updateRL.do" class="btn btn-primary">Update this Reading List</a>
						<a href="deleteRL.do?urlId=${readingList.id}" class="btn btn-danger">Delete this Reading List</a>
					</c:if>
				</c:when>
			</c:choose>		
		</div>		
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>