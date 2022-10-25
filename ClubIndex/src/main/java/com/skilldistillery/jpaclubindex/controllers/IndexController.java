package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.ReviewDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;

@Controller
public class IndexController {

	@Autowired
	ReviewDAO reviewDao;
	
	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session) {
		session.setAttribute("reviews", reviewDao.getAllReviews());
		return "home";
	}

}
