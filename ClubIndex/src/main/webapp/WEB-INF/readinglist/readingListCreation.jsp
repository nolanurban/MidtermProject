<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/> 
		<div class="container">
			<c:choose>
				<c:when test="${not empty bookClub}">
					<h3>Create a reading list for ${bookClub.name}</h3>
				</c:when>
				<c:otherwise>
					<h3>Create a reading list for ${user.username}</h3>
				</c:otherwise>
			</c:choose>
			<form action="createReadingList.do" method="POST">
				<jsp:include page="readingListForm.jsp"/>
			</form>
		</div>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>