package com.wou.hifiusedcar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	@GetMapping("/dashboard")
	public String showDashboardHomePage() {
		return "dashboard";
	}
	
	/**
     * Displays the Manage Users page.
     *
     * @return the name of the view to display Manage Users page
     */
	@GetMapping("/dashboard/users")
	public String showManageUsersPage() {
		return "users";
	}
}
