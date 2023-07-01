package com.wou.hifiusedcar.controller;

import java.math.BigDecimal;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wou.hifiusedcar.entity.Bid;
import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.service.BidService;
import com.wou.hifiusedcar.service.ListingService;
import com.wou.hifiusedcar.service.UserService;

@Controller
public class BidController {
	@Autowired
	private BidService bidService;
	
	@Autowired
	private ListingService listingService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * Creates the new bid on a listing
	 *
	 * @param bid the bid to be created
	 * @param result the BindingResult
	 * @param redirectAttributes the redirect attributes
	 * @return the redirect page to Listing Details page
	 */
	@PostMapping("/bid/add")
	public String createNewBid(@ModelAttribute(name = "bid") Bid bid, @RequestParam("listingId") Long listingId, 
			RedirectAttributes redirectAttributes, Model model) {
		
		// Get the current logged in user
		Optional<User> currentUser = userService.findByCurrentUser();
		if (!currentUser.isPresent()) {
			redirectAttributes.addFlashAttribute("errorMsg", "Invalid login session");
            return "error";
        }

    	// Get the selected listing by id
    	Optional<Listing> selectedListing = listingService.getByListingId(listingId);
    	if (!selectedListing.isPresent()) {
    		redirectAttributes.addFlashAttribute("errorMsg", "Listing record not found");
            return "error";
    	} 
    	
    	User bidder = currentUser.get();
    	Listing listing = selectedListing.get();
    	bid.setUser(bidder);
		bid.setListing(listing);

		// Get the current highest bidding price of this listing
		BigDecimal currentHighestBid = bidService.getHighestBidPrice(listing);
		
		// Validate the bid
		String error = bidService.validateBid(bid, listing, currentHighestBid);
	    if (error != null) {
	    	redirectAttributes.addFlashAttribute("errorMsg", error);
	    	
	    	if (error.equals("Bid amount must be a positive value greater than 0")) {
	        	return "redirect:/listing/" + listingId;
	    	} else if (error.equals("Your bid price must be higher than the minimum price")) {
	        	return "redirect:/listing/" + listingId;
	        } else if (error.equals("Your bid price must be higher than the current highest bid")) {
	        	return "redirect:/listing/" + listingId;
	        } else {
	        	model.addAttribute("errorMsg", error);
	            return "error";
	        }
	    }

        bidService.create(bid);

        // Show success message and redirect back to that listing details page
        redirectAttributes.addFlashAttribute("successMsg", "Bid placed successfully");
        return "redirect:/listing/" + listingId;
	}
}
