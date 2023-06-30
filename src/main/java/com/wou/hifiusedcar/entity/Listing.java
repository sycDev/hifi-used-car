package com.wou.hifiusedcar.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "listing")
public class Listing {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "listing_id", nullable = false)
    private Long listingId;

	@NotBlank(message = "Make is required")
	@Size(max = 30, message = "Make must not exceed 30 characters")
	private String make;

	@NotBlank(message = "Model is required")
	@Size(max = 50, message = "Model must not exceed 50 characters")
	private String model;

	@NotNull(message = "Registration year is required")
	@Column(name = "reg_year", nullable = false)
	private Integer regYear;

	@Size(max = 64)
    private String image;

	@Transient
    private MultipartFile imageFile;

	@NotNull(message = "Milleage is required")
	@Min(value = 0, message = "Mileage must be a non-negative value")
	private Integer milleage;

	@Type(type = "text")
	@Column(name = "description", nullable = true)
    private String description;

	@DecimalMin(value = "1.00")
	@Column(name = "min_price", nullable = false)
	private BigDecimal minPrice;

	@NotNull(message = "End time is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	@Column(name = "end_time", nullable = false)
    private Date endTime;

	@NotBlank(message = "Status is required")
	@Size(max = 20, message = "Status must not exceed 20 characters")
	private String status;

	@CreationTimestamp
	@Column(name = "created_at", nullable = false)
	private Date createdAt;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@OneToMany(mappedBy = "listing", cascade = CascadeType.ALL)
	private Set<Bid> bids = new HashSet<>();

	public Long getListingId() {
		return listingId;
	}

	public void setListingId(Long listingId) {
		this.listingId = listingId;
	}

	public String getMake() {
		return make;
	}

	public void setMake(String make) {
		this.make = make;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public int getRegYear() {
		return regYear;
	}

	public void setRegYear(int regYear) {
		this.regYear = regYear;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public MultipartFile getImageFile() {
		return imageFile;
	}

	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

	public int getMilleage() {
		return milleage;
	}

	public void setMilleage(int milleage) {
		this.milleage = milleage;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(BigDecimal minPrice) {
		this.minPrice = minPrice;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Set<Bid> getBids() {
		return bids;
	}

	public void setBids(Set<Bid> bids) {
		this.bids = bids;
	}
}
