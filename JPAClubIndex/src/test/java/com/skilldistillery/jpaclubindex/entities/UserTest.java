package com.skilldistillery.jpaclubindex.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPAClubIndex");
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test() {
		assertNotNull(user);
		assertEquals("ashozz", user.getUsername());
		assertEquals("Texas", user.getLocation().getState());
		assertEquals("Great book. Socially did not age well.", user.getReviews().get(0).getReview());
	}
	
	@Test
	void test_bookclub_mapping() {
		assertNotNull(user);
		assertEquals(1, user.getBookClubs().get(0).getId());
	}
	
	@Test
	void test_User_UserReadingList_mapping() {
		String expected = "scifi";
		String actual = user.getReadingLists().get(0).getName();
		
		assertEquals(expected, actual);
	}
	
	

}
