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
		<div class="container">
			<div class="col">
				<div class="input-group mb-4">
					<form action="getBookClub.do">
						<input type="text" name="bookSearch" class="form-control"
							aria-describedby="basic-addon2">  
							<input type="radio" id="id" name="searchType" value="1" checked>
							<label for="id">Clubs by Id</label>
							<input type="radio" id="owner" name="searchType" value="2">
							<label for="owner">Clubs by Book Club Owner</label>
							<input type="radio" id="genre" name="searchType" value="3">
							<label for="genre">Clubs by Genre</label>
							<input type="radio" id="location" name="searchType" value="4">
							<label for="location">Clubs By Zip Code</label>

							<input type="submit" value="Search" />
					</form>
				</div>
			</div>
			<br>
			<a href="bookClubsByDigitalAvailability.do?digital=${bookClub.digital}">See Digital Book Clubs</a>
			<br>
			<table class="table">
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
						<td><img src="${bookClub.profileUrl}" height="50" width="50" alt="ImageNotFound"/></td>
						<td><a href="showBookClub.do?id=${bookClub.id}">${bookClub.name}</a></td>
						<td>${bookClub.aboutClub}</td>
						<td>${bookClub.owner.username}</td>
						<td>${bookClub.maxMembers}</td>
						<td>${bookClub.location.zipCode}</td>
						<td>${bookClub.digital}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>