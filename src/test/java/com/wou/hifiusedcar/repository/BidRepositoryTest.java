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
import java.util.Optional;

import com.wou.hifiusedcar.entity.Bid;
import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.entity.User;

@DataJpaTest
@Rollback(true)
@AutoConfigureTestDatabase(replace = Replace.NONE)
@RunWith(SpringJUnit4ClassRunner.class)
public class BidRepositoryTest {

	@Autowired
	private BidRepository bidRepository;

	@Autowired
	private ListingRepository listingRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Test
	public void testCreateBid() {
		// Bid details
		BigDecimal bidPrice = new BigDecimal("32000.00");
		// Retrieve the Listing to bid from database
		Optional<Listing> listing = listingRepository.findById((long) 1);
		
		if (!listing.isPresent()) {
			throw new IllegalArgumentException("Listing record not found");
		} else {
			Listing listingToBid = listing.get();

			// Retrieve the User account from database
			User bidder = userRepository.findByEmail("alvin@gmail.com").get();
			
			// Create bid
			Bid bid = new Bid();
			bid.setBidPrice(bidPrice);
			bid.setListing(listingToBid);
			bid.setUser(bidder);

			// Save the bid to database
			Bid bidToCreate = bidRepository.save(bid);
			
			// Retrieve the bid from database
			Bid bidSaved = bidRepository.findById(bidToCreate.getBidId()).get();
			
			// Verify that the bid record is successfully saved
			assertThat(bidToCreate.getBidId()).isEqualTo(bidSaved.getBidId());
		}
	}
}
