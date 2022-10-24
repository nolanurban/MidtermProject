package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.AuthorDAO;
import com.skilldistillery.jpaclubindex.entities.Author;

@Controller
public class AuthorController {

	@Autowired
	private AuthorDAO authorDao;
	
	@RequestMapping(path="getAuthor.do", params = "id")
	public String getAuthorById(int id, HttpSession session) {
		Author author = authorDao.findAuthorById(id); 
		session.setAttribute("author", author);
		return "author";
	}

}
