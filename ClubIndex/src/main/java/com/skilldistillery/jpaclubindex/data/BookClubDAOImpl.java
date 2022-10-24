package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import org.springframework.stereotype.Service;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.BookClubReadingList;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Location;
import com.skilldistillery.jpaclubindex.entities.User;

@Service
@Transactional
public class BookClubDAOImpl implements BookClubDAO{

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<BookClub> getBookClubsByUser(User user) {
		String query = "SELECT bc FROM BookClub bc WHERE :user MEMBER OF bc.users";
		return em.createQuery(query, BookClub.class).setParameter("user", user).getResultList();
	}

	@Override
	public BookClub getBookClubById(int id) {
		return em.find(BookClub.class, id);
	}

	@Override
	public List<BookClub> getBookClubsByOpenMembers() {
		String query = "SELECT bc FROM BookClub bc";
		
		List<BookClub> allBc = em.createQuery(query, BookClub.class)
				.getResultList();
		
		List<BookClub> returnList = new ArrayList<>();
		
		allBc.stream().forEach( (BookClub bc) -> {
			if(bc.getMaxMembers() - bc.getUsers().size() > 0) {
				returnList.add(bc);
			}
		});
		
		return returnList;
	}

	@Override
	public List<BookClub> getBookClubsByDigital(boolean isDigital) {
		String query = "SELECT bc FROM BookClub bc WHERE bc.digital = :isDigital";
		
		return em.createQuery(query, BookClub.class).setParameter("isDigital", isDigital).getResultList();
	}

	@Override
	public List<BookClub> getAllBookClubs() {
		String query = "SELECT bc FROM BookClub bc";
		return em.createQuery(query, BookClub.class).getResultList();
	}

	@Override
	public BookClub getBookClubByReadingList(BookClubReadingList bcrl) {
		String query = "SELECT bc FROM BookClub bc WHERE :bcrl MEMBER OF bc.readingLists";
		return em.createQuery(query, BookClub.class).setParameter("bcrl", bcrl).getSingleResult();
	}

	@Override
	public List<BookClub> getBookClubsByOwner(User owner) {
		String query = "SELECT bc FROM BookClub bc WHERE bc.owner = :owner";
		return em.createQuery(query, BookClub.class).setParameter("owner", owner).getResultList();
	}

	@Override
	public List<BookClub> getBookClubsByGenre(Genre genre) {
		String query = "SELECT bc FROM BookClub bc WHERE :genre MEMBER OF bc.genres";
		return em.createQuery(query, BookClub.class).setParameter("genre", genre).getResultList();
	}

	@Override
	public List<BookClub> getBookClubsByLocation(Location location) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BookClub createBookClub(BookClub bc) {
		em.persist(bc);
		em.flush();
		return bc;
	}

	@Override
	public boolean removeBookClub(BookClub bc) {
		em.remove(bc);
		return !em.contains(bc);
	}

	@Override
	public BookClub updateBookClub(BookClub bcOld, BookClub bcNew) {
		bcOld = em.find(BookClub.class, bcOld.getId());
		bcOld = bcNew;
		em.flush();
		return bcOld;
	}

	@Override
	public BookClub addUserToBookClub(BookClub bc, User user) {
		bc = em.find(BookClub.class, bc.getId());
		bc.addUser(user);
		em.flush();
		return bc;
	}

	@Override
	public BookClub removeUserFromBookClub(BookClub bc, User user) {
		bc = em.find(BookClub.class, bc.getId());
		bc.removeUser(user);
		em.flush();
		return bc;
	}

}
