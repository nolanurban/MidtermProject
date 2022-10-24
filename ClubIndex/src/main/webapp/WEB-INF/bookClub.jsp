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
			<div class="banner">
				<h1>${bookClub.name}</h1>
			</div>
			<div class="row">
				<div class="col-8">
					<table>
						<tr>
							<th scope="row">Users</th>
							<td>${bookClub.users.size()} / ${bookClub.maxMembers}</td>
						</tr>
						<tr>
							<th scope="row">About us</th>
							<td>${bookClub.aboutClub}</td>
						</tr>
						<tr>
							<th scope ="row">Genre(s) we cover</th>
							<c:forEach var="genre" items="${bookClub.genres}">
								<td>${genre.name}</td>
							</c:forEach>
						</tr>
						<tr>
							<th scope="row">Digital?</th>
							<c:choose>
								<c:when test="${bookClub.digital}">
									<td>Yes</td>
								</c:when>
								<c:otherwise>
									<td>No</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">Owner</th>
							<td>${bookClub.owner.username}</td>
						</tr>
						<tr>
							<th scope="row">Created On</th>
							<td>${bookClub.createDate}</td>
						</tr>
					</table>
				</div>
				<div class="col-4">
					<img src="${bookClub.profileUrl}" alt="ImageNotFound"/>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>