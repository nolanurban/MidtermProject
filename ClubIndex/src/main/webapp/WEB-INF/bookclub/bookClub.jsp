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
							<th scope="row">Owner Email</th>
							<td>${bookClub.owner.email}</td>
						</tr>
						<tr>
							<th scope="row">Created On</th>
							<td>${bookClub.createDate}</td>
						</tr>
					</table>
				</div>
				<div class="col-4">
					<img src="${bookClub.profileUrl}" style="height:300px;width:250px;height:100%;width:100%;img-fit:contain;border:4px solid black;padding:12px" alt="${bookClub.name}"/>
					<c:if test="${user == bookClub.owner}">
						<table>
							<tr>
								<td><a href="updateBookClub.do" class="btn btn-primary">Update the Club</a></td>
								<td><a href="removeUsers.do" class="btn btn-danger">Remove a User(s)</a></td>
								<td>
									<form action="addUser.do" method="POST">
										<label for="username">Add user:</label><br>
										<input type="text" name="username"/><br>
										<input type="submit" value="Add User"/>	
									</form>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><a href="deleteBookClub.do?bcId=${bookClub.id}" class="btn btn-danger">DELETE THIS CLUB</a></td>
								<td></td>
							</tr>
						</table>
					</c:if>
				</div>
			</div>
			<div class="row">
				<div>
					<table>
						<tr>
							<td>Reading List Name</td>
							<td>Number of Books</td>
						</tr>
						<c:forEach var="readingList" items="${bookClub.readingLists}">
							<tr>
								<td><a href="showSingleRL.do?id=${readingList.id}">${readingList.name}</a></td>
								<td>${readingList.books.size()}</td>
							</tr>
						</c:forEach>
					</table>
					<c:if test="${not empty user}">
						<c:if test="${user.username == bookClub.owner.username}">
							<a href="createReadingList.do" class="btn btn-primary">Create a new Reading List</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>