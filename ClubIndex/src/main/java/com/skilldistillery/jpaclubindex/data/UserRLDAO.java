package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Book;
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
	
	/**
	 * Given a UserReadingList, will persist it
	 * @param url - the UserReadingList to persist
	 * @return UserReadingList - the persisted UserReadingList
	 * @author tylertanner
	 */
	UserReadingList createUserRL(UserReadingList url);

	/**
	 * Given a UserReadingList, will remove it from the persistence layer and
	 * return whether the operation was successful or not
	 * @param url - The UserReadingList to remove
	 * @return boolean - whether the remove was successful
	 * @author tylertanner
	 */
	boolean deleteUserRL(UserReadingList url);
	
	/**
	 * Given two UserReadingLists, will update oldURL to newURL and return the
	 * updated URL
	 * @param oldURL - the current URL
	 * @param newURL - the new URL
	 * @return UserReadingList - the updated URL
	 * @author tylertanner
	 */
	UserReadingList updateUserRL(UserReadingList oldURL, UserReadingList newURL);
	
	/**
	 * Given a Book and a UserReadingList will remove the Book from the URL and
	 * return the updated URL
	 * @param book - The Book to remove
	 * @param url - The UserReadingList to remove
	 * @return UserReadingList - the updated URL
	 * @author tylertanner
	 */
	UserReadingList removeBookFromUserRL(Book book, UserReadingList url);
	
	/**
	 * Given a Book and a UserReadingList will add the Book to the URL and
	 * return the updated URL
	 * @param book - the Book to add
	 * @param url - the UserReadingList to update
	 * @return UserReadingList - the updated URL
	 * @author tylertanner
	 */
	UserReadingList addBookToUserRL(Book book, UserReadingList url);
}
