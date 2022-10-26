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

// these are now redundant, will hold off on deletion until code review.
	@RequestMapping(path="getAuthor.do", params = "id")
	public String getAuthorById(int id, HttpSession session) {
		List<Author> author = authorDao.findAuthorById(id); 
		session.setAttribute("author", author);
		return "author/author";
	}
	@RequestMapping(path="getAuthor.do", params = "isbn")
	public String getAuthorByIsbn(String isbn, HttpSession session) {
		List<Author> author = authorDao.findAuthorByIsbn(isbn); 
		session.setAttribute("author", author);
		return "author/author";
	}
	
	@RequestMapping(path="getAuthor.do", params = "authorName") 
	public String getAuthorByLastNameSearch(String authorName, HttpSession session) {
		List<Author> author = authorDao.findAuthorByLastName(authorName);
		session.setAttribute("author", author);
		return "author/author";
	}
	
	@RequestMapping(path="getAuthor.do", params = "authorGenre") 
	public String getAuthorByGenre(String authorGenre, HttpSession session) {
		List<Author> author = authorDao.findAuthorByGenre(authorGenre);
		session.setAttribute("author", author);
		return "author/author";
	}

	@RequestMapping(path="getAuthor.do", params = {"authorSearch", "searchType" })
	public String switchSearchMethods(String authorSearch, int searchType, HttpSession session) {
		switch (searchType) {
			case 1: // find author by actual id #
				List<Author> author1 = authorDao.findAuthorById(Integer.parseInt(authorSearch)); 
				session.setAttribute("author", author1);
				return "author/author";
			case 2: //find author by isbn
				try {
				List<Author> author2 = authorDao.findAuthorByIsbn(authorSearch); 
				session.setAttribute("author", author2);
				return "author/author";
				} catch (NullPointerException e) { return "author"; }
			case 3: // find author by last name
				List<Author> author3 = authorDao.findAuthorByLastName(authorSearch);
				session.setAttribute("author", author3);
				return "author/author";
			case 4: // find author by genre
				List<Author> author4 = authorDao.findAuthorByGenre(authorSearch);
				session.setAttribute("author", author4);
				return "author/author";
			default:
				return "author/author";
		}
	}
	
}
