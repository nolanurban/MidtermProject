<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
	<c:when test="${not empty user}">
		<label for="firstName">First Name</label>	
		<input type="text" name="firstName" value="${user.firstName}" required><br>
	</c:when>
	<c:otherwise>
		<label for="firstName">First Name</label>	
		<input type="text" name="firstName" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="lastName">Last Name</label>	
		<input type="text" name="lastName" value="${user.lastName}" required><br>
	</c:when>
	<c:otherwise>
		<label for="lastName">Last Name</label>	
		<input type="text" name="lastName" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="userName">User Name</label>	
		<input type="text" name="userName" value="${user.userName}" required><br>
	</c:when>
	<c:otherwise>
		<label for="userName">User Name</label>	
		<input type="text" name="userName" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<img src="${user.imageUrl}" width="300" height="300"><br>
		<input type="url" name="profileUrl" value="${user.profileUrl}"><br>
	</c:when>
	<c:otherwise>
		<label for="profileUrl">Profile Image URL</label>
		<input type="url" name="profileUrl"><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="email">Email</label>	
		<input type="text" name="email" value="${user.email}" required><br>
	</c:when>
	<c:otherwise>
		<label for="email">User Name</label>	
		<input type="text" name="email" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="password">Password</label>	
		<input type="text" name="password" value="${user.password}" required><br>
	</c:when>
	<c:otherwise>
		<label for="password">Password</label>	
		<input type="text" name="password" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="aboutMe">About you</label><br>
		<textarea name="aboutMe" rows="30" cols="120">${user.aboutMe}</textarea><br>
	</c:when>
	<c:otherwise>
		<label for="aboutMe">About You</label><br>
		<textarea name="aboutMe" rows="30" cols="120"></textarea><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="street">Street</label>	
		<input type="text" name="street" value="${user.location.street}" required><br>
	</c:when>
	<c:otherwise>
		<label for="street">Street</label>	
		<input type="text" name="street" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="unit">Street part 2. (unit, fpo/ap ect)</label>	
		<input type="text" name="unit" value="${user.location.unit}" required><br>
	</c:when>
	<c:otherwise>
		<label for="unit">Street part 2. (unit, fpo/ap ect)</label>	
		<input type="text" name="unit" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="city">City</label>	
		<input type="text" name="city" value="${user.location.city}" required><br>
	</c:when>
	<c:otherwise>
		<label for="city">City</label>	
		<input type="text" name="city" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="state">State</label>	
		<input type="text" name="state" value="${user.location.state}" required><br>
	</c:when>
	<c:otherwise>
		<label for="state">State</label>	
		<input type="text" name="state" required><br>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty user}">
		<label for="zipCode">Zip Code</label>	
		<input type="text" name="zipCode" value="${user.location.zipCode}" required><br>
	</c:when>
	<c:otherwise>
		<label for="zipCode">Zip Code</label>	
		<input type="text" name="zipCode" required><br>
	</c:otherwise>
</c:choose>

<button type="submit">Submit Account</button>
	
