<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="name">Reading List Name</label>
		<input type="text" name="name" required/><br>
		
		<label for="firstBook">Title of the first book you want added</label>
		<input name="firstBook" type="text" required/><br>
		
		<input type="hidden" name="bookClubId" value="${bookClub.id}"/>
	</c:when>
	<c:otherwise>
		<label for="name">Reading List Name</label>
		<input type="text" name="name" required/><br>
		
		<label for="firstBook">Title of the first book you want added</label>
		<input type="text" name="firstBook" required/><br>
	
		<input type="hidden" name="userId" value="${user.id}"/>
	</c:otherwise>
</c:choose>

<input type="submit" value="Create Reading List"/>