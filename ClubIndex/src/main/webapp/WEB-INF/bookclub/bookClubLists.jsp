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
		<table>
			<tr>
				<th>Photo</th>
				<th>Name</th>
				<th>Description</th>
				<th>Owner</th>
				<th>Max Members</th>
				<th>Location</th>
				<th>Digital</th>
			</tr>
			<c:forEach var="bookClub" items="${bookClubs}">
				<tr>
					<td><img src="${bookClub.profileUrl}" height="50" width="50" alt="${bookClub.name}"></td>
					<td><a href="bookClub.do?id=${bookClub.id}">${bookClub.name}</a></td>
					<td>${bookClub.aboutClub}</td>
					<td>${bookClub.owner.username}</td>
					<td>${bookClub.maxMembers}</td>
					<td>${bookClub.location.zipCode}</td>
					<td>${bookClub.digital}</td>
				</tr>
			</c:forEach>
		</table>
		<a href="bookClubSearch.do" class="btn btn-primary">Not what you're looking for?</a>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>