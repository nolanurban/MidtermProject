<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<c:choose>
	<c:when test="${not empty bookClub}">
		<label for="street">Street</label>
		<input type="text" value="${bookClub.location.street}" name="street"/><br>
		
		<label for="unit">Unit</label>
		<input type="text" name="unit" value="${bookClub.location.unit}"/><br>
		
		<label for="city">City</label>
		<input type="text" name="city" value="${bookClub.location.city}"/><br>
		
		<label for="state">State</label>
		<input type="text" name="state" value="${bookClub.location.state}"/><br>
		
		<label for="zipCode">Zip Code</label>
		<input type="number" name="zipCode" value="${bookClub.location.zipCode}" required/><br>
	</c:when>
	<c:when test="${not empty user}">
		<label for="street">Street</label>
		<input type="text" value="${user.location.street}" name="street"/><br>
		
		<label for="unit">Unit</label>
		<input type="text" name="unit" value="${user.location.unit}"/><br>
		
		<label for="city">City</label>
		<input type="text" name="city" value="${user.location.city}"/><br>
		
		<label for="state">State</label>
		<input type="text" name="state" value="${user.location.state}"/><br>
		
		<label for="zipCode">Zip Code</label>
		<input type="number" name="zipCode" value="${user.location.zipCode}" required/><br>
	</c:when>
	<c:otherwise>
		<label for="street">Street</label>
		<input type="text" name="street"/><br>
		
		<label for="unit">Unit</label>
		<input type="text" name="unit"/><br>
		
		<label for="city">City</label>
		<input type="text" name="city"/><br>
		
		<label for="state">State</label>
		<input type="text" name="state"/><br>
		
		<label for="zipCode">Zip Code</label>
		<input type="number" name="zipCode" required/><br>
	</c:otherwise>
</c:choose>