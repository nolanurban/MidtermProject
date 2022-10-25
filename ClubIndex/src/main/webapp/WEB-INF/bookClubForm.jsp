<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="name">Name</label>
		<input type="text" name="name" value="${bookClub.name}" required>
	</c:when>
	<c:otherwise>
		<label for="name">Name</label>
		<input type="text" name="name" required>
	</c:otherwise>
</c:choose><br>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="aboutClub">About Club</label>
		<textarea name="aboutClub" cols="50" rows="10">${bookClub.aboutClub}</textarea>
	</c:when>
	<c:otherwise>
		<label for="aboutClub">About Club</label>
		<textarea name="aboutClub" cols="50" rows="10"></textarea>	
	</c:otherwise>
</c:choose><br>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="maxMembers">Max Members</label>
		<input type="number" name="maxMembers" value="${bookClub.maxMembers}" required/>
	</c:when>
	<c:otherwise>
		<label for="maxMembers">Max Members</label>
		<input type="number" name="maxMembers" required/>
	</c:otherwise>
</c:choose><br>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="digital">Digital?</label>
		<select name="digital">
			<c:choose>
				<c:when test="${bookClub.digital}">
					<option value="true" selected>Yes</option>
					<option value="false">No</option>
				</c:when>
				<c:otherwise>
					<option value="true">Yes</option>
					<option value="false" selected>No</option>
				</c:otherwise>
			</c:choose>
		</select>
	</c:when>
	<c:otherwise>
		<label for="digital">Digital?</label>
		<select name="digital" required>
			<option value="true">Yes</option>
			<option value="false">No</option>
		</select>
	</c:otherwise>
</c:choose><br>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="profileUrl">Club Picture Url</label>
		<input type="url" name="profileUrl" value="${bookClub.profileUrl}"/>
	</c:when>
	<c:otherwise>
		<label for="profileUrl">Club Picture Url</label>
		<input type="url" name="profileUrl"/>
	</c:otherwise>
</c:choose><br>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="genres">Genres Covered</label>
		<c:forEach var="genre" items="${genres}">
			<c:choose>
				<c:when test="${bookClub.genres.contains(genre)}">
					<input type="checkbox" id="${genre.name}" value="${genre.id}" name="genreIds" checked>
				</c:when>
				<c:otherwise>
					<input type="checkbox" id="${genre.name}" value="${genre.id}" name="genreIds">				
				</c:otherwise>
			</c:choose>
			<label for="${genre.name}">${genre.name}</label>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<label for="genreIds">Genres Covered</label><br>
		<c:forEach var="genre" items="${genres}">
			<input type="checkbox" id="${genre.name}" value="${genre.id}" name="genreIds">
			<label for="${genre.name}">${genre.name}</label>
		</c:forEach>
	</c:otherwise>
</c:choose><br>

<c:if test="${not empty bookClub}">
	<input type="hidden" value="${bookClub.id}" name="id"/>
</c:if>

<input type="hidden" value="${user.id}" name="ownerId"/>

<input type="submit" value="Submit">