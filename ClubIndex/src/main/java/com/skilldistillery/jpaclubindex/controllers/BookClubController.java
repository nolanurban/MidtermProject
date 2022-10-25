package com.skilldistillery.jpaclubindex.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookClubDAO;
import com.skilldistillery.jpaclubindex.data.GenreDAO;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Location;

@Controller
public class BookClubController {

	@Autowired
	BookClubDAO bcDao;
	@Autowired
	GenreDAO genreDao;
	
	@RequestMapping(path="showBookClub.do")
	public String showBookClub(HttpSession session, int id) {
		session.setAttribute("bookClub", bcDao.getBookClubById(id));
		return "bookClub";
	}
	
	@RequestMapping(path="bookClubSearch.do")
	public String bookClubSearchPage(HttpSession session) {
		session.setAttribute("bookClubs", bcDao.getAllBookClubs());
		return "bookClubSearch";
	}
	
	@RequestMapping(path="bookClubSearchByLocation.do")
	public String bookClubById(HttpSession session, Location location) {
		List<BookClub> bookClubs = bcDao.getBookClubsByLocation(location);
		session.setAttribute("bookClubs", bookClubs);
		return "bookClubLists";
	}
	
	@RequestMapping(path="bookClubSearchByGenre.do")
	public String bookClubByGenre(HttpSession session, Genre genre) {
		List<BookClub> bookClubs = bcDao.getBookClubsByGenre(genre);
		session.setAttribute("bookClubs", bookClubs);
		return "bookClubLists";
	}
	
	@RequestMapping(path="bookClubsByDigitalAvailability.do")
	public String bookClubSearchByDigital(HttpSession session) {
		List<BookClub> bookClubs = bcDao.getBookClubsByDigital(true);
		session.setAttribute("bookClubs", bookClubs);
		return "bookClubLists";
	}
	
	@RequestMapping(path="updateBookClub.do")
	public String updateBookClub(HttpSession session) {
		session.setAttribute("genres", genreDao.getAllGenres());
		return "updateBookClub";
	}
	
	@RequestMapping(path="updateBookClub.do", method = RequestMethod.POST)
	public String updateBookClubSubmit(HttpSession session, BookClub newBookClub, int[] genreIds) {
		BookClub oldBookClub = (BookClub) (session.getAttribute("bookClub"));
		
		List<Genre> newGenres = new ArrayList<>(); 
		for(int i : genreIds) {
			newGenres.add(genreDao.getGenreById(i));
		}
		newBookClub.setGenres(newGenres);
		
		session.setAttribute("bookClub", bcDao.updateBookClub(oldBookClub, newBookClub));
		
		return "redirect:updatedBookClub.do";
	}
	
	@RequestMapping(path="updatedBookClub.do")
	public String updatedBookClub(HttpSession session) {
		return "bookClub";
	}
}
