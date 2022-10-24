package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.BookClubReadingList;

@Service
@Transactional
public class BCRLDAOImpl implements BCRLDAO{
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public BookClubReadingList getBCRLById(int id) {
		return em.find(BookClubReadingList.class, id);
	}

	@Override
	public List<BookClubReadingList> getBCRLByBookClub(BookClub bc) {
		String query = "SELECT bcrl FROM BookClubReadingList bcrl WHERE bcrl.bookClub = :bc";
		
		List<BookClubReadingList> returnList = em.createQuery(query, BookClubReadingList.class)
				.setParameter("bc", bc).getResultList();
		
		return returnList;
	}

	@Override
	public List<BookClubReadingList> getBCRLByBook(Book book) {
		String query = "SELECT bcrl FROM BookClubReadingList bcrl WHERE :book MEMBER OF bcrl.books";
		
		List<BookClubReadingList> returnList = em.createQuery(query, BookClubReadingList.class)
				.setParameter("book", book).getResultList();
		
		return returnList;
	}

	@Override
	public List<BookClubReadingList> getBCRLByName(String name) {
		String query = "SELECT bcrl FROM BookClubReadingList bcrl WHERE bcrl.name = :name";
		
		List<BookClubReadingList> returnList = em.createQuery(query, BookClubReadingList.class)
				.setParameter("name", name).getResultList();
		
		return returnList;
	}

	@Override
	public boolean deleteBCRL(BookClubReadingList bcrl) {
		em.remove(bcrl);
		return !em.contains(bcrl);
	}

	@Override
	public BookClubReadingList createBCRL(BookClubReadingList bcrl) {
		em.persist(bcrl);
		em.flush();
		return bcrl;
	}

	@Override
	public BookClubReadingList addBookToBCRL(Book book, BookClubReadingList bcrl) {
		bcrl = em.find(BookClubReadingList.class, bcrl.getId());
		bcrl.addBook(book);
		em.flush();
		return bcrl;
	}

	@Override
	public BookClubReadingList removeBookFromBCRL(Book book, BookClubReadingList bcrl) {
		bcrl = em.find(BookClubReadingList.class, bcrl.getId());
		bcrl.removeBook(book);
		em.flush();
		return bcrl;
	}

	@Override
	public BookClubReadingList updateBCRLName(BookClubReadingList bcrlOld, String newName) {
		bcrlOld = em.find(BookClubReadingList.class, bcrlOld.getId());
		bcrlOld.setName(newName);
		em.flush();
		return bcrlOld;
	}
}
