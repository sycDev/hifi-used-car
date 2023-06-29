package com.wou.hifiusedcar.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.service.ListingService;
import com.wou.hifiusedcar.service.UserService;

@Controller
public class ListingController {
	@Autowired
	private ListingService listingService;
	
	@Autowired
	private UserService userService;
	
	/**
     * Displays the Auction page.
     *
     * @return the name of the view to display Auction page
     */
    @GetMapping("/auction")
    public ModelAndView showAuctionPage() {
    	ModelAndView mav = new ModelAndView();
    	
    	Optional<User> currentUser = userService.findByCurrentUser();
    	if (!currentUser.isPresent()) {
    		mav.setViewName("error");
            mav.addObject("errorMsg", "Invalid login session");
    	} else {
    		User user = currentUser.get();
    		mav.setViewName("auction");
    		List<Object[]> listingList = listingService.getListingsOnGoingAuction(user.getUserId());

    		mav.addObject("listingList", listingList);
    	}
    	
        return mav;
    }
    
    /**
     * Displays the Past Auction page.
     *
     * @return the name of the view to display Past Auction page
     */
    @GetMapping("/past-auction")
    public ModelAndView showPastAuctionPage() {
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("pastAuction");
    	List<Object[]> listingList = listingService.getListingsPastAuction();
		mav.addObject("listingList", listingList);

        return mav;
    }
}
