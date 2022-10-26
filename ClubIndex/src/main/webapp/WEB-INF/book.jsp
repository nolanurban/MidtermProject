<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp" />
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container text-center">
		<div class="row">
			<div class="col">
				<div class="input-group mb-3">
					<form action="showBook.do">
						<input type="text" name="bookSearchAll" class="form-control"
							aria-describedby="basic-addon2">  
							<input type="radio" id="isbn" name="bsearchType" value="1" checked>
							<label for="isbn">Search by an ISBN</label>
							<input type="radio" id="name" name="bsearchType" value="2">
							<label for="name">Search by an author Last Name</label>
							<input type="radio" id="genre" name="bsearchType" value="3">
							<label for="genre">Search by genre</label>
							<input type="radio" id="keyword" name="bsearchType" value="4">
							<label for="genre">Search by a Keyword</label>
							<input type="radio" id="year" name="bsearchType" value="5">
							<label for="genre">Search by Year</label>
							<input type="radio" id="title" name="bsearchType" value="6">
							<label for="genre">Search by Title</label>
							<input type="radio" id="year" name="bsearchType" value="7">
							<label for="genre">Retrieve all books</label>

							<input type="submit" value="Search" />
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 
		
		This section should be a placeholder for more bList information
		so a bList.do?=ISBN -> java side getBookById(isbn)
		
		 Find a book by ISBN:
		    <form action="showBook.do" method="GET">
        <input type="text" name="bookSearch"/> <input
            type="submit" value="Find book" />
   		 </form>
   		 Find books by year:
   		 <form action="showBook.do" method="GET">
        <input type="text" name="bookSearchYear"/> <input
            type="submit" value="Find book" />
   		 </form>
   		 Find books by title:
   		 <form action="showBook.do" method="GET">
         <input type="text" name="bookSearchName"/> <input
            type="submit" value="Find book" />
   		 </form>
   		 Find books by key word search:
   		 		    <form action="showBook.do" method="GET">
        <input type="text" name="bookSearchKeyWord"/> <input
            type="submit" value="Find book" />
   		 </form>
   		  Find books by author last name:
   		 		    <form action="showBook.do" method="GET">
        <input type="text" name="bookSearchAuthorName"/> <input
            type="submit" value="Find book" />
   		 </form>
   		  Find books by genre
   		 		    <form action="showBook.do" method="GET">
        <input type="text" name="bookSearchGenre"/> <input
            type="submit" value="Find book" />
   		 </form>
   		  Get all books
   		 		    <form action="showBook.do" method="GET">
        <input
            type="submit" name="getAllBooks" value="Find book" />
   		 </form>
   
   		 		 -->
   		 
   		 	<c:if test="${! empty book }">
	<c:forEach var="bookList" items="${book}">
	<table class="table">
  <thead>
  <tr><th scope="col">ISBN</th>
      <th scope="col">Author</th>
      <th scope="col">Title</th>
      <th scope="col">Description</th>
      <th scope="col">Genre</th>
      <th scope="col">Pages</th>
      <th scope="col">Year</th>
      </tr>
  </thead>
  <tbody>
	<tr><td>${bookList.isbn}</td>
<c:forEach var="aList" items="${bookList.authors}">
	<td>${aList.firstName} ${aList.lastName }</td>
	</c:forEach>
	<td>${bookList.title}</td>
	<td>${bookList.description }</td>
	<c:forEach var="gList" items="${bookList.genres}">
	<td>${gList.name }</td></c:forEach>
	<td>${bookList.pages }</td>
	<td>${bookList.publishYear }</td>
    </tr>
   </tbody>
</table>
</c:forEach>
</c:if>	
				
   			 		<p>${user.username}<p>
		 		<jsp:include page="footer.jsp"/>	
	</body>
</html>