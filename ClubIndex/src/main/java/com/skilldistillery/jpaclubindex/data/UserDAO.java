package com.skilldistillery.jpaclubindex.data;

import com.skilldistillery.jpaclubindex.entities.User;

public interface UserDAO {
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
}
