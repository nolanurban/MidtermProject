package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;




@Service
public class UserRLController {
	
//	@Autowired
//	private UserRLDAO userRlDao;
	
	
	@RequestMapping(path="showUserRL.do")
	public String showUserReadingList(HttpSession session) {
		return "userReadingList";
	}
	
	

}
