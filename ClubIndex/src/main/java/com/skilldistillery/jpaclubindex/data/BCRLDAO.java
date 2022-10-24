package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.BookClubReadingList;

public interface BCRLDAO {

	/**
	 * Given an int, will find and return a BookClubReadingList object
	 * @param id - An id of a book club to find
	 * @return BookClubReadingList - bcrl that contains the given id
	 * @author tylertanner
	 */
	BookClubReadingList getBCRLById(int id);
	
	/**
	 * Given a BookClub object, will return all BCRLs owned by that BookClub
	 * @param bc - A BookClub you want to see the BCRLs for
	 * @return List<BookClubReadingList> - A list of BCRLs that the given bc has
	 * @author tylertanner
	 */
	List<BookClubReadingList> getBCRLByBookClub(BookClub bc);
	
	/**
	 * Given a Book object, will return all BCRLs that contain that Book
	 * @param book - A book that is included on the returned list of BCRLs
	 * @return List<BookClubReadingList> - A list of BCRLs that contain the given book
	 * @author tylertanner
	 */
	List<BookClubReadingList> getBCRLByBook(Book book);

	/**
	 * Given a String name, will return all BCRLs with that given name
	 * @param name - Name of a BCRL
	 * @return List<BookClubReadingList> - A list of all BCRLs with the given name
	 * @author tylertanner
	 */
	List<BookClubReadingList> getBCRLByName(String name);

	/**
	 * Given a BCRL will remove from the persistence layer
	 * @param bcrl - BCRL you would like removed from the database
	 * @return boolean - Whether the bcrl is still contained in the database
	 * @author tylertanner
	 */
	boolean deleteBCRL(BookClubReadingList bcrl);

	/**
	 * Given a BCRL will add to the persistence layer
	 * @param bcrl - BCRL you would like persisted
	 * @return BookClubReadingList - the BCRL persisted
	 * @author tylertanner
	 */
	BookClubReadingList createBCRL(BookClubReadingList bcrl);

	/**
	 * Given a Book and BookClubReadingList, will add the Book to the BCRL
	 * @param book - Book you want added to the reading list
	 * @param bcrl - BCRL you want to modify
	 * @return BookClubReadingList - the updated BCRL
	 * @author tylertanner
	 */
	BookClubReadingList addBookToBCRL(Book book, BookClubReadingList bcrl);

	/**
	 * Given a Book and BookClubReadingList, if the Book is contained in the BCRL, will remove it
	 * @param book - Book you want removed from the BCRL
	 * @param bcrl - BCRL you want to modify
	 * @return BookClubReadingList - the updated BCRL
	 * @author tylertanner
	 */
	BookClubReadingList removeBookFromBCRL(Book book, BookClubReadingList bcrl);

	/**
	 * Given a BookClubReadingList and a String, will update the name of the BCRL
	 * @param bcrlOld - BCRL you want updated
	 * @param newName - the new Name of the BCRL
	 * @return BookClubReadingList - the updated BookClubReadingList
	 * @author tylertanner
	 */
	BookClubReadingList updateBCRLName(BookClubReadingList bcrlOld, String newName);
}
