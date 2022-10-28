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
				<th>Profile Pic</th>
				<th>Name</th>
				<th>About Me</th>
				<th>First Name</th>
			</tr>
			<c:forEach var="user" items="${users}">
				<tr>
					<td><img src="${user.profileUrl}" height="50" width="50" alt="${user.username}"></td>
					<td><a href="userProfile.do?id=${user.id}">${user.username}</a></td>
					<td>${user.aboutMe}</td>
					<td>${user.firstName}</td>
				</tr>
			</c:forEach>
		</table>
		<a href="bookClubSearch.do" class="btn btn-primary">Not what you're looking for?</a>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>