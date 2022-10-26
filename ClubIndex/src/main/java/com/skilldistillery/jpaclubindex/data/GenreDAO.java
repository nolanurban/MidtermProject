package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Genre;

public interface GenreDAO {

	/**
	 * Will return all Genres persisted in the database
	 * @return List<Genre> - all Genres in the database
	 * @author tylertanner
	 */
	List<Genre> getAllGenres();
	
	/**
	 * Given an id, will search for the Genre associated with the given id
	 * @param id - the Id of the Genre you are looking for
	 * @return Genre - the Genre associated with the given id
	 * @author tylertanner
	 */
	Genre getGenreById(int id);
	
	/**
	 * Given a genreName, will find the associated Genre
	 * @param genreName - the name of the Genre you're looking for
	 * @return Genre - the associated Genre
	 * @author tylertanner
	 */
	Genre getGenreByName(String genreName);
}
