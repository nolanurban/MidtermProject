package com.skilldistillery.jpaclubindex.controllers;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BookClubDAO;
import com.skilldistillery.jpaclubindex.data.GenreDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Location;
import com.skilldistillery.jpaclubindex.entities.User;

@Controller
public class BookClubController {

	@Autowired
	BookClubDAO bcDao;
	@Autowired
	GenreDAO genreDao;
	@Autowired
	UserDAO userDao;
	
	@RequestMapping(path="bookClubSearch.do")
	public String bookClubSearchPage(HttpSession session) {
		session.setAttribute("bookClubs", bcDao.getAllBookClubs());
		return "bookclub/bookClubSearch";
	}

	@RequestMapping(path="getBookClub.do", params = {"bookSearch", "searchType" })
	public String switchSearchMethods(String bookSearch, int searchType, HttpSession session) {
		switch (searchType) {
			case 1: // find book club by id #
				return showBookClub(session, Integer.parseInt(bookSearch));
			case 2: //find book club
				return getBookClubsByOwner(session, bookSearch);
			case 3: // find book club by genre
				return bookClubByGenre(session, bookSearch);
	//		case 4: // find book club by location
	//			return getBookClubsByLocation(session, bookSearch);
			default:
				return bookClubSearchPage(session);
		}
	}
	
	
	@RequestMapping(path="bookClubsByDigitalAvailability.do")
	public String bookClubSearchByDigital(HttpSession session) {
		List<BookClub> bookClubs = bcDao.getBookClubsByDigital(true);
		session.setAttribute("bookClubs", bookClubs);
		return "bookclub/bookClubLists";
	}
	
	
	@RequestMapping(path="updateBookClub.do")
	public String updateBookClub(HttpSession session) {
		session.setAttribute("genres", genreDao.getAllGenres());
		return "bookclub/updateBookClub";
	}
	
	@RequestMapping(path="updateBookClub.do", method = RequestMethod.POST)
	public String updateBookClubSubmit(HttpSession session, BookClub newBookClub, int[] genreIds, Location location) {
		BookClub oldBookClub = (BookClub) (session.getAttribute("bookClub"));
		
		List<Genre> newGenres = new ArrayList<>(); 
		for(int i : genreIds) {
			newGenres.add(genreDao.getGenreById(i));
		}
		newBookClub.setGenres(newGenres);
		newBookClub.setLocation(location);
		
		session.setAttribute("bookClub", bcDao.updateBookClub(oldBookClub, newBookClub));
		
		return "redirect:updatedBookClub.do";
	}
	
	@RequestMapping(path="updatedBookClub.do")
	public String updatedBookClub(HttpSession session) {
		return "bookclub/bookClub";
	}
	
	@RequestMapping(path="createBookClub.do")
	public String createBookClubForm(HttpSession session) {
		session.setAttribute("genres", genreDao.getAllGenres());
		return "bookclub/createBookClub";
	}
	
	@RequestMapping(path="createBookClub.do", method = RequestMethod.POST)
	public String createBookClub(HttpSession session, BookClub bc, int ownerId, int[] genreIds, Location location) {
		List<Genre> newGenres = new ArrayList<>(); 
		for(int i : genreIds) {
			newGenres.add(genreDao.getGenreById(i));
		}
		bc.setGenres(newGenres);
		bc.setOwner(userDao.findUserById(ownerId));
		bc.setLocation(location);
		bc.setCreateDate(LocalDateTime.now());
		bc.addUser(userDao.findUserById(ownerId));
		
		session.setAttribute("bookClub", bcDao.createBookClub(bc));
		return "redirect:createdBookClub.do";
	}
	
	@RequestMapping(path="createdBookClub.do")
	public String createdBookClub(HttpSession session) {
		return "bookclub/bookClub";
	}
	
	@RequestMapping(path="removeUsers.do")
	public String removeUsersRedirect(HttpSession session) {
		return "bookclub/bookClubMembers";
	}
	
	@RequestMapping(path="removeUsers.do", method = RequestMethod.POST)
	public String removeUsers(HttpSession session, int[] userIds) {
		BookClub bc = (BookClub)(session.getAttribute("bookClub"));
		
		for(int i : userIds) {
			bcDao.removeUserFromBookClub(bc, userDao.findUserById(i));
		}
		session.setAttribute("bookClub", bcDao.getBookClubById(bc.getId()));
		return "redirect:removedUsers.do";
	}
	
	@RequestMapping(path="removedUsers.do")
	public String removedUsers(HttpSession session) {
		return "bookclub/bookClub";
	}
	
	@RequestMapping(path="addUser.do", method = RequestMethod.POST)
	public String addUser(HttpSession session, String username) {
		User addUser = userDao.findUserByUsername(username);
		BookClub bc = (BookClub)(session.getAttribute("bookClub"));
		if(addUser != null) {
			bc = bcDao.addUserToBookClub(bc, addUser);
			session.setAttribute("bookClub", bc);
		}
		return "redirect:addedUser.do";
	}
	
	@RequestMapping(path="addedUser.do")
	public String addedUser(HttpSession session) {
		return "bookclub/bookClub";
	}

	@RequestMapping(path="showBookClub.do")
	public String showBookClub(HttpSession session, int id) {
		session.setAttribute("bookClub", bcDao.getBookClubById(id));
		return "bookclub/bookClub";
	}
	
	
//	private String getBookClubsByLocation(HttpSession session, Location location) {
//		List<BookClub> bookClubs = bcDao.getBookClubsByLocation(location);
//		session.setAttribute("bookClubs", bookClubs);
//		return "bookclub/bookClubLists";
//	}
	
	private String bookClubByGenre(HttpSession session, String genreName) {
		Genre genre = genreDao.getGenreByName(genreName);
		session.setAttribute("bookClubs", bcDao.getBookClubsByGenre(genre));
		return "bookclub/bookClubLists";
	}
	
	private String getBookClubsByOwner(HttpSession session, String ownerName) {
		User owner = userDao.findUserByUsername(ownerName);
		session.setAttribute("bookClubs", bcDao.getBookClubsByOwner(owner));
		return "bookclub/bookClubLists";
	}
}
