package com.wou.hifiusedcar.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wou.hifiusedcar.entity.Bid;
import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.repository.BidRepository;

@Service
@Transactional
public class BidService {
	@Autowired
	private BidRepository repository;
	
	/**
	 * Get all the bids
	 *
	 * @return the list of all the Bid
	 */
	public List<Bid> getAllBids() {
		return repository.findAll();
	}

	/**
	 * Gets the highest bid price.
	 *
	 * @param listing the listing
	 * @return the highest bid price
	 */
	public BigDecimal getHighestBidPrice(Listing listing) {
		return repository.findHighestBidPrice(listing);
	}
	
	/**
	 * Creates the bid
	 *
	 * @param bid the bid to be created
	 * @return the created bid object
	 */
	public Bid create(Bid bid) {
		return repository.save(bid);
	}
	
	/**
	 * Validate the bid
	 *
	 * @param bid the bid to be created
	 * @param listing the selected listing
	 * @param currentHighestBid the current highest bid of this selected listing
	 * @return the error message string, return null if no issue
	 */
	public String validateBid(Bid bid, Listing listing, BigDecimal currentHighestBid) {
		// Check bid amount must be positive value that greater than 0
		if (bid.getBidPrice().compareTo(BigDecimal.ZERO) <= 0) {
		    return "Bid amount must be a positive value greater than 0";
		}
		
		// Check if the listing is active
		if (!listing.getStatus().equalsIgnoreCase("Active")) {
            return "You can only bid on active listings";
        }

        // Check if the bidding for the listing has ended
        Date currentDateTime = new Date();
        if (listing.getEndTime().before(currentDateTime)) {
            return "Bidding for this listing has ended";
        }

        // Check if the user is the owner of the listing
        if (listing.getUser().equals(bid.getUser())) {
            return "The listing owner cannot place a bid";
        }

        if (currentHighestBid == null) {
            // No bids yet, check bid amount against minimum price
            if (bid.getBidPrice().compareTo(listing.getMinPrice()) < 0) {
                return "Your bid price must be higher than the minimum price";
            }
        } else {
            // Bids exist, check bid amount against current highest bid
            if (bid.getBidPrice().compareTo(currentHighestBid) <= 0) {
                return "Your bid price must be higher than the current highest bid";
            }
        }

        return null; // Bid is valid
    }
}
