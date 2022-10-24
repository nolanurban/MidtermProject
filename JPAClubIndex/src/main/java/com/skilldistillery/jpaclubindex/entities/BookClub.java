package com.skilldistillery.jpaclubindex.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name="book_club")
public class BookClub {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="max_members")
	private Integer maxMembers;
	
	@Column(name="create_date")
	private LocalDateTime createDate;
	
	private Boolean digital;
	
	@Column(name="profile_url")
	private String profileUrl;
	
	@Column(name="about_club")
	private String aboutClub;
	
	private String name;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany
	@JoinTable(name="book_club_genre",
	joinColumns=@JoinColumn(name="book_club_id"),
	inverseJoinColumns=@JoinColumn(name="genre_id"))
	private List<Genre> genres;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany
	@JoinTable(name="book_club_members",
	joinColumns=@JoinColumn(name="book_club_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> users;

	@OneToOne
	@JoinColumn(name="owner_id")
	private User owner;
	
	@OneToMany(mappedBy = "bookClub")
	private List<BookClubReadingList> readingLists;
	
	public BookClub() {}
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getMaxMembers() {
		return maxMembers;
	}

	public void setMaxMembers(Integer maxMembers) {
		this.maxMembers = maxMembers;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public Boolean getDigital() {
		return digital;
	}

	public void setDigital(Boolean digital) {
		this.digital = digital;
	}

	public String getProfileUrl() {
		return profileUrl;
	}

	public void setProfileUrl(String profileUrl) {
		this.profileUrl = profileUrl;
	}

	public String getAboutClub() {
		return aboutClub;
	}

	public void setAboutClub(String aboutClub) {
		this.aboutClub = aboutClub;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookClub other = (BookClub) obj;
		return id == other.id;
	}
	
	public void addGenre(Genre genre) {
		if(genres == null) {
			genres = new ArrayList<>();
		}
		
		if(!genres.contains(genre)) {
			genres.add(genre);
			genre.addBookClub(this);
		}
	}
	
	public void removeGenre(Genre genre) {
		if(genres != null && genres.contains(genre)) {
			genres.remove(genre);
			genre.removeBookClub(this);
		}
	}
	
	public void addUser(User user) {
		if(users == null) {
			users = new ArrayList<>();
		}
		
		if(!users.contains(user)) {
			users.add(user);
			user.addBookClub(this);
		}
	}
	
	public void removeUser(User user) {
		if(users != null && users.contains(user)) {
			users.remove(user);
			user.removeBookClub(this);
		}
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public List<BookClubReadingList> getReadingLists() {
		return readingLists;
	}

	public void setReadingLists(List<BookClubReadingList> readingLists) {
		this.readingLists = readingLists;
	}
	
	public void addReadingList(BookClubReadingList readingList) {
		if(readingLists == null) {
			readingLists = new ArrayList<>();
		}
		
		if(!readingLists.contains(readingList)) {
			readingLists.add(readingList);
		}
		readingList.setBookClub(this);
	}
	
	public void removeReadingList(BookClubReadingList readingList) {
		readingList.setBookClub(null);
		if(readingLists.contains(readingList)) {
			readingLists.remove(readingList);
		}
	}
}
