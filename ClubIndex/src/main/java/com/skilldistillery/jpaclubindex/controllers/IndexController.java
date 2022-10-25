package com.skilldistillery.jpaclubindex.controllers;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.lang.model.util.AbstractAnnotationValueVisitor14;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.ReviewDAO;
import com.skilldistillery.jpaclubindex.data.UserDAO;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Review;

@Controller
public class IndexController {

	@Autowired
	ReviewDAO reviewDao;
	@Autowired
	BookDAO bookDao;
	
	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session) {
		List<Book> allBooks = bookDao.getAllBooks();
		List<Review> allReviews = reviewDao.getAllReviews();
		
		allReviews.sort((r1, r2) -> {
			if(r1.getId() > r2.getId()) {
				return -1;
			} else if(r1.getId() < r2.getId()) {
				return 1;
			} else {
				return 0;
			}
		});
		
		List<Review> recentReviews = new ArrayList<>();
		for(int i = 0; i < 5; i++) {
			recentReviews.add(allReviews.get(i));
		}
		
		int randNum = (int)(Math.random() * allBooks.size());
		session.setAttribute("book", allBooks.get(randNum));
		session.setAttribute("reviews", recentReviews);
		return "home";
	}

}
