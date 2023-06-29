package com.wou.hifiusedcar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.wou.hifiusedcar.entity.Bid;

@Repository
public interface BidRepository extends JpaRepository<Bid, Long>{

}
