package com.wou.hifiusedcar.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
     * Displays the Manage Listings page.
     *
     * @return the name of the view to display Manage Listings page
     */
	@GetMapping("/listings")
	public String showManageListingsPage(Model model) {
		List<Object[]> listingList = listingService.getAllListings();
		model.addAttribute("listingList", listingList);
		
		return "listings";
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
	
	/**
     * Update listing status by Admin
     *
     * @param listingId the listing id
     * @param redirectAttributes the redirect attributes
     * @return the redirect page to Manage Listing page if success
     */
    @PostMapping("/listing/statusUpdate")
    public String updateListingStatus(@RequestParam("listingId") Long listingId, RedirectAttributes redirectAttributes) {
        // Make sure the login session is valid
        Optional<User> currentUser = userService.findByCurrentUser();
        if (!currentUser.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid login session");
            return "error";
        } else {
            listingService.updateStatus(listingId);
            
            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Status updated successfully.");
            
            return "redirect:/dashboard/listings";
        }
    }
}
