package com.skilldistillery.jpaclubindex.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.jpaclubindex.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
}
