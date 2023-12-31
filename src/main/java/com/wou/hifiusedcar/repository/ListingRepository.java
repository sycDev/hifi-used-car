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
	 * sorted by recently ending first
	 * then followed by already expired
	 *
	 * @return the list of all listings
	 */	
	@Query("SELECT l, (SELECT MAX(b2.bidPrice) FROM Bid b2 WHERE b2.listing = l) as highestBidPrice "
			+ "FROM Listing l LEFT JOIN l.bids b "
	        + "GROUP BY l "
	        + "ORDER BY CASE WHEN l.endTime < CURRENT_TIMESTAMP THEN 1 ELSE 0 END, "
	        + "ABS(TIMESTAMPDIFF(SECOND, l.endTime, CURRENT_TIMESTAMP))")
	List<Object[]> findAllListings();

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
	
	/**
	 * Finds a list of listing records that created by the current logged in user
	 * with the corresponding highest bid price
	 * sorted by the sequence of status "Active", "Sold" and "Inactive"
	 * sorted by recently ended first
	 *
	 * @param currentUserId the user id that logged in
	 * @return the list of all listings
	 */	
	@Query("SELECT l, (SELECT MAX(b2.bidPrice) FROM Bid b2 WHERE b2.listing = l) as highestBidPrice "
			+ "FROM Listing l LEFT JOIN l.bids b WHERE "
			+ "l.user.id = :currentUserId "
	        + "GROUP BY l "
	        + "ORDER BY "
	        + "CASE WHEN l.status = 'Active' THEN 1 "
	        + 		"WHEN l.status = 'Sold' THEN 2 "
	        + 		"WHEN l.status = 'Inactive' THEN 3 "
	        + 		"ELSE 4 END, "
	        + "ABS(TIMESTAMPDIFF(SECOND, l.endTime, CURRENT_TIMESTAMP))")
	List<Object[]> findMyListings(@Param("currentUserId") Long currentUserId);
  
  /**
	 * Searches for listings based on a keyword 
	 * (Make or Model or RegYear, RegYear Make Model, Make Model) 
	 * not having status of inactive 
	 * excluded user id of current logged in user
	 * sorted by recently end
	 * 
	 * @param keyword the keyword to search for
	 * @return a list of listings matching the keyword
	*/
	@Query("SELECT l , (SELECT MAX(b2.bidPrice) FROM Bid b2 WHERE b2.listing = l) as highestBidPrice "
			+ "FROM Listing l LEFT JOIN l.bids b "
			+ "WHERE l.status <> 'Inactive' AND "
			+ "l.user.id <> :currentUserId AND "
            + "(l.make LIKE CONCAT('%', :keyword, '%') OR "
            + "l.model LIKE CONCAT('%', :keyword, '%') OR "
            + "CAST(l.regYear AS string) LIKE %:keyword% OR "
            + "CONCAT(l.regYear, ' ', l.make, ' ', l.model) LIKE %:keyword% OR "
            + "CONCAT(l.make, ' ', l.model) LIKE %:keyword%) AND "
            + "TRIM(:keyword) != '' "
            + "GROUP BY l "
            + "ORDER BY ABS(TIMESTAMPDIFF(SECOND, l.endTime, CURRENT_TIMESTAMP))")
	List<Object[]> search(@Param("currentUserId") Long currentUserId, @Param("keyword") String keyword);
}
