package com.wou.hifiusedcar.service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
	 * Get all the users
	 *
	 * @return the list of all the User
	 */
	public List<User> getAllUsers() {
		return repository.findAll();
	}
	
	/**
     * Find a user by its ID.
     *
     * @param userId the ID of the user to be found
     * @return an Optional object containing the user if found, or an empty Optional if not found
     */
    public Optional<User> getByUserId(Long userId) {
        return repository.findById(userId);
    }
    
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
	 * Find the current logged-in user
	 *
	 * @return the logged-in user
	 */
	public Optional<User> findByCurrentUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.isAuthenticated()) {
			String email = authentication.getName();
			return repository.findByEmail(email);
		}

		return Optional.empty();
	}

    /**
	 * Create the user.
	 *
	 * @param user the user to be created
	 * @return the created user object
	 */
    public User create(User user, String role) {
		String rawPassword = user.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		user.setPassword(encodedPassword);
		
		Optional<Role> userRole = roleRepository.findByRoleName(role);
		
		if (userRole.isPresent()) {
			Set<Role> roles = new HashSet<>();
			roles.add(userRole.get());
			user.setRoles(roles);

			return repository.save(user);
		} else {
			throw new IllegalArgumentException("Role " + role + " not found");
		}
	}
    
    /**
	 * Updates the given user with the new information.
	 *
	 * @param updatedUser the updated user object
	 */
	public void update(User updatedUser) {
		Optional<User> currentUser = repository.findById(updatedUser.getUserId());

		if (currentUser.isPresent()) {
			User user = currentUser.get();
			user.setUsername(updatedUser.getUsername());
			user.setRoles(updatedUser.getRoles());
			repository.save(user);
		}
	}
	
	/**
     * Delete an user by its id.
     *
     * @param userId the id of the user to be delete
     */
	public void deleteByUserId(Long userId) {
		repository.deleteById(userId);
	}
}
