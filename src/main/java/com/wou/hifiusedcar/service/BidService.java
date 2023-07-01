package com.wou.hifiusedcar.service;

import java.math.BigDecimal;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.repository.BidRepository;

@Service
@Transactional
public class BidService {
	@Autowired
	private BidRepository repository;

	/**
	 * Gets the highest bid price.
	 *
	 * @param listing the listing
	 * @return the highest bid price
	 */
	public BigDecimal getHighestBidPrice(Listing listing) {
		return repository.findHighestBidPrice(listing);
	}
}
