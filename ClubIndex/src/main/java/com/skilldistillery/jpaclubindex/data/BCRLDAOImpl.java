package com.skilldistillery.jpaclubindex.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

@Service
@Transactional
public class BCRLDAOImpl implements BCRLDAO{
	
	@PersistenceContext
	EntityManager em;
}
