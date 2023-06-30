package com.wou.hifiusedcar.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.exception.ListingNotFoundException;
import com.wou.hifiusedcar.repository.ListingRepository;

import org.springframework.stereotype.Service;

@Service
@Transactional
public class ListingService {
	@Autowired
	private ListingRepository repository;
	
	/**
	 * Gets all the listings (car sale post) for ongoing auction
	 *
	 * @return the list of all listings
	 */
	public List<Object[]> getListingsOnGoingAuction(Long currentUserId) {
		return repository.findListingsOnGoingAuction(currentUserId);
	}
	
	/**
	 * Gets all the listings for past auction
	 *
	 * @return the list of all listings
	 */
	public List<Object[]> getListingsPastAuction() {
		return repository.findListingsPastAuction();
	}
	
	/**
	 * Gets all the listings that created by current logged in user
	 *
	 * @return the list of all listings
	 */
	public List<Object[]> getMyListings(Long currentUserId) {
		return repository.findMyListings(currentUserId);
	}
	
	/**
     * Find a listing by its ID
     *
     * @param listingId the ID of the listing to be found
     * @return an Optional object containing the listing if found, or an empty Optional if not found
     */
    public Optional<Listing> getByListingId(Long listingId) {
        return repository.findById(listingId);
    }

	/**
	 * Creates the listing
	 *
	 * @param listing the listing to be created
	 * @return the created listing object
	 */
	public Listing create(Listing listing) {
		return repository.save(listing);
	}
	
    /**
     * Update status of particular listing
     *
     * @param listingId the listing id to be updated
     */
    public void updateStatus(Long listingId) {
        // Retrieve the original status
        Optional<Listing> listing = repository.findById(listingId);
        
        if (!listing.isPresent()) {
            throw new ListingNotFoundException();
        }

        Listing listingToUpdate = listing.get();
        String originalStatus = listingToUpdate.getStatus();
        String updatedStatus = "";
        if (originalStatus.matches("Active")) {
            updatedStatus = "Inactive";
        } else if (originalStatus.matches("Inactive")) {
            updatedStatus = "Active";
        } else {
            throw new IllegalArgumentException("Invalid status to update");
        }
        
        listingToUpdate.setStatus(updatedStatus);
        repository.save(listingToUpdate);
    }
}
