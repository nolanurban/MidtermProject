package com.skilldistillery.jpaclubindex.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String isbn;
	
	@Column(name="publish_year")
	private int publishYear;
	
	private Integer pages;
	private String title;
	private String description;
	
	@Column(name="cover_url")
	private String coverUrl;
	
	@OneToMany(mappedBy="book")
	private List<Review> reviews;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany(mappedBy="books")
	private List<Author> authors;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany(mappedBy="books")
	private List<Genre> genres;
	
	@ManyToMany(mappedBy="books")
	private List<UserReadingList> userReadingLists;

	@ManyToMany(mappedBy="books")
	private List<BookClubReadingList> bcReadingLists;
	
	public Book() {}

	public void setUserReadingLists(List<UserReadingList> readingLists) {
		this.userReadingLists = readingLists;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}
	
	public List<Author> getAuthors() {
		return authors;
	}

	public void setAuthors(List<Author> authors) {
		this.authors = authors;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public int getPublishYear() {
		return publishYear;
	}

	public void setPublishYear(int publishYear) {
		this.publishYear = publishYear;
	}

	public Integer getPages() {
		return pages;
	}

	public void setPages(Integer pages) {
		this.pages = pages;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCoverUrl() {
		return coverUrl;
	}

	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}

	@Override
	public int hashCode() {
		return Objects.hash(isbn);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return Objects.equals(isbn, other.isbn);
	}
	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}
	public void addReview(Review review) {
		if (reviews == null) reviews = new ArrayList<>();
		if (!reviews.contains(review)) {
			reviews.add(review);
		}
		review.setBook(this);
	}
	public void removeReview(Review review) {
		review.setBook(null);
		if (reviews != null && reviews.contains(review)) {
			reviews.remove(review);
		}
	}

	public void addAuthor(Author author) {
		if(authors == null) {
			authors = new ArrayList<>();
		}
		
		if(!authors.contains(author)) {
			authors.add(author);
			author.addBook(this);
		}
	}
	
	public void removeAuthor(Author author) {
		if(authors != null && authors.contains(author)) {
			authors.remove(author);
			author.removeBook(this);
		}

	}
	
	public void addGenre(Genre genre) {
		if(genres == null) {
			genres = new ArrayList<>();
		}
		
		if(!genres.contains(genre)) {
			genres.add(genre);
			genre.addBook(this);
		}
	}
	
	public void removeGenre(Genre genre) {
		if(genres != null && genres.contains(genre)) {
			genres.remove(genre);
			genre.removeBook(this);
		}

	}
	
	public void addReadingList(BookClubReadingList readingList) {
		if(bcReadingLists == null) {
			bcReadingLists = new ArrayList<>();
		}
		
		if(!bcReadingLists.contains(readingList)) {
			bcReadingLists.add(readingList);
			readingList.addBook(this);
		}
	}
	
	public void removeReadingList(BookClubReadingList readingList) {
		if(bcReadingLists != null && bcReadingLists.contains(readingList)) {
			bcReadingLists.remove(readingList);
			readingList.removeBook(this);
		}

	}
	
	public void addReadingList(UserReadingList readingList) {
		if(userReadingLists == null) {
			userReadingLists = new ArrayList<>();
		}
		
		if(!userReadingLists.contains(readingList)) {
			userReadingLists.add(readingList);
			readingList.addBook(this);
		}
	}
	
	public void removeReadingList(UserReadingList readingList) {
		if(userReadingLists != null && userReadingLists.contains(readingList)) {
			userReadingLists.remove(readingList);
			readingList.removeBook(this);
		}
		
	}

	public List<BookClubReadingList> getBcReadingLists() {
		return bcReadingLists;
	}

	public void setBcReadingLists(List<BookClubReadingList> bcReadingLists) {
		this.bcReadingLists = bcReadingLists;
	}

	public List<UserReadingList> getUserReadingLists() {
		return userReadingLists;
	}
	
	
	
}
