package com.skilldistillery.jpaclubindex.data;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getBookClubsByOpenMembers() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getBookClubsByDigital(boolean isDigital) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getAllBookClubs() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BookClub getBookClubByReadingList(BookClubReadingList bcrl) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getBookClubsByOwner(User owner) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getBookClubsByGenre(Genre genre) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookClub> getBookClubsByLocation(Location location) {
		// TODO Auto-generated method stub
		return null;
	}

}
