package com.skilldistillery.jpaclubindex.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Book;

@Service
@Transactional
public class BookDaoImpl implements BookDAO {
	@PersistenceContext
	private EntityManager em;

	@Override
	public Book findBookById(String isbn) {
		Book book = em.find(Book.class, isbn);
		return book;
	}

}
