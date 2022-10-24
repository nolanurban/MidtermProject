package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.BookClubReadingList;
import com.skilldistillery.jpaclubindex.entities.Genre;
import com.skilldistillery.jpaclubindex.entities.Location;
import com.skilldistillery.jpaclubindex.entities.User;

public interface BookClubDAO {

	/**
	 * Given a user, will return each BookClub the user is in 
	 * @param user - The user to search with
	 * @return List<BookClub> - a list of BookClubs the given user is in
	 * @author tylertanner
	 */
	List<BookClub> getBookClubsByUser(User user);
	
	/**
	 * Given an id, will search for the BookClub that has that id
	 * @param id - the id of the BookClub you're looking for
	 * @return BookClub - the BookClub found
	 * @author tylertanner
	 */
	BookClub getBookClubById(int id);
	
	/**
	 * Will return a list of BookClubs with open spots
	 * @return List<BookClub> - A list of BookClubs that have an open spot
	 * @author tylertanner
	 */
	List<BookClub> getBookClubsByOpenMembers(); 
	
	/**
	 * Will return a list of BookClubs that are digital or not depending
	 * on isDigital
	 * @param isDigital - true for digital BookClubs, false for not
	 * @return List<BookClub> - List of BookClubs with the given digitality
	 * @author tylertanner
	 */
	List<BookClub> getBookClubsByDigital(boolean isDigital);
	
	/**
	 * Will return all BookClubs
	 * @return List<BookClub> - all bookclubs
	 * @author tylertanner
	 */
	List<BookClub> getAllBookClubs();
	
	/**
	 * Given a BookClubReadingList, returns the associated BookClub
	 * @param bcrl - the BCRL you would like to see the owner of
	 * @return BookClub - the owner of the given BCRL
	 * @author tylertanner
	 */
	BookClub getBookClubByReadingList(BookClubReadingList bcrl);
	
	/**
	 * Given an owner, will return all BookClubs owned by that user
	 * @param owner - the owner of the BookClub(s) you would like to see
	 * @return List<BookClub> - All BookClubs owned by owner
	 */
	List<BookClub> getBookClubsByOwner(User owner);
	
	/**
	 * Given a Genre, will return all BookClubs that have that genre
	 * @param genre - the genre you are looking for
	 * @return List<BookClub> - All BookClubs with that genre listed
	 */
	List<BookClub> getBookClubsByGenre(Genre genre);
	
	/**
	 * Given a location, will return all BookClubs that match any of the
	 * given Location fields
	 * @param location - The Location fields you are trying to match
	 * @return List<BookClub> - All BookClubs that match any of the given Location
	 * fields
	 */
	List<BookClub> getBookClubsByLocation(Location location);
}
