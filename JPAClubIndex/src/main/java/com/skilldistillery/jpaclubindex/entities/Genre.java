package com.skilldistillery.jpaclubindex.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Genre {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	private String description;
	
	@ManyToMany
	@JoinTable(name="book_genre",
	joinColumns=@JoinColumn(name="genre_id"),
	inverseJoinColumns=@JoinColumn(name="book_isbn"))
	private List<Book> books;
	
	@ManyToMany(mappedBy="genres")
	private List<BookClub> bookClubs;
	
	public Genre() {}
	
	

	public List<BookClub> getBookClubs() {
		return bookClubs;
	}



	public void setBookClubs(List<BookClub> bookClubs) {
		this.bookClubs = bookClubs;
	}



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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
		Genre other = (Genre) obj;
		return id == other.id;
	}
	
	public void addBook(Book book) {
		if(books == null) {
			books = new ArrayList<>();
		}
		
		if(!books.contains(book)) {
			books.add(book);
			book.addGenre(this);
		}
	}
	
	public void removeBook(Book book) {
		if(books != null && books.contains(book)) {
			books.remove(book);
			book.removeGenre(this);
		}
	}
	
	public void addBookClub(BookClub bookClub) {
		if(bookClubs == null) {
			bookClubs = new ArrayList<>();
		}
		
		if(!bookClubs.contains(bookClub)) {
			bookClubs.add(bookClub);
			bookClub.addGenre(this);
		}
	}
	
	public void removeBookClub(BookClub bookClub) {
		if(bookClubs != null && bookClubs.contains(bookClub)) {
			bookClubs.remove(bookClub);
			bookClub.removeGenre(this);
		}
	}
	
	
}
