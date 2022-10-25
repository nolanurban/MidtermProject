package com.skilldistillery.jpaclubindex.controllers;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;

public class CustomErrorController implements ErrorController{

	@RequestMapping(path="/error")
	public String handleError() {
		return "error";
	}
}
