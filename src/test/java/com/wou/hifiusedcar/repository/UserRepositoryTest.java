package com.wou.hifiusedcar.repository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.HashSet;
import java.util.Set;

import com.wou.hifiusedcar.entity.Role;
import com.wou.hifiusedcar.entity.User;

@DataJpaTest
@Rollback(true)
@AutoConfigureTestDatabase(replace = Replace.NONE)
@RunWith(SpringJUnit4ClassRunner.class)
public class UserRepositoryTest {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Test
	public void testCreateAdmin() {
		// Administrator account details
		String email = "admin@hificars.com";
		String username = "admin";
		String rawPassword = "Admin123";
		PasswordEncoder passEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passEncoder.encode(rawPassword);

		// Create Administrator account
		User admin = new User();
		admin.setEmail(email);
		admin.setUsername(username);
		admin.setPassword(encodedPassword);
		
		// Save Administrator account to database
		User adminToCreate = userRepository.save(admin);
		
		// Retrieve the Administrator account from database
		User adminSaved = userRepository.findByEmail(email).get();
		
		// Verify that the Administrator account is successfully saved
		assertThat(adminToCreate.getEmail()).isEqualTo(adminSaved.getEmail());
	}

	@Test
	public void testRoleAssignToAdmin() {
		// Retrieve the Administrator account from database
		User admin = userRepository.findByEmail("admin@hificars.com").get();
		
		// Retrieve ADMIN role from database
		Set<Role> roles = new HashSet<>();
		Role adminRole = roleRepository.findByRoleName("ADMIN").get();
		roles.add(adminRole);

		// Set ADMIN role for Administrator account
		admin.setRoles(roles);

		// Verify that the ADMIN role is successfully assigned
		assertThat(admin.getRoles().size()).isEqualTo(1);
	}
}
