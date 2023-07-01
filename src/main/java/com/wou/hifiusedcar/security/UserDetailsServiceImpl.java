package com.wou.hifiusedcar.security;

import java.util.Optional;

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
		
		for (Role role: savedUser.get().getRoles()) {
			System.out.println("Role: " + role.getRoleName());
		}

		return new CustomUserDetails(savedUser.get());
	}
}
