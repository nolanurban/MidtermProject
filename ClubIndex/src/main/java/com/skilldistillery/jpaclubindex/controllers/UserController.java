package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model) {
		model.addAttribute("SMOKETEST", userDao.findUserById(1));
		return "home";
	}
	
	@RequestMapping(path="login.do")
	public String loginAccount (HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			return "home";
		}
		return "login";		
	}
}

