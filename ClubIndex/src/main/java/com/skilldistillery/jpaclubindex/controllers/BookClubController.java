package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.BookClubDAO;

@Controller
public class BookClubController {

	@Autowired
	BookClubDAO bcDao;
	
	@RequestMapping(path="showBookClub.do")
	public String showBookClub(HttpSession session, int id) {
		session.setAttribute("bookClub", bcDao.getBookClubById(id));
		return "bookClub";
	}
}
