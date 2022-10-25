package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.User;

import com.skilldistillery.jpaclubindex.entities.UserReadingList;

public interface UserRLDAO {
	
	/**
	 * Give an int, will find the list associated with that ID. 
	 * @author Ashley Osburn        */
	public UserReadingList findReadingListByID(int readingListId);
	
	
	/** 
	 * find all lists associated with the user 
	 * @author Ashley Osburn */
	public List<UserReadingList> findlistofAllUserReadingList();

	/**
	 * Gets all the reading list for a particular user(think influencer)
	 * @author Ashley Osburn
	 */
	public List<UserReadingList> getReadingListByUser(User user);
	
	/**
	 * find reading lists associated with a particular genre
	 * @author Ashley Osburn
	 */
	public List<UserReadingList> getUserReadingListByGenre(Genre genre);

}
