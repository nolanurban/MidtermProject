package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.skilldistillery.jpaclubindex.data.BookClubDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.Location;
import com.skilldistillery.jpaclubindex.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private BookClubDAO bcDao;

	@RequestMapping(path = "login.do")
	public String gotoLoginAccount(HttpSession session) {
		return "user/login";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String loginAccount(HttpSession session, String username, String password) {
		User user = userDao.loginUserAndPassword(username, password);
		if (user != null) {
			session.setAttribute("user", user);
			return "home";
		}
		return "user/login";
	}

	@RequestMapping(path = "account.do")
	public String showAccount(HttpSession session) {
		User user = ((User) (session.getAttribute("user")));
		user.setBookClubs(bcDao.getBookClubsByUser(user));

		session.setAttribute("user", user);
		return "user/userProfile";
	}

	@RequestMapping(path = "logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}

	@RequestMapping(path = "userCreation.do", method = RequestMethod.GET)
	public String createForm(HttpSession session) {
		return "user/userCreation";
	}

	@RequestMapping(path = "userCreation.do", method = RequestMethod.POST)
	public String createAccount(HttpSession session, User newUser, Location location) {
		newUser.setLocation(location);
		newUser = userDao.create(newUser);
		session.setAttribute("user", newUser);
		return "redirect:home.do";
	}
	@RequestMapping(path = "createdUser.do")
	public String userCreated(HttpSession session) {
		return "home";
	}

	@RequestMapping(path = "updateUser.do", method = RequestMethod.GET)
	public String createFormToUpdate(HttpSession session) {
		return "user/updateUser";
	}

	@RequestMapping(path = "updateUser.do", method = RequestMethod.POST)
	public String update(HttpSession session, User currentUser, Location location) {
		currentUser.setLocation(location);
		currentUser = userDao.update(currentUser);
		session.setAttribute("user", currentUser);
		return "redirect:updatedUser.do";
	}

	@RequestMapping(path = "updatedUser.do")
	public String updated(HttpSession session) {
		return "redirect:home.do";
	}


	@RequestMapping(path = "deleteUser.do", method = RequestMethod.GET)
	public String deleteUserConfirmation(HttpSession session) {
		return "user/deleteUser";
	}

	@RequestMapping(path = "deleteUserConfirmation.do")
	public String delete(HttpSession session) {
		User user = (User)(session.getAttribute("user"));
		boolean successful = userDao.removeUser(user.getId());
		if (successful) {
		return "redirect:deleteUserHome.do";
		}
		else {
			return "user/userProfile";
		}
	}

	@RequestMapping(path = "deleteUserHome.do")
	public String userDeleted(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}
}
