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
		return "book";
	}
	
	@RequestMapping(path="showBook.do", params="bookSearch", method = RequestMethod.GET)
	public String getBookByISBN(String bookSearch, HttpSession session) {
		List<Book> book = bookDao.findBookById(bookSearch);
		session.setAttribute("book", book);
		return "book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchYear", method = RequestMethod.GET)
	public String getBookByYear(int bookSearchYear, HttpSession session) {
		List<Book> book = bookDao.findBookByYear(bookSearchYear);
		session.setAttribute("book", book);
		return "book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchName", method = RequestMethod.GET)
	public String getBookByName(String bookSearchName, HttpSession session) {
		List<Book> book = bookDao.findBookByTitle(bookSearchName);
		session.setAttribute("book", book);
		return "book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchKeyWord", method = RequestMethod.GET)
	public String getBookByKeyWord(String bookSearchKeyWord, HttpSession session) {
		List<Book> book = bookDao.findBookByKeyWord(bookSearchKeyWord);
		session.setAttribute("book", book);
		return "book";
	}
	@RequestMapping(path="showBook.do", params="bookSearchAuthorName", method = RequestMethod.GET)
	public String getBookByAuthor(String bookSearchAuthorName, HttpSession session) {
		List<Book> book = bookDao.findBookByAuthorLastName(bookSearchAuthorName);
		session.setAttribute("book", book);
		return "book";
	}

}
