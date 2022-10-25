package com.skilldistillery.jpaclubindex.data;

import java.util.List;

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


}
