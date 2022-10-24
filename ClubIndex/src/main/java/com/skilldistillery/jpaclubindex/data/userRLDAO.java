package com.skilldistillery.jpaclubindex.data;



import java.util.List;

import com.skilldistillery.jpaclubindex.entities.UserReadingList;

public interface userRLDAO {
	public UserReadingList findReadingListByID(int readingListId);
	
	public List<UserReadingList> findlistofAllUserReadingList();


}
