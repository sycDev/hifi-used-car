package com.wou.hifiusedcar.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Bean
	public UserDetailsService userDetailsService() {
		return new UserDetailsServiceImpl();
	}

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService())
        	.passwordEncoder(passwordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.sessionManagement()
				.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
				.maximumSessions(1)
				.expiredUrl("/signin?expired=true");
		
		http.authorizeRequests()
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

				.antMatchers(HttpMethod.GET, "/sell-car", "/my-listings").hasRole("USER")
				.antMatchers(HttpMethod.POST, "/listing/add", "/listing/updateStatus").hasRole("USER")
				.antMatchers(HttpMethod.POST, "/bid/add").hasRole("USER")

				.antMatchers(HttpMethod.GET, "/auction", "/past-auction", "/listing/**", "/search").hasAnyRole("USER", "ADMIN")

				.antMatchers(HttpMethod.GET, "/dashboard/**").hasRole("ADMIN")
				.antMatchers(HttpMethod.POST, "/dashboard/**").hasRole("ADMIN")
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
	}
}
