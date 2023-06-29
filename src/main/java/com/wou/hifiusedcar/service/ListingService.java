package com.wou.hifiusedcar.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

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
	 * Gets all the listings (car sale post) for past auction
	 *
	 * @return the list of all listings
	 */
	public List<Object[]> getListingsPastAuction() {
		return repository.findListingsPastAuction();
	}
}
