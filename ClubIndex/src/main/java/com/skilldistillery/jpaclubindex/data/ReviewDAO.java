package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Review;
import com.skilldistillery.jpaclubindex.entities.User;

public interface ReviewDAO {

	/**
	 * Will return all Reviews stored in the database
	 * @return List<Review> - all Reviews persisted
	 * @author tylertanner
	 */
	List<Review> getAllReviews();
	
	/**
	 * Will return all Reviews written by the given User
	 * @param user - the User who owns the given reviews
	 * @return List<Review> - all Reviews owned by the given User
	 * @author tylertanner
	 */
	List<Review> getReviewByUser(User user);
	
	/**
	 * Given an id, will return the associated Review
	 * @param id - the id of the Review being looked for
	 * @return Review - the Review for the given id
	 * @author tylertanner
	 */
	Review getReviewById(int id);
	
	/**
	 * Given a Book, will return all Reviews written for that Book
	 * @param book - the Book you want to see reviews for
	 * @return List<Review> - All Reviews for the given Book
	 * @author tylertanner
	 */
	List<Review> getReviewByBook(Book book);
	
	/**
	 * Will persist the given Review and return the persisted Review
	 * @param review - the Review you want persisted
	 * @return Review - the persisted Review
	 * @author tylertanner
	 */
	Review createReview(Review review);
	
	/**
	 * Given a review, will remove it from the database. Returns a boolean
	 * based on whether the remove was successful.
	 * @param review - The review you want removed
	 * @return boolean - Whether the operation was successful or not
	 * @author tylertanner
	 */
	boolean deleteReview(Review review);
	
	/**
	 * Given two Reviews, will grab the oldReview from the database and update
	 * it to be the newReview
	 * @param oldReview - the current Review
	 * @param newReview - the updated Review
	 * @return Review - the updated Review
	 */
	Review updateReview(Review oldReview, Review newReview);
}
