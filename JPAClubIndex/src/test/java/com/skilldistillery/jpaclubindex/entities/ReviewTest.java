package com.skilldistillery.jpaclubindex.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ReviewTest {


	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPAClubIndex");
	private EntityManager em;
	private Review review;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		review = em.find(Review.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;
	}

	@Test
	void test_Genre_mapping() {
		assertNotNull(review);
		
		String expected = "Great book. Socially did not age well.";
		String actual = review.getReview();
		
		assertEquals(expected, actual);
		assertEquals(4, review.getRating());
		assertEquals("ozz", review.getUser().getLastName());
		assertEquals("Ender's Game", review.getBook().getTitle());
	}


}
