<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp"/>	
	</head>
	<body>
		<jsp:include page="nav.jsp"/>
		<!-- DISPLAY 
			user booklists
			user profile picture
			bookclubs
			
		
		 -->
		 <div class="container">
		 	<div class="row">
			 	<div class="col-6">
	
			 			<table>
			 				<thead>
			 					<tr>
			 						<th>Thumbnail</th>
			 						<th>Name</th>
			 						<th>Genre</th>
			 						<th>Owner</th>
									<th>Members</th>
			 					</tr>
			 				</thead>
			 				<tbody>
						 		<c:forEach var="bookClub" items="${user.bookClubs}">
						 			<tr>
						 				<td>${bookClub.profileUrl}</td>
						 				<td>${bookClub.name}</td>
						 				<td>
											<c:forEach var="genre" items="${bookClub.genres}">
												${genre.name},  
											</c:forEach>
										</td>
						 				<td>${bookClub.owner.username}</td>
						 				<td>${bookClub.users.size()} / ${bookClub.maxMembers}</td>
						 			</tr>
						 		</c:forEach>
			 				</tbody>
			 			</table>
			 	</div>
			 	<div class="col-4">
			 		<img src="${user.profileUrl}" alt="ImageNotFound"/>
			 		<p>${user.username}<p>
			 	</div>
			</div>
			<div class="row">
				<div>
					<table>
						<c:forEach var="readingList" items="${user.readingLists}">
							<tr>
								<td>${readingList.name}</td>
								<c:forEach var="book" items="${readingList.books}">
									<td>${book.title}</td>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		 </div>
		<jsp:include page="footer.jsp"/>	
	</body>
</html>