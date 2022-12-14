package com.skilldistillery.jpaclubindex.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;



@Entity
public class Author {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String biography;
	
	@Column(name="websiter_url")
	private String websiteUrl;
	
	@Column(name="headshot_url")
	private String headshotUrl;
	
	@ManyToMany
	@JoinTable(name="author_book",
	joinColumns=@JoinColumn(name="author_id"),
	inverseJoinColumns=@JoinColumn(name="book_isbn"))
	private List<Book> books;
	
	public Author() {}
	
	

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public String getWebsiteUrl() {
		return websiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl) {
		this.websiteUrl = websiteUrl;
	}

	public String getHeadshotUrl() {
		return headshotUrl;
	}

	public void setHeadshotUrl(String headshotUrl) {
		this.headshotUrl = headshotUrl;
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
		Author other = (Author) obj;
		return id == other.id;
	}
	
	public void addBook(Book book) {
		if(books == null) {
			books = new ArrayList<>();
		}
		
		if(!books.contains(book)) {
			books.add(book);
			book.addAuthor(this);
		}
	}
	
	public void removeBook(Book book) {
		if(books != null && books.contains(book)) {
			books.remove(book);
			book.removeAuthor(this);
		}
	}
	
}
