package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.User;
import com.skilldistillery.jpaclubindex.entities.UserReadingList;
import com.skilldistillery.jpaclubindex.data.UserRLDAO;

@Service
@Transactional
public class UserRLDaoImpl implements UserRLDAO {
		
		@PersistenceContext
		private EntityManager em;
		
		@Override
		public UserReadingList findReadingListByID(int readingListId) {
			String query = "SELECT l from UserReadingList l WHERE id = :readingListId";

			return em.find(UserReadingList.class, readingListId);
		}
		
		@Override
		public List<UserReadingList> findlistofAllUserReadingList() {
			String query = "SELECT l FROM UserReadingList l";
					
			return em.createQuery(query, UserReadingList.class).getResultList();
		}

		@Override
		public List<UserReadingList> getReadingListByUser(User user) {
			String query = "SELECT rl FROM UserReadingList rl WHERE user = :user ";
			return em.createQuery(query, UserReadingList.class).setParameter("user", user).getResultList();
		}
		
		@Override
		public List<UserReadingList> getUserReadingListByGenre(Genre genre) {
			String query = "SELECT rl FROM UserReadingList rl WHERE genre = :genre";
			return em.createQuery(query, UserReadingList.class).setParameter("genre", genre).getResultList();		
		}

		@Override
		public UserReadingList createUserRL(UserReadingList url) {
			em.persist(url);
			em.flush();
			return url;
		}

		@Override
		public boolean deleteUserRL(UserReadingList url) {
			em.remove(url);
			return !em.contains(url);
		}

		@Override
		public UserReadingList updateUserRL(UserReadingList oldURL, UserReadingList newURL) {
			oldURL = em.find(UserReadingList.class, oldURL.getId());
			oldURL.setName(newURL.getName());
			em.flush();
			return oldURL;
		}
}
