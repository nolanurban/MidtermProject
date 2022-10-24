package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookClubDAO;

import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private BookClubDAO bcDao;

	
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
	
	@RequestMapping(path="account.do")
	public String showAccount(HttpSession session) {
		User user = ((User) (session.getAttribute("user")));
		user.setBookClubs(bcDao.getBookClubsByUserId(user));
		
		session.setAttribute("user", user);
		return "userProfile";
	}
	
	@RequestMapping(path="logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
}

