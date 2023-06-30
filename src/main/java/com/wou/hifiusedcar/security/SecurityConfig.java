package com.wou.hifiusedcar.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	@Bean
	public UserDetailsService userDetailsService() {
		return new UserDetailsServiceImpl();
	}

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		
		authProvider.setUserDetailsService(userDetailsService());
		authProvider.setPasswordEncoder(passwordEncoder());
		
		return authProvider;
	}
	
	@Bean
	public SecurityFilterChain configure(HttpSecurity http) throws Exception {
		http
			.sessionManagement()
				.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
				.maximumSessions(1)
				.expiredUrl("/signin?expired=true");
		
		http
			.authorizeRequests()
				.antMatchers("/assets/**").permitAll()
	            .antMatchers("/css/**").permitAll()
	            .antMatchers("/js/**").permitAll()
				.antMatchers(HttpMethod.GET, "/").permitAll()
				.antMatchers(HttpMethod.GET, "/about").permitAll()
				.antMatchers(HttpMethod.GET, "/contact").permitAll()
				.antMatchers(HttpMethod.GET, "/terms-of-use").permitAll()
				.antMatchers(HttpMethod.GET, "/privacy-policy").permitAll()
				.antMatchers(HttpMethod.GET, "/error").permitAll()
				.antMatchers(HttpMethod.GET, "/signup").permitAll()
				.antMatchers(HttpMethod.POST, "/register").permitAll()
				.antMatchers(HttpMethod.GET, "/sell-car", "/my-listings").hasAuthority("USER")
				.antMatchers(HttpMethod.POST, "/listing/add", "/listing/updateStatus").hasAuthority("USER")
				.antMatchers(HttpMethod.GET, "/auction", "/past-auction", "/listing/**", "/search").hasAnyAuthority("USER", "ADMIN")
				.antMatchers(HttpMethod.GET, "/dashboard/**").hasAuthority("ADMIN")
				.and()
			.formLogin()
				.loginPage("/signin")
				.usernameParameter("email")
				.loginProcessingUrl("/login")
				.failureUrl("/signin?error")
				.defaultSuccessUrl("/auction", true)
				.permitAll()
				.and()
			.csrf()
				.and()
			.logout()
				.logoutUrl("/logout")
				.logoutSuccessUrl("/signin?logout")
				.permitAll();
		
		return http.build();
	}
}
