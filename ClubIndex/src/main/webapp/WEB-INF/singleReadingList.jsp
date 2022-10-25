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
		<div class="container">
			<table>
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
		</div>		
		<jsp:include page="footer.jsp"/>
	</body>
</html>