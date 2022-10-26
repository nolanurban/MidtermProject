<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>	
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<h1>Create your own!</h1>
		<form action="createBookClub.do" method="POST">
			<jsp:include page="../location/locationForm.jsp"/>
			<jsp:include page="bookClubForm.jsp"/>
		</form>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>