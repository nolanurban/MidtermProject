package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Author;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Genre;

@Service
@Transactional
public class AuthorDaoImpl implements AuthorDAO {

	@PersistenceContext
	private EntityManager em;

	/*
	 * Users should be able to retrieve an author by id. Primary purpose is quick
	 * look up on our side to retrieve Author object
	 * 
	 * @return is a author object
	 * 
	 * @params is an integer
	 * 
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorById(int id) {
		List<Author> a = new ArrayList<>();
		a.add(em.find(Author.class, id));
		return a;
	}

	/*
	 * Users should be able to retrieve an author by ISBN. Primary purpose is quick
	 * look up on our side to retrieve Author object
	 * 
	 * @return is a author object
	 * 
	 * @params is the string field ISBN (unique to each book)
	 * 
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorByIsbn(String isbn) {
		Book book = em.find(Book.class, isbn);
		return book != null ? book.getAuthors() : null;
	}

	/*
	 * Users should be able to retrieve a list of authors by last name
	 * 
	 * @return is a List since we cannot guarantee it's a single entry
	 * 
	 * @params is a string for the last name
	 * 
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorByLastName(String lastName) {
		String query = "SELECT a FROM Author a WHERE a.lastName = :lastName";
		List<Author> authorList = em.createQuery(query, Author.class).setParameter("lastName", lastName)
				.getResultList();
		for(Author a : authorList) {
			for(Book b : a.getBooks()) {
				b.getGenres().size();
			}
		}
		return authorList;
	}

	/*
	 * Users should be able to retrieve a list of authors by genre
	 * 
	 * @return is a List since we cannot guarantee it's a single entry
	 * 
	 * @params is a string for the last name
	 * 
	 * @author nolanurban
	 */
	@Override
	public List<Author> findAuthorByGenre(String genre) {
		String query = "SELECT b from Book b";
		List<Book> bList = em.createQuery(query, Book.class).getResultList();
		List<Author> aList = new ArrayList<>(); // find the books, find the genres, get the authors.
		for (Book b : bList) {
			for (int j = 0; j < b.getGenres().size(); j++) {
				if (b.getGenres().get(j).getName().equals(genre)) {
					if (!aList.containsAll(b.getAuthors()))
							aList.addAll(b.getAuthors());
					}
			}
		}			
		return aList;
	}

}
// for (int j = 0; j < b.getGenres().size(); j++) {
//	if (b.getGenres().get(j).getName().equals(genre)) { 
//		aList.add(i, b.getAuthors().get(0));
//		i++;

// SELECT * FROM book JOIN book_genre ON book.isbn = book_genre.book_isbn JOIN genre ON book_genre.genre_id = genre.id WHERE genre.id= ?;
