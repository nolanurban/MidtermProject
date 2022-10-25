package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Author;
import com.skilldistillery.jpaclubindex.entities.Book;

@Service
@Transactional
public class AuthorDaoImpl implements AuthorDAO {

	@PersistenceContext
	private EntityManager em;

	/*
	 * Users should be able to retrieve an author by id.  Primary purpose is quick look up on our side to retrieve Author object
	 * @return is a author object
	 * @params is an integer
	 * @author nolanurban
	 */
	@Override
	public Author findAuthorById(int id) {
		return em.find(Author.class, id);
	}
	
	/*
	 * Users should be able to retrieve an author by ISBN.  Primary purpose is quick look up on our side to retrieve Author object
	 * @return is a author object 
	 * @params is the string field ISBN (unique to each book)
	 * @author nolanurban
	 */	
	@Override
	public List<Author> findAuthorByIsbn(String isbn) {
		Book book = em.find(Book.class, isbn);
		return book.getAuthors();
	}
	
	
	/*
	 * Users should be able to retrieve a list of authors by last name 
	 * @return is a List since we cannot guarantee it's a single entry
	 * @params is a string for the last name
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorByLastName(String lastName) {
	String query = "SELECT a FROM Author a WHERE a.lastName = :lastName";	
	List<Author> authorList = em.createQuery(query, Author.class)
				.setParameter("lastName", lastName).getResultList();
		
	return authorList;
	}
	
	/*
	 * Users should be able to retrieve a list of authors by genre
	 * @return is a List since we cannot guarantee it's a single entry
	 * @params is a string for the last name
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorByGenre(String genre) {
		String query = "SELECT b from Book b"; 
		List<Book> bList = em.createQuery(query, Book.class).getResultList();
		List<Author> aList = new ArrayList<>();
		int i = 0;
		for (Book b : bList) {
			if (b.getGenres().get(i).getName().equals(genre)) { // I enjoyed this immensely.
				aList.addAll(b.getAuthors());
			}
			i++;
		}	
		return aList;
	}

}
