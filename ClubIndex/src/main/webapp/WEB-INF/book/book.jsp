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
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ISBN</th>
							<th scope="col">Author</th>
							<th scope="col">Title</th>
							<th scope="col">Book Cover</th>
							<th scope="col">Description</th>
							<th scope="col">Genre</th>
							<th scope="col">Pages</th>
							<th scope="col">Year</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bookList" items="${book}">
							<tr>
								<td>${bookList.isbn}</td>
								<td>
									<c:forEach var="aList" items="${bookList.authors}">
										${aList.firstName} ${aList.lastName } 
									</c:forEach>
								</td>
								<td><a href="showBook.do?bookSearchAll=${bookList.title}&bsearchType=6">${bookList.title}</a></td>
								<c:if test="${! empty bookList.coverUrl}">
						   		<td><img src="${bookList.coverUrl}" height="300" width="250" alt="${bookList.title}"></td>
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
						</c:forEach>
					</tbody>
				</table>
		</c:if>
		<c:if test="${not empty user && empty userReview && not empty book}">
		<div class="mb-2 container text-center">
		  <form action="newBookReview.do"><c:forEach var="bL" items="${book}">
		  <input type="hidden" name="isbnVal" value="${bL.isbn}"></c:forEach>
		  <label for="newReviewForm" class="form-label">Leave a review </label>
		  <textarea name="review" class="form-control" id="newReviewForm" rows="2"></textarea><br>
		  <label for="rating">Rate this book 1-9</label><br>
		  <select name="rating">
						<option value="1">1 - Worst Book I've Ever Read!</option>
						<option value="2">2 - It was bad</option>
						<option value="3">3 - I survived</option>
						<option value="4">4 - Meh</option>
						<option value="5">5 - Pretty Okay</option>
						<option value="6">6 - Good</option>
						<option value="7">7 - Darn Good!</option>
						<option value="8">8 - Impressive</option>
						<option value="9">9 - Wow, amazing!</option>
			</select>
			<input type="submit" value="Submit Review" />
		  </form>
		</div>
		</c:if>
		<c:if test="${! empty userReview }">
		<div class="mb-2 container text-center">
		  <form action="updateExistingBookReview.do" class="form-floating"><c:forEach var="bL" items="${book}">
		  <input type="hidden" name="isbnVal" value="${bL.isbn}"></c:forEach>
		  <input type="text" class="form-control" name="review" id="floatingInputValue" placeholder="Your Review" value="${userReview.review } + Number Rating: ${userReview.rating}">
		  <label for="floatingInputValue">Your Review</label>
		  <select name="rating">
						<option value="1">1 - Worst Book I've Ever Read!</option>
						<option value="2">2 - It was bad</option>
						<option value="3">3 - I survived</option>
						<option value="4">4 - Meh</option>
						<option value="5">5 - Pretty Okay</option>
						<option value="6">6 - Good</option>
						<option value="7">7 - Darn Good!</option>
						<option value="8">8 - Impressive</option>
						<option value="9">9 - Wow, amazing!</option>
			</select>
			<input type="hidden" name="reviewId" value="${userReview.id}">
			<input type="submit" value="Update Review" />
		  </form>
		</div>
		</c:if>
		<c:if test="${! empty review && empty userReview}">
			<c:forEach var="rList" items="${review}">
				<div class="mb-3 container text-center">
					<table>
					<tr><th colspan="2">Some User Reviews & Ratings:</th></tr>
					<tr><th>Review</th><th>Rating</th></tr>
					<tr>
				    <td>${rList.review}</td>
				    <td>${rList.rating}</td>
				    </tr>
				    </table>
				</div>
				    
			</c:forEach>	
		</c:if>

		<jsp:include page="../includes/footer.jsp" />
	</body>
</html>