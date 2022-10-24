package com.skilldistillery.jpaclubindex.controllers;

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
	public String showBookDetails(String bookSearch, HttpSession session) {
		if (bookSearch == null) return "book";
		Book book = bookDao.findBookById(bookSearch);
		session.setAttribute("book", book);
		return "book";
	}
}
