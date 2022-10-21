package com.skilldistillery.jpaclubindex.data;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.User;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User findUserById(int userId) {
		return em.find(User.class, userId);
	}

	@Override
	public User loginUserAndPassword(String userName, String password) {
		 String query = "Select s from User s where username = :userName and password = :password";
		 try {
			 User user = em.createQuery(query, User.class).setParameter("userName", userName).setParameter("password",password).getSingleResult();
			 user = findUserById(user.getId());
			 return user; // Currently doesn't do much but return Userdata
		 } catch(NoResultException e) {
			 User user = null;
			 return user;
		 }
	}
	
	
	
}
