package com.wou.hifiusedcar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controller class for common web pages.
 */
@Controller
public class CommonController {
	/**
     * Displays the Home page.
     *
     * @return the name of the view to display Home page
     */
	@GetMapping("/")
	public String showHomePage() {
		return "index";
	}
	
	/**
     * Displays the About Us page.
     *
     * @return the name of the view to display About Us page
     */
	@GetMapping("/about")
	public String showAboutPage() {
		return "about";
	}
	
	/**
     * Displays the Contact Us page.
     *
     * @return the name of the view to display Contact Us page
     */
	@GetMapping("/contact")
	public String showContactPage() {
		return "contact";
	}
	
	/**
     * Displays the Terms of Use page.
     *
     * @return the name of the view to display Terms of Use page
     */
	@GetMapping("/terms-of-use")
	public String showTermsPage() {
		return "terms";
	}
	
	/**
     * Displays the Privacy Policy page.
     *
     * @return the name of the view to display Privacy Policy page
     */
	@GetMapping("/privacy-policy")
	public String showPolicyPage() {
		return "policy";
	}
}
