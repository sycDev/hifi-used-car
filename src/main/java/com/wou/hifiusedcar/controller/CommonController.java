package com.wou.hifiusedcar.controller;

import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.util.FormUtil;
import com.wou.hifiusedcar.service.UserService;

/**
 * Controller class for common web pages.
 */
@Controller
public class CommonController {
	@Autowired
	private UserService userService;

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
	
	/**
     * Displays the Login page.
     *
     * @return the name of the view to display Login page
     */
    @GetMapping("/signin")
    public String showLoginPage() {
        return "login";
    }
    
    /**
     * Displays the Sign Up page.
     *
     * @return the name of the view to display Sign Up page
     */
    @GetMapping("/signup")
    public String showSignUpPage() {
        return "signup";
    }
    
    /**
     * Register new user with USER role.
     *
     * @param user the user to be created
     * @param result the binding result
     * @param redirectAttributes the redirect attributes
     * @return the login page if successfully register
     */
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, 
    		RedirectAttributes redirectAttributes) {
    	
    	// If validation failed
    	if (FormUtil.checkValidation(result, redirectAttributes)) {
            return "redirect:/signup";
        }
    	
    	// Check for existing user with same email address
    	Optional<User> existingUser = userService.getByEmail(user.getEmail());
    	if (existingUser.isPresent()) {
    		redirectAttributes.addFlashAttribute("errMsg", "Existing user found.");
    		return "redirect:/signup";
    	} else {
    		userService.create(user);
    		// Add a success flash attribute
    		redirectAttributes.addFlashAttribute("successMsg", "Account successfully signed up!");
    		return "redirect:/signin";
    	}
    }
}
