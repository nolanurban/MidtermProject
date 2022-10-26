<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="includes/nav.jsp"/>
		<div class="container">
			<div class="banner">
				<h2>Welcome to Club Index</h2>
			</div>
			<div class="row">
				<div class="col-4">
					<h3>What our users are saying:</h3>
					<table class="table">
						<tr>
							<th>Book</th>
							<th>Review</th>
							<th>Rating</th>
							<th>User</th>
						</tr>
						<c:forEach var="review" items="${reviews}">
							<tr>
								<td>${review.book.title}</td>
								<c:choose>
									<c:when test="${not empty review.review}">
										<td>${review.review}</td>
									</c:when>
									<c:otherwise>
										<td> ~~~ </td>
									</c:otherwise>
								</c:choose>
								<td>${review.rating}</td>
								<td>${review.user.username}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="col-4">
					<c:if test="${not empty user}">
						<a href="createBookClub.do" class="btn btn-primary">Create your own BookClub</a>
					</c:if>
				</div>
				<div class="col-4">
					<h3>Random Book</h3>
					<table class="table table-borderless">
						<tr>
							<td><img src="${book.coverUrl}" height="300" width="250" alt="${book.title}"></td>
						</tr>
						<tr>
							<td>${book.title}</td>
						</tr>
						<tr>
							<c:forEach var="author" items="${book.authors}">
								<td>${author.firstName} ${author.lastName}</td>
							</c:forEach>
						</tr>
						<tr>
							<td>${book.description}</td>
						</tr>
					</table>
				</div>
			</div>

		</div>
		<jsp:include page="includes/footer.jsp"/>
	</body>
</html>