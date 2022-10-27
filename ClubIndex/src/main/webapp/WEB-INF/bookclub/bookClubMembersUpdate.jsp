<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table">
	<thead>
		<tr>
			<th>Profile Picture</th>
			<th>Username</th>
			<th>Remove User?</th>
		</tr>
	</thead>
	<c:forEach var="user" items="${bookClub.users}">
		<tr>
			<td><img src="${user.profileUrl}" height="50" width="50" alt="ImageNotFound"/></td>
			<td>${user.username}</td>
			<td><input type="checkbox" value="${user.id}" name="userIds"></td>
		</tr>		
	</c:forEach>
</table>
<input type="submit" value="Submit Changes"/>