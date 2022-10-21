package com.skilldistillery.jpaclubindex.data;

import com.skilldistillery.jpaclubindex.entities.Book;


public interface BookDAO {

	Book findBookById(String isbn);
	
}
