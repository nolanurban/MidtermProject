<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp"/>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>

		<div class="container text-center">
			<div class="row">
				<div class="col">
					<div class="input-group mb-3">
						<form action="getAuthor.do">
							<input type="text" name="authorSearch" class="form-control"
								aria-describedby="basic-addon2">  
								<input type="radio" id="isbn" name="searchType" value="2" checked>
								<label for="isbn">Search by an ISBN</label>
								<input type="radio" id="name" name="searchType" value="3">
								<label for="name">Search by a Last Name</label>	
								<input type="submit" value="Search" />
						</form>
					</div>
				</div>
				<div class="col">
					<form action="getAuthor.do" method="GET">
						<select name="authorSearch">
						<c:forEach var="g" items="${genre}">
						<option value="${g.name}">${g.name}</option>
						</c:forEach>
						</select><input type="hidden" name="searchType" value="4">
						<input type="submit" value="Find Author By Genre" />
					</form>
				</div>
				
			</div>
		</div>
		
		<c:if test="${! empty author }">
			<c:forEach var="aList" items="${author}">
				<table class="table">
				 	<thead>
					    <tr>
	 					   <c:if test="${! empty aList.headshotUrl}">
						<th scope="col">Image</th></c:if>				   
					      <th scope="col">Name</th>
					      <th scope="col">Biography</th>
					      <c:if test="${! empty aList.websiteUrl}">
				 		  <th scope="col">Website</th></c:if>
					            
					    </tr>
					</thead>
					<tbody>
					   <tr>
					   		<c:if test="${! empty aList.headshotUrl}">
					   		<td><img src="${aList.headshotUrl}" alt="${aList.firstName} ${aList.lastName}" height="300" width="250"></td>
					   		</c:if>
					      <td>${aList.firstName} ${aList.lastName}</td>
					      <td>${aList.biography}</td>
					      <c:if test="${! empty aList.websiteUrl}">
				 		  <td><a href="${aList.websiteUrl}">Visit ${aList.firstName} ${aList.lastName}'s Website</a></td>
				 		  </c:if>
					      
					   </tr>
				   </tbody>
				</table>
				<c:forEach var="bookList" items="${aList.books}">
					<table class="table">
					  	<thead>
						    <tr>
							    <th scope="col">ISBN</th>
							    <th scope="col">Title</th>
							    <th scope="col">Description</th>
							    <th scope="col">Genre</th>
							    <th scope="col">Pages</th>
							    <th scope="col">Year</th>
						    </tr>
					  	</thead>
					  	<tbody>
						<tr>
							<td>${bookList.isbn}</td>
							<td>${bookList.title}</td>
							<td>${bookList.description }</td>
							<c:forEach var="gList" items="${bookList.genres}"><td>${gList.name} </td></c:forEach>
							<td>${bookList.pages }</td>
							<td>${bookList.publishYear }</td>
					    </tr>
					   </tbody>
					</table>
				</c:forEach>
			</c:forEach>
		</c:if>
							
		<div class="col-2">
			<p>${user.username}<p>
		</div>
		<jsp:include page="../includes/footer.jsp" />
	</body>
</html>












