package com.wou.hifiusedcar.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.wou.hifiusedcar.entity.User;

public interface UserRepository extends JpaRepository<User, Long>{
	/**
	 * Retrieves an optional User entity by its email.
	 * 
	 * @param email the email of the user
	 * @return an Optional containing the User entity if found, or an empty Optional if not found
	 */
	@Query("SELECT u FROM User u where u.email = :email")
	public Optional<User> findByEmail(@Param("email") String email);
}
