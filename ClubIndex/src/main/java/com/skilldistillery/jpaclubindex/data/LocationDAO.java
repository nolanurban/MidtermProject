package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.Location;

public interface LocationDAO {
	
	/**
	 * List all items by location in one search
	 * @return all locations in the system
	 * @author Ashley Osburn 
	 */
	List<Location> getAllLocations();
	
	/**
	 * List all Locations by zip code
	 * @return location by ZipCode
	 * @author Ashley Osburn
	 */
	List<Location> getLocationByZipCode(String zipCode);
	
	/**
	 * Given Location by State 
	 * @return associated location
	 * @author Ashley Osburn
	 */
	List<Location> getLocationByState(String state);
	
}
