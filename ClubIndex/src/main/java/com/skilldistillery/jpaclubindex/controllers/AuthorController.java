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
		return "author/author";
	}

	@RequestMapping(path="getAuthor.do", params = {"authorSearch", "searchType" })
	public String switchSearchMethods(String authorSearch, int searchType, HttpSession session) {
		switch (searchType) {
		case 1: // find author by actual id #
			return getAuthorById(Integer.parseInt(authorSearch), session);
		case 2: //find author by isbn
			return getAuthorByIsbn(authorSearch, session);
		case 3: // find author by last name
			return getAuthorByLastNameSearch(authorSearch, session);
		case 4: // find author by genre
			return getAuthorByGenre(authorSearch, session);
		default:
			return "author/author";
		}
	}

	private String getAuthorById(int id, HttpSession session) {
		List<Author> author = authorDao.findAuthorById(id); 
		session.setAttribute("author", author);
		return "author/author";
	}

	private String getAuthorByIsbn(String isbn, HttpSession session) {
		List<Author> author = authorDao.findAuthorByIsbn(isbn); 
		session.setAttribute("author", author);
		return "author/author";
	}
	
	private String getAuthorByLastNameSearch(String authorName, HttpSession session) {
		List<Author> author = authorDao.findAuthorByLastName(authorName);
		session.setAttribute("author", author);
		return "author/author";
	}
	
	private String getAuthorByGenre(String authorGenre, HttpSession session) {
		List<Author> author = authorDao.findAuthorByGenre(authorGenre);
		session.setAttribute("author", author);
		return "author/author";
	}

	
}
