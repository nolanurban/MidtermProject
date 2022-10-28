package com.skilldistillery.jpaclubindex.data;

import java.util.ArrayList;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.apache.tomcat.websocket.AsyncChannelWrapperNonSecure;
import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.Location;
import com.skilldistillery.jpaclubindex.entities.Review;
import com.skilldistillery.jpaclubindex.entities.User;
import com.skilldistillery.jpaclubindex.entities.UserReadingList;

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
			User user = em.createQuery(query, User.class).setParameter("userName", userName)
					.setParameter("password", password).getSingleResult();
			user = findUserById(user.getId());
			return user; // Currently doesn't do much but return Userdata
		} catch (NoResultException e) {
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
		updated.setLastName(currentUser.getLastName());
		updated.setAboutMe(currentUser.getAboutMe());
		updated.setEmail(currentUser.getEmail());
		updated.setUsername(currentUser.getUsername());
		updated.setProfileUrl(currentUser.getProfileUrl());
		updated.getLocation().setState(newLocation.getState());
		updated.getLocation().setZipCode(newLocation.getZipCode());
		updated.getLocation().setUnit(newLocation.getZipCode());
		updated.getLocation().setCity(newLocation.getCity());
		updated.getLocation().setStreet(newLocation.getStreet());
		em.flush();
		return updated;
	}

	@Override
	public boolean removeUser(int userId) {
		User currentUser = em.find(User.class, userId);
		List<BookClub> allBookClubs = new ArrayList<>(currentUser.getBookClubs());
		
		for(BookClub bc : allBookClubs) {
			if(bc.getOwner().equals(currentUser) && bc.getUsers().size() > 1) {
				
				List<User> users = new ArrayList<>(bc.getUsers()); 
				for(User u : users) {
					if(u.equals(currentUser)) {
						continue;
					} else {
						currentUser.removeBookClub(bc);
						bc.setOwner(u);
						break;
					}
				}
			} else {
				em.remove(bc);
			}
		}
		List<Review> allReviews = new ArrayList<>(currentUser.getReviews()); 
		for(Review r : allReviews) {
			em.remove(r);
		}
		
		List<UserReadingList> allURL = new ArrayList<>(currentUser.getReadingLists());
		for(UserReadingList url : allURL) {
			em.remove(url);
		}
		
		em.remove(currentUser);
		return !em.contains(currentUser);
	}

	@Override
	public User findUserByUsername(String username) {
		String query = "SELECT u FROM User u WHERE u.username = :username";
		
		try {
			return em.createQuery(query, User.class).setParameter("username", username).getSingleResult();
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<User> findUserByFirstName(String firstName) {
		String query = "SELECT u FROM User u WHERE u.firstName = :firstName";	
		return em.createQuery(query, User.class).setParameter("firstName", firstName).getResultList();
	}

	@Override
	public List<User> findUserByLastName(String lastName) {
		String query = "SELECT u FROM User u WHERE u.lastName = :lastName";	
		return em.createQuery(query, User.class).setParameter("lastName", lastName).getResultList();
	}
}
