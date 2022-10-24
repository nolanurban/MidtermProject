package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.userRLDAO;


@Service
public class UserRLController {
	
	@Autowired
	private userRLDAO userRlDao;
	
	@RequestMapping(path="showUserRL.do")
	public String showUserReadingList(HttpSession session) {
		return "userReadingList";
	}

}