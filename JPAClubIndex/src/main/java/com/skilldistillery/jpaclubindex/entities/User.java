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
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name="first_name")
	private String firstName;
	@Column(name="last_name")
	private String lastName;
	private String username;
	private String email;
	private String password;
	private Boolean enabled;
	
	private String role;
	@Column(name="profile_url")
	private String profileUrl;
	@Column(name="about_me")
	private String aboutMe;
	@OneToOne
	@JoinColumn(name="location_id")
	private Location location;
	
	@ManyToMany(mappedBy="users")
	private List<BookClub> bookClubs;
//	@ManyToMany
//	
//	private BookClub bookClub;
//
	@OneToMany(mappedBy="user")
	private List<Review> reviews;
	
	public User() {
		
	}
	
	

	public List<BookClub> getBookClubs() {
		return bookClubs;
	}



	public void setBookClubs(List<BookClub> bookClubs) {
		this.bookClubs = bookClubs;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getProfileUrl() {
		return profileUrl;
	}

	public void setProfileUrl(String profileUrl) {
		this.profileUrl = profileUrl;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", email=" + email + "]";
	}

	public Location getLocation() {
		return location;
	}
	
	public void setLocation(Location location) {
		this.location = location;
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
		review.setUser(this);
	}
	public void removeRemove(Review review) {
		review.setUser(null);
		if (reviews != null && reviews.contains(review)) {
			reviews.remove(review);
		}
	}

	public void addBookClub(BookClub bookClub) {
		if (bookClubs == null) bookClubs = new ArrayList<>();
		if (!bookClubs.contains(bookClub)) {
			bookClubs.add(bookClub);
			bookClub.addUser(this);
		}
	}
	public void removeBookClub(BookClub bookClub) {
		if (bookClubs != null && bookClubs.contains(bookClub)) {
			bookClubs.remove(bookClub);
			bookClub.removeUser(this);
		}

	}
}
