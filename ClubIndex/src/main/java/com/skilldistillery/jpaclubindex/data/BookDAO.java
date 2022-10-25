package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Book;


public interface BookDAO {

	List<Book> findBookById(String isbn);
	List<Book> findBookByKeyWord(String keyWord);
	List<Book> findBookByYear(int year);
	List<Book> findBookByTitle(String title);
	List<Book> findBookByAuthorLastName(String lastName);
}
