package com.wou.hifiusedcar.auth;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.wou.hifiusedcar.controller.UserController;
import com.wou.hifiusedcar.repository.BidRepository;
import com.wou.hifiusedcar.repository.ListingRepository;
import com.wou.hifiusedcar.repository.RoleRepository;
import com.wou.hifiusedcar.repository.UserRepository;
import com.wou.hifiusedcar.security.SecurityConfig;

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
	
	@MockBean
	private ListingRepository listingRepository;

	@MockBean
	private BidRepository bidRepository;

	@Test
	@WithMockUser(roles = {"ADMIN"})
	public void whenAdminAccessManageUsersPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/users"))
	      .andExpect(status().isOk());
	}
	
	@Test
	@WithMockUser(roles = {"USER"})
	public void whenUserAccessManageUsersPage_thenIsForbidden() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/users"))
	      .andExpect(status().isForbidden());
	}
	
	@Test
	@WithMockUser(roles = {"USER"})
	public void whenUserAccessSecuredPostCarPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/sell-car"))
	      .andExpect(status().isOk());
	}
	
	@Test
	@WithMockUser(roles = {"USER"})
	public void whenUserAccessSecuredAuctionPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/auction"))
	      .andExpect(status().isOk());
	}
	
	@Test
	@WithMockUser(roles = {"USER"})
	public void whenUserAccessSecuredSearchPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/search"))
	      .andExpect(status().isOk());
	}
}
