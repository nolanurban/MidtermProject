<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>	
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<h1>Create your own!</h1>
		<form action="createBookClub.do" method="POST">
			<jsp:include page="bookClubForm.jsp"/>
		</form>
		<jsp:include page="footer.jsp"/>
	</body>
</html>