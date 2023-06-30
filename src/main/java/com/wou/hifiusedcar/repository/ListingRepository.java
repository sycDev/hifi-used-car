package com.wou.hifiusedcar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.wou.hifiusedcar.entity.Listing;

@Repository
public interface ListingRepository extends JpaRepository<Listing, Long>{
	/**
	 * Finds a list of listing records 
	 * with the corresponding highest bid price
	 * excluded user id of current logged in user
	 * having status of active only
	 * not yet end
	 * sorted by ending soon first
	 *
	 * @param currentUserId the user id that logged in
	 * @return the list of all listings
	 */	
	@Query("SELECT l, (SELECT MAX(b2.bidPrice) FROM Bid b2 WHERE b2.listing = l) as highestBidPrice "
			+ "FROM Listing l LEFT JOIN l.bids b WHERE "
			+ "l.user.id <> :currentUserId AND "
			+ "l.status = 'Active' AND "
	        + "l.endTime > CURRENT_TIMESTAMP "
	        + "GROUP BY l "
	        + "ORDER BY ABS(TIMESTAMPDIFF(SECOND, l.endTime, CURRENT_TIMESTAMP))")
	List<Object[]> findListingsOnGoingAuction(@Param("currentUserId") Long currentUserId);
	
	/**
	 * Finds a list of listing records 
	 * with the corresponding highest bid price
	 * excluded user id of current logged in user
	 * not having status of inactive
	 * already ended
	 * sorted by recently ended first
	 *
	 * @param currentUserId the user id that logged in
	 * @return the list of all listings
	 */	
	@Query("SELECT l, (SELECT MAX(b2.bidPrice) FROM Bid b2 WHERE b2.listing = l) as highestBidPrice "
			+ "FROM Listing l LEFT JOIN l.bids b WHERE "
			+ "l.status <> 'Inactive' AND "
	        + "l.endTime < CURRENT_TIMESTAMP "
	        + "GROUP BY l "
	        + "ORDER BY ABS(TIMESTAMPDIFF(SECOND, l.endTime, CURRENT_TIMESTAMP))")
	List<Object[]> findListingsPastAuction();
}