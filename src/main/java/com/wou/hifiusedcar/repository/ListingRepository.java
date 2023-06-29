package com.wou.hifiusedcar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.wou.hifiusedcar.entity.Listing;

@Repository
public interface ListingRepository extends JpaRepository<Listing, Long>{

}
