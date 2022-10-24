<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<div class="container">
			<h1>Update your account</h1>
			
			<form action="updateUser.do" method="POST">
				<jsp:include page="userProfileForm.jsp"/>
			</form>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>