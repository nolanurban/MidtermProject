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
	
		Find a book club by ID:
		<form action="bookClub.do" method="GET">
			<input type="text" name="id"/> <input type="submit"
				value="Find club" />
		</form>
		Find book club by location:
		<form action="bookClubSearchByLocation.do" method="GET">
			<input type="text" name="zipCode"/> <input
				type="submit" value="Find club" />
		<br>		
		
		</form>
		Find book club by genre:
		<form action="bookClubSearchByGenre.do" method="GET">
			<input type="text" name="genreName"/> <input
				type="submit" value="Find club" />
				<!-- Trying to use bookClubLists.jsp as the go to for searches, encountering an error with genre -->
		<br>
		<a href="bookClubsByDigitalAvailability.do?digital=${bookClub.digital}">Book Clubs By Digital Availability</a>
		<br>			
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
					<td>${bookClub.profileUrl}</td>
					<td><a href="bookClub.do?id=${bookClub.id}">${bookClub.name}</a></td>
					<td>${bookClub.aboutClub}</td>
					<td>${bookClub.owner.username}</td>
					<td>${bookClub.maxMembers}</td>
					<td>${bookClub.location.zipCode}</td>
					<td>${bookClub.digital}</td>
				</tr>
			</c:forEach>
			</table>
		</form>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>