package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	@Autowired BookDAO bookDao;
	
	@RequestMapping(path= {"/", "home.do"})
	public String home(HttpSession session) {
		session.setAttribute("SMOKETEST", userDao.findUserById(1));
		return "home";
	}
	
	@RequestMapping(path="login.do")
	public String gotoLoginAccount(HttpSession session){
		return "login";
	}
	
	@RequestMapping(path="login.do", method = RequestMethod.POST)
	public String loginAccount (HttpSession session, String username, String password) {
		User user = userDao.loginUserAndPassword(username, password);
		if (user != null) {
			session.setAttribute("user", user);
			return "home";
		}
		return "login";		
	}
	@RequestMapping(path="book.do", method = RequestMethod.GET)
	public String checkBook (HttpSession session) {
		Book book = bookDao.findBookById("0312932081");
		session.setAttribute("book", book);
		return "book";
	}
}

