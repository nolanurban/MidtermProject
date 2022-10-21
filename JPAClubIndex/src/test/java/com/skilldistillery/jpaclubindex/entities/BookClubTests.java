package com.skilldistillery.jpaclubindex.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.awt.SystemColor;
import java.time.LocalDateTime;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BookClubTests {

	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPAClubIndex");
	private EntityManager em;
	private BookClub bc;
	
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
		bc = em.find(BookClub.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bc = null;
	}

	@Test
	void test_BookClub_mapping() {
		assertNotNull(bc);
		
		LocalDateTime expectedDateTime = LocalDateTime.of(2022, 10, 21, 12, 34, 10);
		LocalDateTime actualDateTime = bc.getCreateDate();
		
		assertEquals(expectedDateTime, actualDateTime);
		
		String expectedAbout = "Scifi nerds";
		String actualAbout = bc.getAboutClub();
		
		assertEquals(expectedAbout, actualAbout);
	}

}
