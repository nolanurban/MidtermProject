package com.skilldistillery.jpaclubindex.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Author;

@Service
@Transactional
public class AuthorDaoImpl implements AuthorDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Author findAuthorById(int id) {
		return em.find(Author.class, id);
	}

}
