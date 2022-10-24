package com.skilldistillery.jpaclubindex.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.BCRLDAO;

@Service
public class BCRLController {

	@Autowired
	private BCRLDAO bcrlDao;
	
	@RequestMapping(path="showBCRL.do")
	public String showReadingList(HttpSession session) {
		return "";
	}
}
