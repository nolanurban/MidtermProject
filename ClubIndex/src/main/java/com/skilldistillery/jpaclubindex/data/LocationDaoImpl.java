package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaclubindex.entities.Location;

@Service
@Transactional
public class LocationDaoImpl implements LocationDAO {

	@PersistenceContext
	EntityManager em;
	
	@Override
	public List<Location> getAllLocations() {
		String query = "SELECT l FROM Location l";	
		return em.createQuery(query, Location.class).getResultList();
	}

	@Override
	public List<Location> getLocationByZipCode(String zipCode) {
		String query = "SELECT l FROM Location l WHERE l.zipCode = :zipCode";
		return em.createQuery(query, Location.class).setParameter("zipCode", zipCode).getResultList();
	}

	@Override
	public List<Location> getLocationByState(String state) {
		String query = "SELECT l from Location l WHERE l.state = :state";
		return em.createQuery(query, Location.class).setParameter("state", state).getResultList();
	}

}
