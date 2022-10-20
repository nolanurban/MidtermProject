package com.skilldistillery.jpaclubindex.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path= {"/", "index.do"})
	public String home(Model model) {
		model.addAttribute("SMOKETEST", userDao.findUserById(1));
		return "home";
	}
}