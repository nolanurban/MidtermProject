package com.skilldistillery.jpaclubindex.data;

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
	boolean removeUser(User currentUser);
}
