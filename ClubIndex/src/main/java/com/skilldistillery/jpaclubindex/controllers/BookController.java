package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.entities.Book;

@Controller
public class BookController {

	@Autowired
	private BookDAO bookDao;
	
	@RequestMapping(path="showBook.do")
	public String searchForBook(HttpSession session) {
		session.removeAttribute("book");
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
				return getBookByGenre(bookSearchAll, session);
			case 4:
				return getBookByKeyWord(bookSearchAll, session);
			case 5:
				return getBookByYear(Integer.parseInt(bookSearchAll), session);
			case 6:
				return getBookByTitle(bookSearchAll, session);
			case 7:
				return getAllBooks(session);
			default:
				return searchForBook(session);
		}
	}
	
	private String getBookByISBN(String bookSearch, HttpSession session) {
		List<Book> book = bookDao.findBookById(bookSearch);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByYear(int bookSearchYear, HttpSession session) {
		List<Book> book = bookDao.findBookByYear(bookSearchYear);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByTitle(String bookSearchName, HttpSession session) {
		List<Book> book = bookDao.findBookByTitle(bookSearchName);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByKeyWord(String bookSearchKeyWord, HttpSession session) {
		List<Book> book = bookDao.findBookByKeyWord(bookSearchKeyWord);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByAuthor(String bookSearchAuthorName, HttpSession session) {
		List<Book> book = bookDao.findBookByAuthorLastName(bookSearchAuthorName);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getBookByGenre(String bookSearchGenre, HttpSession session) {
		List<Book> book = bookDao.findBookByGenre(bookSearchGenre);
		session.setAttribute("book", book);
		return "book/book";
	}
	
	private String getAllBooks(HttpSession session) {
		List<Book> book = bookDao.getAllBooks();
		session.setAttribute("book", book);
		return "book/book";
	}
}
