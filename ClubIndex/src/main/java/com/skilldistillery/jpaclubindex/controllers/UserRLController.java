package com.skilldistillery.jpaclubindex.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.UserRLDAO;
import com.skilldistillery.jpaclubindex.entities.UserReadingList;




@Service
public class UserRLController {
	
	@Autowired
	private UserRLDAO userRLDao;
	
	
	@RequestMapping(path="showUserRL.do")
	public String showUserReadingList(HttpSession session) {
	List<UserReadingList> userRlists = userRLDao.findlistofAllUserReadingList();
		return "userReadingList";
	}
	
	@RequestMapping(path="userReadingList.do")
	public String userReadingListSearchOptions(HttpSession session) {
		return "userReadingList";
	}
	
	

}
