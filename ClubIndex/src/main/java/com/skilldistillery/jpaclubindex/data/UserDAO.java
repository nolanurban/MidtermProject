package com.skilldistillery.jpaclubindex.data;

import com.skilldistillery.jpaclubindex.entities.User;

public interface UserDAO {
	User findUserById(int userId);
}
