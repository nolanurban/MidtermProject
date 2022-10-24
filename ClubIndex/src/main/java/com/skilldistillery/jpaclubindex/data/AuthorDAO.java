package com.skilldistillery.jpaclubindex.data;

import com.skilldistillery.jpaclubindex.entities.Author;

public interface AuthorDAO {

	/* Given an id int, author look up will return
	 * an author obj.
	 * 
	 */
	Author findAuthorById(int id);
}
