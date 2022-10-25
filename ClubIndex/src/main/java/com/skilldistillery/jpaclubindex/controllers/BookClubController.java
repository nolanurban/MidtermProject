package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookClubDAO;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Location;

@Controller
public class BookClubController {

	@Autowired
	BookClubDAO bcDao;
	
	@RequestMapping(path="bookClub.do")
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
	
}
