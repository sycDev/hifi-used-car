package com.wou.hifiusedcar.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wou.hifiusedcar.entity.Role;
import com.wou.hifiusedcar.repository.RoleRepository;

@Service
@Transactional
public class RoleService {
	@Autowired
	private RoleRepository repository;

	/**
	 * Get all the roles
	 *
	 * @return the list of all the Role
	 */
	public List<Role> getAllRoles() {
		return repository.findAll();
	}
}
