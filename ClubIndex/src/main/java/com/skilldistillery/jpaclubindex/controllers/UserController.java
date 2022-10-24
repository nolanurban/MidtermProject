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
		user.setBookClubs(bcDao.getBookClubsByUser(user));
		
		session.setAttribute("user", user);
		return "userProfile";
	}
	
	@RequestMapping(path="logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
	@RequestMapping(path="userCreation.do", method = RequestMethod.GET) 
	public String createForm(HttpSession session) {
		return"userCreation";
	}
	
	@RequestMapping(path="userCreation.do", method = RequestMethod.POST) 
		public String createAccount(HttpSession session, User newUser) {
		newUser = userDao.create(newUser);
		session.setAttribute("user", newUser);
		return"home";
	}
	
	
	@RequestMapping(path="updateUser.do", method = RequestMethod.GET) 
	public String createFormToUpdate(HttpSession session) {
		return"updateUser";
	}
	
	@RequestMapping(path="updateUser.do", method = RequestMethod.POST)
		public String update(HttpSession session, User currentUser) {
		currentUser = userDao.update(currentUser);
		return "redirect:updatedUser.do";
	}
	
	@RequestMapping(path="updatedUser.do")
	public String updated(HttpSession session) {
		return "home";
	}
	
	@RequestMapping(path="createdUser.do")
	public String userCreated(HttpSession session) {
		return "home";
	}
}

