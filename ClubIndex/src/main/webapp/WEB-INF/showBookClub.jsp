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
		<table>
			<tr>
				<th>Name</th>
				<th>Max Members</th>
				<th>Genres</th>
				<th>Description</th>
				<th>Location</th>
				<th>Members</th>
				<th>Owner</th>
				<th>Digital</th>
			</tr>
			<tr>
				<td><a href="showBookClub.do?id=${bookClub.id}">${bookClub.name}</a></td>
				<td>${bookClub.maxMembers}</td>
				<td>${bookClub.genres}</td>
				<td>${bookClub.aboutClub}</td>
				<td>${bookClub.location}</td>
				<td>${bookClub.users}</td>
				<td>${bookClub.owner}</td>
				<td>${bookClub.digital}</td>
			</tr>
		</table>

	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>