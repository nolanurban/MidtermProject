package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.User;

public interface UserDAO {
	
	/**
	 * This method was part of initial build and SMOKETEST
	 * @author Ashley Osburn
	 */
	User findUserById(int userId);
	
	
	User loginUserAndPassword(String username, String passsword);
	
	/** 
	 * this will create a brand new user.
	 * @author Ashley Osburn
	 */
	User create(User newUser);
	
	/**
	 * this will update an existing user.
	 * @author Ashley Osburn
	 */
	User update(User newUser);
	
	/**
	 * Allows a user to delete account
	 * @author Ashley Osburn
	 */
	boolean removeUser(int userId);
	
	/**
	 * Given a String username, will find the associated User
	 * @param username - the username associated with the User
	 * @return User - the associated User
	 * @author tylertanner
	 */
	User findUserByUsername(String username);
	
	/**
	 * Given a first name will find the associated Users
	 * @return List<User>
	 * @author ashleyosburn
	 */
	List<User> findUserByFirstName(String firstName);
	
	/**
	 * Given a last name will find the associated User
	 * @return List<User>
	 * @author ashleyosburn 
	 */
	List<User> findUserByLastName(String lastName);
}
