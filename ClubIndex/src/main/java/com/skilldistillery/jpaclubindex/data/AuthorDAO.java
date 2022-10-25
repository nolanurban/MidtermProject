package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Author;

public interface AuthorDAO {

	/* Given an id int, author look up will return
	 * an author obj.
	 * 
	 */
	List<Author> findAuthorById(int id);
	List<Author> findAuthorByIsbn(String isbn);
	List<Author> findAuthorByLastName(String lastName);
	List<Author> findAuthorByGenre(String genre);
	
}
