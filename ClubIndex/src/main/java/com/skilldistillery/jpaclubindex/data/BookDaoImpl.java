package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Author;
import com.skilldistillery.jpaclubindex.entities.Book;

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
		Book findBook = em.find(Book.class, isbn);
		book.add(findBook);
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
		try { Author a = em.createQuery(query, Author.class)
				.setParameter("lastName", lastName).getSingleResult();
			a.getBooks().size();
			return a.getBooks();

		} catch(NoResultException e) {
			List<Book> noBook = null;
			return noBook;
		}
	}


}
