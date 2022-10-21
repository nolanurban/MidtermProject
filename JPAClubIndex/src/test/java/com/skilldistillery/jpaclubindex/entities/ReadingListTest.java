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

class ReadingListTest {

	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPAClubIndex");
	private EntityManager em;
	private ReadingList readingList;
	
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
		readingList = em.find(ReadingList.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		readingList = null;
	}

	@Test
	void test_Genre_mapping() {
		assertNotNull(readingList);
		
		String expected = "scifi";
		String actual = readingList.getName();
		
		assertEquals(expected, actual);
	}
	
	@Test
	void test_book_readingList_mapping() {
		assertNotNull(readingList);
		
		assertEquals("0312932081", readingList.getBooks().get(0).getIsbn());
	}

}
