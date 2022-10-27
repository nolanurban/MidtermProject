package com.skilldistillery.jpaclubindex.controllers;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.skilldistillery.jpaclubindex.data.BookDAO;
import com.skilldistillery.jpaclubindex.data.ReviewDAO;
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
		List<Book> highlyRatedBooks = bookDao.getBestRatedBooks();
		List<Book> randomTop3Books = new ArrayList<>();
		
		
		allReviews.sort((r1, r2) -> {
			if(r1.getId() > r2.getId()) {
				return -1;
			} else if(r1.getId() < r2.getId()) {
				return 1;
			} else {
				return 0;
			}
		});
		 
		if (highlyRatedBooks.size() <= 3) { 
			randomTop3Books.addAll(highlyRatedBooks);
		}
		else {
			for (int i = 0; i < 3 ; i++) {
				randomTop3Books.add(i, highlyRatedBooks.get((int)(Math.random() * highlyRatedBooks.size())));
			}
		}
		
		
		List<Review> recentReviews = new ArrayList<>();
		for(int i = 0; i < 5; i++) {
			recentReviews.add(allReviews.get(i));
		}
		
		int randNum = (int)(Math.random() * allBooks.size());
		session.setAttribute("book", allBooks.get(randNum));
		session.setAttribute("reviews", recentReviews);
		session.setAttribute("toprated", randomTop3Books);
		return "home";
	}

}
