package com.wou.hifiusedcar.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.wou.hifiusedcar.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Long>{
	/**
	 * Retrieves an optional Role entity by its role name.
	 * 
	 * @param roleName the name of the role
	 * @return an Optional containing the Role entity if found, or an empty Optional if not found
	 */
	@Query("SELECT r FROM Role r WHERE r.roleName=:roleName")
	public Optional<Role> findByRoleName(@Param("roleName") String roleName);
}
