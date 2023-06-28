package com.wou.hifiusedcar.service;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.wou.hifiusedcar.entity.Role;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.repository.RoleRepository;
import com.wou.hifiusedcar.repository.UserRepository;

@Service
@Transactional
public class UserService {
	@Autowired
	private UserRepository repository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	/**
     * Find a user by its email.
     *
     * @param email the email of the user to be found
     * @return an Optional object containing the user if found, or an empty Optional if not found
     */
    public Optional<User> getByEmail(String email) {
        return repository.findByEmail(email);
    }

    /**
	 * Add the user.
	 *
	 * @param user the user to be created
	 * @return the created user object
	 */
    public User create(User user) {
		String rawPassword = user.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		user.setPassword(encodedPassword);
		Optional<Role> userRole = roleRepository.findByRoleName("USER");
		if (userRole.isPresent()) {
			Set<Role> roles = new HashSet<>();
			roles.add(userRole.get());
			user.setRoles(roles);
			return repository.save(user);
		} else {
			throw new IllegalArgumentException("Role USER not found");
		}
	}
}
