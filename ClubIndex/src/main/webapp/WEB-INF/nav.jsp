<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav>
	<table class="borderless">
		<tr>
			<td><a href="home.do" class="btn">Home</a></td>
					<td><a href="showBook.do" class="btn">Books</a></td>
						<td><a href="getAuthor.do" class="btn">Authors</a></td>
	
					
			<c:choose>
				<c:when test="${not empty user}">
					<td><a href="account.do" class="btn">Account view</a></td>
					<td><a href="logout.do" class="btn">Logout</a></td>
					
				</c:when>
				<c:otherwise>
					<td><a href="login.do" class="btn">Login/Sign-up</a></td>
				</c:otherwise>
			</c:choose>
		</tr>
	</table>
</nav>