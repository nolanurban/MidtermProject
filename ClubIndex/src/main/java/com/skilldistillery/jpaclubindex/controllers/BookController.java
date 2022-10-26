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
	
	@RequestMapping(path="showBook.do", params="bookSearch", method = RequestMethod.GET)
	public String getBookByISBN(String bookSearch, HttpSession session) {
		List<Book> book = bookDao.findBookById(bookSearch);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchYear", method = RequestMethod.GET)
	public String getBookByYear(int bookSearchYear, HttpSession session) {
		List<Book> book = bookDao.findBookByYear(bookSearchYear);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchName", method = RequestMethod.GET)
	public String getBookByName(String bookSearchName, HttpSession session) {
		List<Book> book = bookDao.findBookByTitle(bookSearchName);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchKeyWord", method = RequestMethod.GET)
	public String getBookByKeyWord(String bookSearchKeyWord, HttpSession session) {
		List<Book> book = bookDao.findBookByKeyWord(bookSearchKeyWord);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchAuthorName", method = RequestMethod.GET)
	public String getBookByAuthor(String bookSearchAuthorName, HttpSession session) {
		List<Book> book = bookDao.findBookByAuthorLastName(bookSearchAuthorName);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchGenre", method = RequestMethod.GET)
	public String getBookByGenre(String bookSearchGenre, HttpSession session) {
		List<Book> book = bookDao.findBookByGenre(bookSearchGenre);
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params="getAllBooks", method = RequestMethod.GET)
	public String getAllBooks(HttpSession session) {
		List<Book> book = bookDao.getAllBooks();
		session.setAttribute("book", book);
		return "book/book";
	}
	@RequestMapping(path="showBook.do", params={ "bookSearchAll", "bsearchType" })
	public String searchForBook(String bookSearchAll, int bsearchType, HttpSession session) {
		switch (bsearchType) {
			case 1:
				List<Book> book1 = bookDao.findBookById(bookSearchAll);
				session.setAttribute("book", book1);
				return "book/book";
			case 2:
				List<Book> book2 = bookDao.findBookByAuthorLastName(bookSearchAll);
				session.setAttribute("book", book2);
				return "book/book";
			case 3:
				List<Book> book3 = bookDao.findBookByGenre(bookSearchAll);
				session.setAttribute("book", book3);
				return "book/book";
			case 4:
				List<Book> book4 = bookDao.findBookByKeyWord(bookSearchAll);
				session.setAttribute("book", book4);
				return "book/book";
			case 5:
				List<Book> book5 = bookDao.findBookByYear(Integer.parseInt(bookSearchAll));
				session.setAttribute("book", book5);
				return "book/book";
			case 6:
				List<Book> book6 = bookDao.findBookByTitle(bookSearchAll);
				session.setAttribute("book", book6);
				return "book/book";
			case 7:
				List<Book> book7 = bookDao.getAllBooks();
				session.setAttribute("book", book7);
				return "book/book";
			default:
				return "book/book";
		}
	}

}
