package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import org.springframework.stereotype.Service;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.User;

@Service
@Transactional
public class BookClubDAOImpl implements BookClubDAO{

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<BookClub> getBookClubsByUserId(User user) {
		String query = "SELECT bc FROM BookClub bc WHERE :user MEMBER OF bc.users";
		return em.createQuery(query, BookClub.class).setParameter("user", user).getResultList();
	}

}
