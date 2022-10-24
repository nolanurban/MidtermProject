package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

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
		
		
}
