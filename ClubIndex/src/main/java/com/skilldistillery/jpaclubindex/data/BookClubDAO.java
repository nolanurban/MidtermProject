package com.skilldistillery.jpaclubindex.data;

import java.util.List;

import com.skilldistillery.jpaclubindex.entities.BookClub;
import com.skilldistillery.jpaclubindex.entities.User;

public interface BookClubDAO {

	List<BookClub> getBookClubsByUserId(User user);
}
