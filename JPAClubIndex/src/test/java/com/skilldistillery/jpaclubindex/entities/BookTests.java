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

class BookTests {

	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPAClubIndex");
	private EntityManager em;
	private Book book;
	
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
		book = em.find(Book.class, "0312932081");
	}

	@AfterEach
	void tearDown() throws Exception {
		book = null;
		em.close();
	}

	@Test
	void test_Book_mapping() {
		assertNotNull(book);
		
		String expected = "Ender's Game";
		String actual = book.getTitle();
		
		assertEquals(expected, actual);
		assertEquals(4, book.getReviews().get(0).getRating());
		
		assertEquals("Orson", book.getAuthors().get(0).getFirstName());
		assertEquals(1, book.getGenres().get(0).getId());
	}
	
	@Test
	void test_readinglist_mapping() {
		assertNotNull(book);
		
		assertEquals(1, book.getReadingLists().get(0).getId());
	}

}
