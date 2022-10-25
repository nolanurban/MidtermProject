package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;

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
	
	@RequestMapping(path="getAuthor.do")
	public String searchForBook(HttpSession session) {
		session.removeAttribute("author");
		return "author";
	}


	@RequestMapping(path="getAuthor.do", params = "id")
	public String getAuthorById(int id, HttpSession session) {
		List<Author> author = authorDao.findAuthorById(id); 
		session.setAttribute("author", author);
		return "author";
	}
	@RequestMapping(path="getAuthor.do", params = "isbn")
	public String getAuthorByIsbn(String isbn, HttpSession session) {
		List<Author> author = authorDao.findAuthorByIsbn(isbn); 
		session.setAttribute("author", author);
		return "author";
	}
	
	@RequestMapping(path="getAuthor.do", params = "authorName") 
	public String getAuthorByLastNameSearch(String authorName, HttpSession session) {
		List<Author> author = authorDao.findAuthorByLastName(authorName);
		session.setAttribute("author", author);
		return "author";
	}
	
	@RequestMapping(path="getAuthor.do", params = "authorGenre") 
	public String getAuthorByGenre(String authorGenre, HttpSession session) {
		List<Author> author = authorDao.findAuthorByGenre(authorGenre);
		session.setAttribute("author", author);
		return "author";
	}

}