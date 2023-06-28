package com.wou.hifiusedcar.auth;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.wou.hifiusedcar.controller.UserController;
import com.wou.hifiusedcar.repository.RoleRepository;
import com.wou.hifiusedcar.repository.UserRepository;
import com.wou.hifiusedcar.security.SecurityConfig;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(UserController.class)
@ComponentScan(basePackages = "com.wou.hifiusedcar")
@ContextConfiguration(classes = SecurityConfig.class)
@RunWith(SpringJUnit4ClassRunner.class)
public class UserEndpointSecurityTest {
	@Autowired
	private MockMvc mockMvc;
	
	@MockBean
	private UserRepository userRepository;
	
	@MockBean
	private RoleRepository roleRepository;
	
	@Test
	@WithMockUser(authorities = {"ADMIN"})
	public void whenAdminAccessManageUsersPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/users"))
	      .andExpect(status().isOk());
	}
	
	@Test
	@WithMockUser(authorities = {"USER"})
	public void whenUserAccessManageUsersPage_thenIsForbidden() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/users"))
	      .andExpect(status().isForbidden());
	}
	
	@Test
	@WithAnonymousUser
	public void whenAnonymousAccessSecuredManageUsersPage_thenIsRedirected() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/users"))
	      .andExpect(status().is3xxRedirection())
	      .andExpect(redirectedUrlPattern("**/signin"));
	}
}
