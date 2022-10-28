<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav id="nav">
	<table class="table table-borderless hover">
		<tr>
			<td><a href="home.do" class="btn btn-dark">Home</a></td>
			<td><a href="showBook.do" class="btn btn-dark">Books</a></td>
			<td><a href="getAuthor.do" class="btn btn-dark">Authors</a></td>					
			<td><a href="showUserRL.do" class="btn btn-dark">ReadingList</a></td>
			<td><a href="bookClubSearch.do" class="btn btn-dark">Book Club Search</a></td>
<!-- 			<td><a href="userSearch.do" class="btn btn-dark">User Search</a></td> -->
			<c:choose>
				<c:when test="${not empty user}">
					<td><a href="account.do" class="btn btn-dark">Account view</a></td>
					<td><a href="logout.do" class="btn btn-dark">Logout</a></td>
				</c:when>
				<c:otherwise>
					<td><a href="login.do" class="btn btn-dark">Login/Sign-up</a></td>
				</c:otherwise>
			</c:choose>
		</tr>
	</table>
</nav>