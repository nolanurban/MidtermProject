package com.skilldistillery.jpaclubindex.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.awt.SystemColor;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.TimeZone;

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
				
		LocalDateTime expectedDateTime = LocalDateTime.of(2022, 10, 21, 11, 34, 10);
		/*
		 * Will take the system default time zone, assign it to the LocalDateTime owned by the BookClub
		 * object, then convert it to MST ("America/Denver") to ensure that the JUnit (should) pass
		 * no matter what TimeZone your system is in. This functions this way because the time is the "same"
		 * as in the database, but just in a different time zone.
		 */
		LocalDateTime actualDateTime = bc.getCreateDate().atZone(ZoneId.systemDefault())
				.withZoneSameInstant(ZoneId.of("America/Denver")).toLocalDateTime();

		
		assertEquals(expectedDateTime, actualDateTime);
		
		String expectedAbout = "Scifi nerds";
		String actualAbout = bc.getAboutClub();
		
		assertEquals(expectedAbout, actualAbout);
	}
	
	@Test
	void test_Genre_BookClub_mapping() {
		assertNotNull(bc);
		
		assertEquals("Science-Fiction", bc.getGenres().get(0).getName());
	}
	
	@Test
	void test_user_mapping() {
		assertNotNull(bc);
		
		assertEquals("ash", bc.getUsers().get(0).getFirstName());
	}

	@Test
	void test_BookClub_BookClubReadingList_mapping() {
		String expected = "Scifi books";
		String actual = bc.getReadingLists().get(0).getName();
		
		assertEquals(expected, actual);
	}
}
