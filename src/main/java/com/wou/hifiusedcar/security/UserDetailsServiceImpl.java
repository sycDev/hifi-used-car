package com.wou.hifiusedcar.security;

import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.wou.hifiusedcar.entity.Role;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.repository.UserRepository;

public class UserDetailsServiceImpl implements UserDetailsService {
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		Optional<User> savedUser = userRepository.findByEmail(email);

		if (!savedUser.isPresent()) {
            throw new UsernameNotFoundException("Login user " + email + " is not valid. Please re-enter.");
        }
		
		org.springframework.security.core.userdetails.User.UserBuilder userBuilder = 
        		org.springframework.security.core.userdetails.User.builder();
		
		User user = savedUser.get();
        Set<Role> roles = user.getRoles();
        String[] roleNames = roles.stream()
								.map(Role::getRoleName)
								.toArray(String[]::new);
		
        for (String role : roleNames) {
        	System.out.println("Role Name is " + role);
		}

		return userBuilder.username(user.getEmail())
        		.password(user.getPassword())
        		.roles(roleNames)
        		.build();
	}
}
