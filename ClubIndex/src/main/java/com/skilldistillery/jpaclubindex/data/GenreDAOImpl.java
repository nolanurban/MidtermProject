package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Genre;

@Service
@Transactional
public class GenreDAOImpl implements GenreDAO{

	@PersistenceContext
	EntityManager em;
	
	@Override
	public List<Genre> getAllGenres() {
		String query = "SELECT g FROM Genre g";
		
		return em.createQuery(query, Genre.class).getResultList();
	}

	@Override
	public Genre getGenreById(int id) {
		return em.find(Genre.class, id);
	}
	

	
}
