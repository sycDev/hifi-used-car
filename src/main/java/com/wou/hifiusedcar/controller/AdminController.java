package com.wou.hifiusedcar.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.wou.hifiusedcar.entity.Bid;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.service.BidService;
import com.wou.hifiusedcar.service.ListingService;
import com.wou.hifiusedcar.service.UserService;

@Controller
@RequestMapping("/dashboard")
public class AdminController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private ListingService listingService;
	
	@Autowired
	private BidService bidService;
	
	/**
     * Displays the Admin Dashboard page.
     *
     * @return the name of the view to display Admin Dashboard page
     */
	@GetMapping("")
	public String showDashboardHomePage(Model model) {
		List<User> userList = userService.getAllUsers();
		List<Object[]> listingList = listingService.getAllListings();
		List<Bid> bidList = bidService.getAllBids();
		
		model.addAttribute("totalUsers", userList.size());
		model.addAttribute("totalListings", listingList.size());
		model.addAttribute("totalBids", bidList.size());
		
		return "dashboard";
	}
	
	/**
     * Displays the Manage Bids page.
     *
     * @return the name of the view to display Manage Bids page
     */
	@GetMapping("/bids")
	public String showManageBidsPage(Model model) {
		List<Bid> bidList = bidService.getAllBids();
		model.addAttribute("bidList", bidList);
		
		return "bids";
	}
}
