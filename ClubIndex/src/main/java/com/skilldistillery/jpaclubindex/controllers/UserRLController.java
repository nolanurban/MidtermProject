package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.skilldistillery.jpaclubindex.data.UserRLDAO;
import com.skilldistillery.jpaclubindex.entities.UserReadingList;

@Controller
public class UserRLController {
	
	@Autowired
	private UserRLDAO userRLDao;
	
	
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
}