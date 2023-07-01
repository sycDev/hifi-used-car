package com.wou.hifiusedcar.auth;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.wou.hifiusedcar.controller.CommonController;
import com.wou.hifiusedcar.repository.BidRepository;
import com.wou.hifiusedcar.repository.ListingRepository;
import com.wou.hifiusedcar.repository.RoleRepository;
import com.wou.hifiusedcar.repository.UserRepository;
import com.wou.hifiusedcar.security.SecurityConfig;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;

@WebMvcTest(CommonController.class)
@ComponentScan(basePackages = "com.wou.hifiusedcar")
@ContextConfiguration(classes = SecurityConfig.class)
@RunWith(SpringJUnit4ClassRunner.class)
public class CommonEndpointSecurityTest {
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
	@WithAnonymousUser
	public void whenAnonymousAccessLoginPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/signin"))
	      .andExpect(status().isOk());
	}
	
	@Test
	@WithAnonymousUser
	public void whenAnonymousAccessSignUpPage_thenIsOk() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/signup"))
	      .andExpect(status().isOk());
	}

	@Test
	@WithAnonymousUser
	public void whenAnonymousAccessSecuredSellCarPage_thenIsRedirected() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/sell-car"))
	      .andExpect(status().is3xxRedirection())
	      .andExpect(redirectedUrlPattern("**/signin"));
	}
	
	@Test
	@WithAnonymousUser
	public void whenAnonymousAccessSecuredAuctionPage_thenIsRedirected() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/auction"))
	      .andExpect(status().is3xxRedirection())
	      .andExpect(redirectedUrlPattern("**/signin"));
	}
	
	@Test
	@WithAnonymousUser
	public void whenAnonymousAccessAdminSecuredEndpoint_thenIsRedirected() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/dashboard/**"))
	      .andExpect(status().is3xxRedirection())
	      .andExpect(redirectedUrlPattern("**/signin"));
	}
}
