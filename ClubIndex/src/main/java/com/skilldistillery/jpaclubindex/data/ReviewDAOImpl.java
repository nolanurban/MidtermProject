package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Book;
import com.skilldistillery.jpaclubindex.entities.Review;
import com.skilldistillery.jpaclubindex.entities.User;

@Service
@Transactional
public class ReviewDAOImpl implements ReviewDAO{

	@PersistenceContext
	EntityManager em;
	
	@Override
	public List<Review> getAllReviews() {
		String query = "SELECT r FROM Review r";
		return em.createQuery(query, Review.class).getResultList();
	}

	@Override
	public List<Review> getReviewByUser(User user) {
		String query = "SELECT r FROM Review r WHERE r.user = :user";
		return em.createQuery(query, Review.class)
				.setParameter("user", user).getResultList();
	}

	@Override
	public Review getReviewById(int id) {
		return em.find(Review.class, id);
	}

	@Override
	public List<Review> getReviewByBook(Book book) {
		String query = "SELECT r FROM Review r WHERE r.book = :book";
		return em.createQuery(query, Review.class)
				.setParameter("book", book).getResultList();
	}

	@Override
	public Review createReview(Review review) {
		em.persist(review);
		em.flush();
		return review;
	}

	@Override
	public boolean deleteReview(Review review) {
		em.remove(review);
		em.flush();
		return !em.contains(review);
	}

	@Override
	public Review updateReview(Review oldReview, Review newReview) {
		oldReview = em.find(Review.class, oldReview.getId());
		oldReview.setReview(newReview.getReview());
		oldReview.setRating(newReview.getRating());
		em.flush();
		return oldReview;
	}

}
