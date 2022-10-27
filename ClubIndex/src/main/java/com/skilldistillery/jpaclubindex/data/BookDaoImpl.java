package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Author;
import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Review;

@Service
@Transactional
public class BookDaoImpl implements BookDAO {
	@PersistenceContext
	private EntityManager em;
	

	/**
	 * Given an String ISBN, locate a Book and return its object.
	 * @param isbn
	 * @return book
	 * @author nolanurban
	 */
	@Override

	public List<Book> findBookById(String isbn) {
		List<Book> book = new ArrayList<>();
		book.add(em.find(Book.class, isbn));
		return book;
	}
	/**
	 * Given a String title, locate a Book and return its object.
	 * @param title
	 * @return book
	 * @author nolanurban
	 */
	@Override
	public List<Book> findBookByTitle(String title) {
		String query = "SELECT b from Book b WHERE b.title = :title";
		return em.createQuery(query, Book.class).setParameter("title", title).getResultList();
	}
	/**
	 * Given a String keyword, search the DB and return a list
	 * @param keyWord
	 * @return title
	 * @author nolanurban
	 */
	@Override
	public List<Book> findBookByKeyWord(String keyWord) {
		String query = "SELECT s FROM Book s WHERE s.title LIKE :keyWord";
		return em.createQuery(query, Book.class)
				.setParameter("keyWord", '%' + keyWord + '%').getResultList();
	}
	/**
	 * Given a int keyword, search the DB and return a list containing the year
	 * @param year
	 * @return List<Book>
	 * @author nolanurban
	 */
	@Override
	public List<Book> findBookByYear(int year) {
		String query = "SELECT s FROM Book s where s.publishYear = :year";
		return em.createQuery(query, Book.class)
				.setParameter("year", year).getResultList();

	}
	/**
	 * Given a String last name, search the DB and return a list containing it
	 * @param lastName
	 * @return List<Book>
	 * @author nolanurban with massive assistance
	 */
	@Override
	public List<Book> findBookByAuthorLastName(String lastName) {
		String query = "SELECT a FROM Author a WHERE a.lastName = :lastName";
		List<Book> books = new ArrayList<>();
		try { 
			List<Author> authors = em.createQuery(query, Author.class)
				.setParameter("lastName", lastName).getResultList();
			
			for(Author a : authors) {
				a.getBooks().size();
				books.addAll(a.getBooks());
			}

		} catch(NullPointerException e) {/**/}
		
		return books;
	}
	
	@Override
	public List<Book> findBookByGenre(String genreName) {
		String genreQuery = "SELECT g FROM Genre g WHERE g.name = :name";
		Genre genre = em.createQuery(genreQuery, Genre.class).setParameter("name", genreName).getSingleResult();
		
		String query = "SELECT b from Book b";
		List<Book> bList = em.createQuery(query, Book.class).getResultList();
		List<Book> returnList = new ArrayList<>();
		
		for (Book b : bList) {
			if (b.getGenres().contains(genre)) {
				returnList.add(b);
			}
		}
		
		return returnList;
	}
	
	@Override
	public List<Book> getBestRatedBooks() {
		List<Book> bList = getAllBooks();
		List<Book> returnList = new ArrayList<>();
		for (Book b : bList) {
			for (Review r : b.getReviews()) {
				if (r.getRating() > 5) {
					returnList.add(b);
				}
			}
		}
		
		return returnList;
	}

	@Override
	public List<Book> getAllBooks() {
		String query = "SELECT b from Book b";
		return em.createQuery(query, Book.class).getResultList();
	}

}
