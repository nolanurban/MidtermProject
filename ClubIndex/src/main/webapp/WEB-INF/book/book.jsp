<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../includes/header.jsp" />
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp" />
		<div class="container text-center">
			<div class="row">
				<div class="col">
					<div class="input-group mb-3">
						<form action="showBook.do">
							<input type="text" name="bookSearchAll" class="form-control" aria-describedby="basic-addon2">
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
		<c:if test="${! empty book }">
			<c:forEach var="bookList" items="${book}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ISBN</th>
							<th scope="col">Author</th>
							<th scope="col">Title</th>
							<c:if test="${! empty bookList.coverUrl}">
							<th scope="col">Book Cover</th>
							</c:if>
							<th scope="col">Description</th>
							<th scope="col">Genre</th>
							<th scope="col">Pages</th>
							<th scope="col">Year</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${bookList.isbn}</td>
							<td>
								<c:forEach var="aList" items="${bookList.authors}">
									${aList.firstName} ${aList.lastName } 
								</c:forEach>
							</td>
							<td>${bookList.title}</td>
							<c:if test="${! empty bookList.coverUrl}">
					   		<td><img src="${bookList.coverUrl}" class="full-photo"></td>
					   		</c:if>
							<td>${bookList.description }</td>
							<td>
								<c:forEach var="gList" items="${bookList.genres}">
									${gList.name} 
								</c:forEach>
							</td>
							<td>${bookList.pages }</td>
							<td>${bookList.publishYear }</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
		</c:if>
		<jsp:include page="../includes/footer.jsp" />
	</body>
</html>