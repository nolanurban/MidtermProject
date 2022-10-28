package com.skilldistillery.jpaclubindex.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.ReviewDAO;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Review;
import com.skilldistillery.jpaclubindex.entities.User;

@Controller
public class BookController {

	@Autowired
	private BookDAO bookDao;
	@Autowired
	private ReviewDAO reviewDao;
	
	@RequestMapping(path="showBook.do")
	public String searchForBook(HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		return "book/book";
	}
	
	@RequestMapping(path="showBook.do", params={ "bookSearchAll", "bsearchType" })
	public String searchForBook(String bookSearchAll, int bsearchType, HttpSession session) {
		switch (bsearchType) {
			case 1:
				return getBookByISBN(bookSearchAll, session);
			case 2:
				return getBookByAuthor(bookSearchAll, session);
			case 3:
				try {
					return getBookByGenre(bookSearchAll, session);
				} catch(Exception e) {
					return searchForBook(session);
				}
			case 4:
				return getBookByKeyWord(bookSearchAll, session);
			case 5:
				try {
					return getBookByYear(Integer.parseInt(bookSearchAll), session);
				} catch(Exception e) {
					return searchForBook(session);
				}
			case 6:
				return getBookByTitle(bookSearchAll, session);
			case 7:
				return getAllBooks(session);
			default:
				return searchForBook(session);
		}
	}
	
	private String getBookByISBN(String bookSearch, HttpSession session) {
			session.removeAttribute("book");
			session.removeAttribute("review");
			session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookById(bookSearch);
		
			List<Review> bookReviews = new ArrayList<>();
			
			for (Book b : book) {
				bookReviews.addAll(reviewDao.getReviewByBook(b));
			}
	
			User user = ((User)session.getAttribute("user"));  
			for (Book b : book) { 
				for (Review r : reviewDao.getReviewByUser(user)) { 
					if (r.getBook().equals(b)) { 
						session.setAttribute("userReview", r); // if it has a user review
					}
				}
			}
			session.setAttribute("review", bookReviews); // all reviews in a list
	
		session.setAttribute("book", book);

		return "book/book";
	}
	

	private String getBookByYear(int bookSearchYear, HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookByYear(bookSearchYear);
		List<Review> bookReviews = new ArrayList<>();
		
		for (Book b : book) {
			bookReviews.addAll(reviewDao.getReviewByBook(b));
		}

		User user = ((User)session.getAttribute("user"));  
		for (Book b : book) { 
			for (Review r : reviewDao.getReviewByUser(user)) { 
				if (r.getBook().equals(b)) { 
					session.setAttribute("userReview", r); // if it has a user review
				}
			}
		}
		session.setAttribute("review", bookReviews); // all reviews in a list

		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByTitle(String bookSearchName, HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookByTitle(bookSearchName);
		List<Review> bookReviews = new ArrayList<>();
		
		for (Book b : book) {
			bookReviews.addAll(reviewDao.getReviewByBook(b));
		}

		User user = ((User)session.getAttribute("user"));  
		for (Book b : book) { 
			for (Review r : reviewDao.getReviewByUser(user)) { 
				if (r.getBook().equals(b)) { 
					session.setAttribute("userReview", r); // if it has a user review
				}
			}
		}
		session.setAttribute("review", bookReviews); // all reviews in a list

		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByKeyWord(String bookSearchKeyWord, HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookByKeyWord(bookSearchKeyWord);
		List<Review> bookReviews = new ArrayList<>();
		
		for (Book b : book) {
			bookReviews.addAll(reviewDao.getReviewByBook(b));
		}

		User user = ((User)session.getAttribute("user"));  
		for (Book b : book) { 
			for (Review r : reviewDao.getReviewByUser(user)) { 
				if (r.getBook().equals(b)) { 
					session.setAttribute("userReview", r); // if it has a user review
				}
			}
		}
		session.setAttribute("review", bookReviews); // all reviews in a list

		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByAuthor(String bookSearchAuthorName, HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookByAuthorLastName(bookSearchAuthorName);
		List<Review> bookReviews = new ArrayList<>();
		
		for (Book b : book) {
			bookReviews.addAll(reviewDao.getReviewByBook(b));
		}

		User user = ((User)session.getAttribute("user"));  
		for (Book b : book) { 
			for (Review r : reviewDao.getReviewByUser(user)) { 
				if (r.getBook().equals(b)) { 
					session.setAttribute("userReview", r); // if it has a user review
				}
			}
		}
		session.setAttribute("review", bookReviews); // all reviews in a list

		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByGenre(String bookSearchGenre, HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.findBookByGenre(bookSearchGenre);
		List<Review> bookReviews = new ArrayList<>();
		
		for (Book b : book) {
			bookReviews.addAll(reviewDao.getReviewByBook(b));
		}

		User user = ((User)session.getAttribute("user"));  
		for (Book b : book) { 
			for (Review r : reviewDao.getReviewByUser(user)) { 
				if (r.getBook().equals(b)) { 
					session.setAttribute("userReview", r); // if it has a user review
				}
			}
		}
		session.setAttribute("review", bookReviews); // all reviews in a list

		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getAllBooks(HttpSession session) {
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		List<Book> book = bookDao.getAllBooks();
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="newBookReview.do") 
	public String userNewBookReview(String isbnVal, String review, int rating, HttpSession session) {	
		session.removeAttribute("book");
		session.removeAttribute("review");
		session.removeAttribute("userReview");

		Book book = bookDao.findBookById(isbnVal).get(0);
		Review r = new Review();
		r.setReview(review);
		r.setRating(rating);
		r.setBook(book);
		r.setUser(((User)session.getAttribute("user")));
		reviewDao.createReview(r);
		return "book/book";
	}
	@RequestMapping(path="updateExistingBookReview.do") 
	public String userUpdateOldReview(String isbnVal, int reviewId, String review, int rating, HttpSession session) {	

		session.removeAttribute("book");
		session.removeAttribute("review");

		Book book = bookDao.findBookById(isbnVal).get(0);

		Review oldReview = reviewDao.getReviewById(reviewId);
		Review newReview = new Review();
		newReview.setReview(review);
		newReview.setRating(rating);
		newReview.setBook(book);
		newReview.setUser(((User)session.getAttribute("user")));
		reviewDao.updateReview(oldReview,newReview);

		session.removeAttribute("userReview");
		return "book/book";
	}

}
