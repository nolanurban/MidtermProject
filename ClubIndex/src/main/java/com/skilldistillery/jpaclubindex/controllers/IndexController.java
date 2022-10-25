package com.skilldistillery.jpaclubindex.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.ReviewDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.Book;

@Controller
public class IndexController {

	@Autowired
	ReviewDAO reviewDao;
	@Autowired
	BookDAO bookDao;
	
	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session) {
//		List<Book> allBooks = bookDao.getAllBooks();
//		int randNum = (int)(Math.random() * allBooks.size());
//		session.setAttribute("randBook", allBooks.get(randNum));
		session.setAttribute("reviews", reviewDao.getAllReviews());
		return "home";
	}

}
