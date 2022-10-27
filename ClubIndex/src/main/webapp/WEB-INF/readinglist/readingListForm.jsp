<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
	<c:when test="${not empty bookClub}">
		<c:choose>
			<c:when test="${not empty readingList}">
				<label for="name">Reading List Name</label>
				<input type="text" name="name" value="${readingList.name}" required/><br>
				
				<table>
					<tr>
						<th>Book Title</th>
						<th>Author</th>
						<th>Delete?</th>
					</tr>
					<c:forEach var="book" items="${readingList.books}">
						<tr>
							<td>${book.title}</td>
							<td>
								<c:forEach var="author" items="${book.authors}">
									${author.firstName} ${author.lastName} 
								</c:forEach>
							</td>
							<td><input type="checkbox" name="isbns" value="${book.isbn}"/></td>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" name="bcrlId" value="${readingList.id}"/>
			</c:when>
			<c:otherwise>
				<label for="name">Reading List Name</label>
				<input type="text" name="name" required/><br>
				
				<label for="firstBook">Title of the first book you want added</label>
				<input name="firstBook" type="text" required/><br>
				
				<input type="hidden" name="bookClubId" value="${bookClub.id}"/>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${not empty readingList}">
				<label for="name">Reading List Name</label>
				<input type="text" name="name" value="${readingList.name}" required/><br>
				
				<table>
					<tr>
						<th>Book Title</th>
						<th>Author</th>
						<th>Delete?</th>
					</tr>
					<c:forEach var="book" items="${readingList.books}">
						<tr>
							<td>${book.title}</td>
							<td>
								<c:forEach var="author" items="${book.authors}">
									${author.firstName} ${author.lastName} 
								</c:forEach>
							</td>
							<td><input type="checkbox" name="isbns" value="${book.isbn}"/></td>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" value="${readingList.id}" name="userRLId"/>
			</c:when>
			<c:otherwise>
				<label for="name">Reading List Name</label>
				<input type="text" name="name" required/><br>
				
				<label for="firstBook">Title of the first book you want added</label>
				<input type="text" name="firstBook" required/><br>
			
				<input type="hidden" name="userId" value="${user.id}"/>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

<input type="submit" value="Create Reading List"/>