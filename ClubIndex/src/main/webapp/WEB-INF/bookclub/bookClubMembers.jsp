<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<form action="removeUsers.do" method="POST">
			<jsp:include page="bookClubMembersUpdate.jsp"/>
		</form>
		<jsp:include page="../includes/footer.jsp"/>
	</body>
</html>