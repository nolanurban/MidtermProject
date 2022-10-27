package com.skilldistillery.jpaclubindex.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name="user_reading_list")
public class UserReadingList{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany
	@JoinTable(name="user_book_list",
	joinColumns=@JoinColumn(name="reading_list_id"),
	inverseJoinColumns=@JoinColumn(name="book_isbn"))
	private List<Book> books;
	
	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
	@JoinColumn(name="user_id")
	private User user;

	public UserReadingList() {}

	public int getId() {
		return id;
	}

	public List<Book> getBooks() {
		return books;
	}
	
	public void setBooks(List<Book> books) {
		this.books = books;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
		UserReadingList other = (UserReadingList) obj;
		return id == other.id;
	}
	
	public void addBook(Book book) {
		if(books == null) {
			books = new ArrayList<>();
		}
		
		if(!books.contains(book)) {
			books.add(book);
			book.addReadingList(this);
		}
	}
	
	public void removeBook(Book book) {
		if(books != null && books.contains(book)) {
			books.remove(book);
			book.removeReadingList(this);
		}
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
}
