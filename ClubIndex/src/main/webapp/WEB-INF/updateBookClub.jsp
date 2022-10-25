<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		
		<form action="updateBookClub.do" method="post">
			<jsp:include page="bookClubForm.jsp"/>
		</form>
		
		<jsp:include page="footer.jsp"/>
	</body>
</html>