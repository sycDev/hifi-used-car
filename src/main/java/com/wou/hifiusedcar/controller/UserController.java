package com.wou.hifiusedcar.controller;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wou.hifiusedcar.entity.Role;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.service.RoleService;
import com.wou.hifiusedcar.service.UserService;
import com.wou.hifiusedcar.util.FormUtil;

@Controller
@RequestMapping("/dashboard")
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	/**
     * Displays the Manage Users page.
     *
     * @return the name of the view to display Manage Users page
     */
	@GetMapping("/users")
	public String showManageUsersPage(Model model) {
		List<User> userList = userService.getAllUsers();
		model.addAttribute("userList", userList);
		
		return "users";
	}
	
	/**
	 * Displays the edit existing user page.
	 *
	 * @return the Edit User page
	 */
	@GetMapping("/edit-user/{userId}")
	public ModelAndView showEditUserForm(@PathVariable Long userId) {
		ModelAndView mav = new ModelAndView();
        Optional<User> currentUser = userService.getByUserId(userId);
        if (currentUser.isPresent()) {
            User user = currentUser.get();
            List<Role> roleList = roleService.getAllRoles();
            mav.addObject("roleList", roleList);
            mav.addObject("user", user);
            mav.setViewName("editUser");
        } else {
            mav.setViewName("error");
            mav.addObject("errorMsg", "User not found");
        }
        return mav; 
	}
	
	/**
     * Update the user details
     *
     * @param user the User to be updated
     * @param result      the BindingResult object
     * @param redirectAttributes   the RedirectAttributes object
     * @return the Manage Users Page and message
     */
	@PostMapping("/user/update")
	public String updateStore(@Valid @ModelAttribute("user") User user,
            BindingResult result, RedirectAttributes redirectAttributes) {

		Optional<User> selectedUser = userService.getByUserId(user.getUserId());
		// If user record not exists
		if (!selectedUser.isPresent()) {
			redirectAttributes.addFlashAttribute("errorMsg", "Error occurred");
			return "redirect:/dashboard/users";
		}

		userService.update(user);

		// Add a success flash attribute
		redirectAttributes.addFlashAttribute("successMsg", "User updated successfully");
		
		return "redirect:/dashboard/users";
	}
	
	/**
     * Delete user record
     *
     * @param userId the user id to be deleted
     * @param redirectAttributes the RedirectAttributes object
     * @return the Manage Users page and message
     */
	@PostMapping("/user/delete")
	public String deleteUser(@RequestParam Long userId, RedirectAttributes redirectAttributes) {
		// Get the User object based on the id
		Optional<User> selectedUser = userService.getByUserId(userId);
		if (selectedUser.isPresent()) {
			// Pass the selected user id to Service to delete the record
			userService.deleteByUserId(userId);

			// Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "User deleted successfully");
            
            // Redirect to the Manage Users page
            return "redirect:/dashboard/users";
		} else {
			redirectAttributes.addFlashAttribute("errorMsg", "User not found");
            return "redirect:/error";
		}
	}
	
	/**
	 * Displays the register admin page.
	 *
	 * @return the Register Admin page
	 */
	@GetMapping("/register-admin")
	public String showRegisterAdminPage() {
		return "registerAdmin";
	}
	
	/**
     * Register new user with ADMIN role.
     *
     * @param user the user to be created
     * @param result the binding result
     * @param redirectAttributes the redirect attributes
     * @return the login page if successfully register
     */
    @PostMapping("/admin/register")
    public String registerAdmin(@Valid @ModelAttribute("user") User user, BindingResult result, 
    		RedirectAttributes redirectAttributes) {
    	
    	// If validation failed
    	if (FormUtil.checkValidation(result, redirectAttributes)) {
            return "redirect:/dashboard/register-admin";
        }
    	
    	// Check for existing user with same email address
    	Optional<User> existingUser = userService.getByEmail(user.getEmail());
    	if (existingUser.isPresent()) {
    		redirectAttributes.addFlashAttribute("errMsg", "Existing admin found.");
    		return "redirect:/dashboard/register-admin";
    	} else {
    		userService.create(user, "ADMIN");

    		// Add a success flash attribute
    		redirectAttributes.addFlashAttribute("successMsg", "Admin successfully registered!");
    		return "redirect:/dashboard/users";
    	}
    }
}
