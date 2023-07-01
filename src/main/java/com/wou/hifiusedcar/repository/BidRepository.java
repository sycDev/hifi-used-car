package com.wou.hifiusedcar.repository;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.wou.hifiusedcar.entity.Bid;
import com.wou.hifiusedcar.entity.Listing;

@Repository
public interface BidRepository extends JpaRepository<Bid, Long>{
	/**
	 * Finds the highest bid price on a particular listing
	 *
	 * @param listing the Listing object
	 * @return the highest bid price
	 */	
	@Query("SELECT MAX(b.bidPrice) FROM Bid b WHERE b.listing = :listing")
	BigDecimal findHighestBidPrice(@Param("listing") Listing listing);
}
