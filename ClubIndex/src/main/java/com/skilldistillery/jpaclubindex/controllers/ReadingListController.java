package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;
import java.util.function.IntPredicate;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.jpaclubindex.data.BCRLDAO;
import com.skilldistillery.jpaclubindex.data.BookClubDAO;
import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.data.UserRLDAO;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.BookClubReadingList;
import com.skilldistillery.jpaclubindex.entities.User;
import com.skilldistillery.jpaclubindex.entities.UserReadingList;

@Controller
public class ReadingListController {

	@Autowired
	private BCRLDAO bcrlDao;
	@Autowired
	private BookDAO bookDao;
	@Autowired
	private BookClubDAO bcDao;
	@Autowired
	private UserRLDAO userRLDao;
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path="showBCRL.do")
	public String showReadingList(HttpSession session) {
		return "";
	}
	
	
	@RequestMapping(path="showUserRL.do")
	public String showUserReadingList(HttpSession session) {
		List<UserReadingList> userRlists = userRLDao.findlistofAllUserReadingList();
		session.setAttribute("readingLists", userRlists);
		return "readinglist/readingList";
	}	
	
	@RequestMapping(path="showSingleUserRL.do")
	public String showSingleReadingList(HttpSession session, int id) {
		session.setAttribute("readingList", userRLDao.findReadingListByID(id));
		return "readinglist/singleReadingList";
	}

	@RequestMapping(path="showSingleRL.do")
	public String showSingleBCRL(HttpSession session, int id) {
		session.setAttribute("readingList", bcrlDao.getBCRLById(id));
		return "readinglist/singleReadingList";
	}
	
	@RequestMapping(path="createReadingList.do")
	public String createReadingList(HttpSession session) {
		return "readinglist/readingListCreation";
	}
	
	@RequestMapping(path="createReadingList.do", params = "bookClubId", method=RequestMethod.POST)
	public String createBCRL(HttpSession session, BookClubReadingList bcrl, String firstBook, int bookClubId) {
		bcrl.addBook(bookDao.findBookByTitle(firstBook).get(0));
		bcrl.setBookClub(bcDao.getBookClubById(bookClubId));
		
		bcrl = bcrlDao.createBCRL(bcrl);
		
		session.setAttribute("bookClub", bcDao.getBookClubById(bookClubId));
		return "redirect:createdBCRL.do";
	}
	
	@RequestMapping(path="createdBCRL.do")
	public String createdBCRL(HttpSession session) {
		return "bookclub/bookClub";
	}
	
	@RequestMapping(path="createReadingList.do", params = "userId", method=RequestMethod.POST)
	public String createUserRL(HttpSession session, UserReadingList uRL, String firstBook, int userId) {
		uRL.addBook(bookDao.findBookByTitle(firstBook).get(0));
		uRL.setUser(userDao.findUserById(userId));
		
		uRL = userRLDao.createUserRL(uRL);
		
		User user = userDao.findUserById(userId);
		user.setBookClubs(bcDao.getBookClubsByUser(user));
		
		session.setAttribute("user", user);
		
		return "redirect:createdURL.do";
	}
	
	@RequestMapping(path="createdURL.do")
	public String createdURL(HttpSession session) {
		return "user/userProfile";
	}
	
	@RequestMapping(path="updateRL.do")
	public String updateRL(HttpSession session) {
		return "readinglist/updateReadingList";
	}
	
	@RequestMapping(path="updateReadingList.do", params = "bcrlId", method = RequestMethod.POST)
	public String updateReadingList(HttpSession session, String name, String[] isbns, int bcrlId) {
		BookClubReadingList bcrl = bcrlDao.updateBCRLName(bcrlDao.getBCRLById(bcrlId), name);
		
		if(isbns != null) {
			for(String s : isbns) {
				Book book = bookDao.findBookById(s).get(0);
				System.out.println(book.getTitle());
				bcrlDao.removeBookFromBCRL(book, bcrl);
			}
		}
		session.setAttribute("readingList", bcrlDao.getBCRLById(bcrlId));
		session.setAttribute("bookClub", bcDao.getBookClubById(bcrl.getBookClub().getId()));
		return "redirect:updatedReadingList.do";
	}
	
	@RequestMapping(path="updateReadingList.do", params = "userRLId", method = RequestMethod.POST)
	public String updateReadingList(HttpSession session, UserReadingList url, String[] isbns, int userRLId) {
		
		url = userRLDao.updateUserRL(userRLDao.findReadingListByID(userRLId), url);
		
		if(isbns != null) {
			for(String s : isbns) {
				userRLDao.removeBookFromUserRL(bookDao.findBookById(s).get(0), url);
			}
		}
		
		session.setAttribute("readingList", userRLDao.findReadingListByID(userRLId));
		return "redirect:updatedReadingList.do";
	}
	
	@RequestMapping(path="updatedReadingList.do")
	public String updatedReadingList(HttpSession session) {
		return "readinglist/singleReadingList";
	}
	
	@RequestMapping(path="deleteRL.do", params="bcrlId")
	public String deleteBCRL(HttpSession session, int bcrlId) {
		BookClubReadingList bcrl = bcrlDao.getBCRLById(bcrlId);
		boolean successful = bcrlDao.deleteBCRL(bcrl);
		
		if(successful) {
			session.removeAttribute("readingList");
			session.setAttribute("bookClub", bcDao.getBookClubById(bcrl.getBookClub().getId()));
			return "redirect:deletedBCRL.do";
		} else {
			return "readinglist/singleReadingList";
		}
	}
	
	@RequestMapping(path="deletedBCRL.do")
	public String deletedBCRL(HttpSession session) {
		return "bookclub/bookClub";
	}
	
	@RequestMapping(path = "deleteRL.do", params="urlId")
	public String deleteURL(HttpSession session, int urlId) {
		UserReadingList url = userRLDao.findReadingListByID(urlId);
		boolean successful = userRLDao.deleteUserRL(url);
		
		if(successful) {
			session.removeAttribute("readingList");
			session.setAttribute("user", userDao.findUserById(url.getUser().getId()));
			
			return "redirect:deletedURL.do";
		} else {
			return "readinglist/singleReadingList";
		}
	}
	
	@RequestMapping(path="deletedURL.do")
	public String deletedURL(HttpSession session) {
		return "user/userProfile";
	}
	
	@RequestMapping(path="addBookToRL.do", params = "bcrlId", method=RequestMethod.POST)
	public String addBookToBCRL(HttpSession session, int bcrlId, String bookTitle) {
		BookClubReadingList bcrl = bcrlDao.getBCRLById(bcrlId);
		Book toAdd = bookDao.findBookByTitle(bookTitle).get(0);
		bcrlDao.addBookToBCRL(toAdd, bcrl);
		
		session.setAttribute("readingList", bcrlDao.getBCRLById(bcrlId));
		session.setAttribute("bookClub",  bcDao.getBookClubById(bcrl.getBookClub().getId()));
		
		return "redirect:addedBookToBCRL.do";
	}
	
	@RequestMapping(path="addedBookToBCRL.do")
	public String addedBookToBCRL(HttpSession session) {
		return "readinglist/singleReadingList";
	}
}
