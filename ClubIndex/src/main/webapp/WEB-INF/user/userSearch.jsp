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
				<div class="input-group mb-3">
					<form action="getUser.do">
						<input type="text" name="userSearch" class="form-control"
							aria-describedby="basic-addon2">  
							<input type="radio" id="username" name="searchType" value="1">
							<label for="username">Find Friends By Username</label>
							<input type="radio" id="firstName" name="searchType" value="2">
							<label for="firstName">Find Friends by First Name</label>
							<input type="radio" id="lastName" name="searchType" value="3">
							<label for="lastName">Find Friends by Last Name</label>

							<input type="submit" value="Search" />
					</form>
				</div>
			</div>	
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>