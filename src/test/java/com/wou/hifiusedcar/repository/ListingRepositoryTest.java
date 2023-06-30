package com.wou.hifiusedcar.repository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.entity.User;

@DataJpaTest
@Rollback(true)
@AutoConfigureTestDatabase(replace = Replace.NONE)
@RunWith(SpringJUnit4ClassRunner.class)
public class ListingRepositoryTest {

	@Autowired
	private ListingRepository listingRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Test
	public void testCreateListing() {
		// Listing details
		String make = "Mercedes-Benz";
		String model = "E55 AMG";
		Integer regYear = 2000;
		String image = "mercedes1.jpg";
		Integer mileage = 55400;
		String description = "The W210-generation Mercedes-Benz E55 AMG is settling nicely into its new role as a young classic – "
				+ "not many of these were made, well-kept ones are becoming difficult to find, and values keep going up. I still have "
				+ "tremendously fond memories of the one I owned ten years ago, and I truly wish I had never sold it. This particular "
				+ "E55 AMG touts low mileage for one of these, a gorgeous two-tone interior, and no modifications.";
		BigDecimal minPrice = new BigDecimal("116700.00");
		LocalDateTime dateTime = LocalDateTime.parse("2023-06-30T12:00:00");
		Date endTime = Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());
		String status = "Active";
		// Retrieve the User account from database
		User seller = userRepository.findByEmail("alvin@gmail.com").get();
		
		// Create listing
		Listing listing = new Listing();
		listing.setMake(make);
		listing.setModel(model);
		listing.setRegYear(regYear);
		listing.setImage(image);
		listing.setMileage(mileage);
		listing.setDescription(description);
		listing.setMinPrice(minPrice);
		listing.setEndTime(endTime);
		listing.setStatus(status);
		listing.setUser(seller);

		// Save the listing to database
		Listing listingToCreate = listingRepository.save(listing);
		
		// Retrieve the listing from database
		Listing listingSaved = listingRepository.findById(listingToCreate.getListingId()).get();
		
		// Verify that the listing record is successfully saved
		assertThat(listingToCreate.getListingId()).isEqualTo(listingSaved.getListingId());
	}
}
