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

	Find a book club by ID:
	<form action="showBookClub.do" method="GET">
		<input type="text" name="bookClubSearchById" /> <input type="submit"
			value="Find club" />
	</form>
	Find book club by location:
	<form action="showBookClub.do" method="GET">
		<input type="text" name="bookClubSearchByLocation" /> <input
			type="submit" value="Find club" />
	</form>
	Find book club by genre:
	<form action="showBookClub.do" method="GET">
		<input type="text" name="bookClubSearchByGenre" /> <input
			type="submit" value="Find club" />

		<c:forEach var="bookClub" items="${bookClubs}">
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
			<tr>
				<td>${bookClub.profileUrl}</td>
				<td>${bookClub.name}</td>
				<td>${bookClub.aboutClub}</td>
				<td>${bookClub.owner}</td>
				<td>${bookClub.maxMembers}</td>
				<td>${bookClub.location}</td>
				<td>${bookClub.digital}</td>
			</tr>
		</table>
	<%-- 		<ul>
				<li><a href="bookClub.do?id=${bookClub.id}">ID: ${bookClub.id}
						Name: ${bookClub.name}</a></li>
			</ul> --%>
		</c:forEach>
	</form>

</body>
</html>