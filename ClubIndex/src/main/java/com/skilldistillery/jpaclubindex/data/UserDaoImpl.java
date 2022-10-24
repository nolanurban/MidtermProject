package com.skilldistillery.jpaclubindex.data;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Location;
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

	@Override
	public User create(User newUser) {
		em.persist(newUser);
		em.flush();
		return newUser;
	}

	@Override
	public User update(User currentUser) {
		Location newLocation = currentUser.getLocation();
		User updated = em.find(User.class, currentUser.getId());
		
		updated.setFirstName(currentUser.getFirstName());
		
		updated.getLocation().setCity(newLocation.getCity());
		
		em.flush();	
		return updated;
	}
	
	
	
	
	
}
