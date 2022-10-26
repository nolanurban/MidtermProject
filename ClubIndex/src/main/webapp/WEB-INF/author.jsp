<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="includes/header.jsp"/>
</head>
<body>
		<jsp:include page="includes/nav.jsp"/>

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
							<input type="radio" id="genre" name="searchType" value="4">
							<label for="genre">Search by genre</label>

							<input type="submit" value="Search" />
					</form>
				</div>

			</div>
			<div class="col">
				<form action="getAuthor.do" method="GET">
					<select name="authorGenre">
						<option value="Horror">Horror</option>
						<option value="Fantasy">Fantasy</option>
						<option value="Childrens Literature">Children's
							Literature</option>
						<option value="Historical Fiction">Historical Fiction</option>
						<option value="Romance">Romance</option>
						<option value="Narrative">Narrative</option>
						<option value="Mystery">Mystery</option>
						<option value="Science-Fiction">Science Fiction</option>
						<option value="Biography">Biography</option>
					</select><input type="submit" value="Authors By Genre" />
				</form>
			</div>
		</div>
	</div>
	


	<c:if test="${! empty author }">
	<c:forEach var="aList" items="${author}">
	<table class="table">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Biography</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>${aList.firstName} ${aList.lastName}</td>
      <td>${aList.biography}</td>

    </tr>
   </tbody>
</table>
</c:forEach>
</c:if>
	<c:if test="${! empty author }">
	<c:forEach var="aList" items="${author}"><c:forEach var="bookList" items="${aList.books}">
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
<tr><td>${bookList.isbn}</td>
	<td>${bookList.title}</td>
	<td>${bookList.description }</td>
	<c:forEach var="gList" items="${bookList.genres}">
	<td>${gList.name }</td></c:forEach>
	<td>${bookList.pages }</td>
	<td>${bookList.publishYear }</td>
    </tr>
   </tbody>
</table>
</c:forEach></c:forEach>
</c:if>					
<div class="col-2">
		<p>${user.username}
		<p>
	</div>
	<jsp:include page="includes/footer.jsp" />
</body>
</html>