package com.wou.hifiusedcar.controller;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wou.hifiusedcar.entity.Listing;
import com.wou.hifiusedcar.entity.User;
import com.wou.hifiusedcar.service.BidService;
import com.wou.hifiusedcar.service.ListingService;
import com.wou.hifiusedcar.service.UserService;
import com.wou.hifiusedcar.util.FormUtil;
import com.wou.hifiusedcar.util.FileUploadUtil;

@Controller
public class ListingController {
	@Autowired
	private ListingService listingService;
	
	@Autowired
	private BidService bidService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
    private FileUploadUtil fileUploadUtil;
	
	@Value("${uploadDir}")
    private String UPLOAD_DIR;
	
	/**
     * Displays the Auction page.
     *
     * @return the ModelAndView to display Auction page with on going listing records
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
     * Displays the Past Auction page
     *
     * @return the ModelAndView to display Past Auction page with past listing records
     */
    @GetMapping("/past-auction")
    public ModelAndView showPastAuctionPage() {
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("pastAuction");
    	List<Object[]> listingList = listingService.getListingsPastAuction();
		mav.addObject("listingList", listingList);

        return mav;
    }
    
    /**
     * Displays the Sell Car (Create listing) page
     *
     * @return the name of the view to display Sell Car page
     */
    @GetMapping("/sell-car")
    public String showSellCarPage() {
        return "sellCar";
    }
    
    /**
     * Creates the new listing
     *
     * @param listing the listing to be created
     * @param result the BindingResult
     * @param redirectAttributes the redirect attributes
     * @return the redirect page to My Listings page if success
     */
    @PostMapping("/listing/add")
    public String createNewListing(@Valid @ModelAttribute(name = "listing") Listing listing, BindingResult result,
    		RedirectAttributes redirectAttributes) {
    	
    	try {
            // If validation failed
            if (FormUtil.checkValidation(result, redirectAttributes)) {
                return "redirect:/sell-car";
            }
            
            // Make sure the login session is valid
        	Optional<User> currentUser = userService.findByCurrentUser();
        	if (!currentUser.isPresent()) {
        		redirectAttributes.addFlashAttribute("errorMsg", "Invalid login session");
                return "error";
        	} else {
        		// Set the owner of this listing
        		listing.setUser(currentUser.get());
        		
        		// Handle file upload
                MultipartFile imageFile = listing.getImageFile();
                if (!imageFile.isEmpty()) {
                	String fileName = handleImageUpload(imageFile, redirectAttributes);

                	if (fileName.equals("error")) {
                		// Redirect back to the add listing page with error message
                		return "redirect:/sell-car";
                	} else {
                		// Set the image file name
                		listing.setImage(fileName);
                	}
                } else {
                    // Set image to null if no image is uploaded
                	listing.setImage(null);
                }

                listingService.create(listing);
                
                // Add a success flash attribute
                redirectAttributes.addFlashAttribute("successMsg", "New listing created successfully");
                
                return "redirect:/my-listings";
        	}
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMsg", e.getMessage());
            return "error";
        }
    }
    
    /**
     * Displays the My Listings page
     *
     * @return the ModelAndView to display My Listings page with my listings records
     */
    @GetMapping("/my-listings")
    public ModelAndView showMyListingsPage() {
    	ModelAndView mav = new ModelAndView();
    	
    	// Make sure the login session is valid
    	Optional<User> currentUser = userService.findByCurrentUser();
    	if (!currentUser.isPresent()) {
    		mav.setViewName("error");
            mav.addObject("errorMsg", "Invalid login session");
    	} else {
    		User user = currentUser.get();
    		mav.setViewName("myListings");
    		List<Object[]> listingList = listingService.getMyListings(user.getUserId());

    		mav.addObject("listingList", listingList);
    	}
    	
        return mav;
    }
    
    /**
     * Update listing status.
     *
     * @param listingId the listing id
     * @param redirectAttributes the redirect attributes
     * @return the redirect page to My Listings page if success
     */
    @PostMapping("/listing/updateStatus")
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
            
            return "redirect:/my-listings";
        }
    }
    
    /**
     * Show listing details page
     *
     * @param listingId the listing id
     * @param model the model
     * @return the name of the view to display the Listing Details page
     */
    @GetMapping("/listing/{listingId}")
    public String showListingDetailsPage(@PathVariable Long listingId, Model model) {
    	// Make sure the login session is valid
        Optional<User> currentUser = userService.findByCurrentUser();
        if (!currentUser.isPresent()) {
            model.addAttribute("errorMsg", "Invalid login session");
            return "error";
        } else {
        	Optional<Listing> selectedListing = listingService.getByListingId(listingId);
        	if (!selectedListing.isPresent()) {
        		model.addAttribute("errorMsg", "Listing record not found");
        		return "error";
        	} else {
        		Listing l = selectedListing.get();
        		
        		model.addAttribute("currentUserId", currentUser.get().getUserId());
        		model.addAttribute("highestBid", bidService.getHighestBidPrice(l));
        		model.addAttribute("listing", l);

        		return "listingDetails";
        	}
        }
    }
    
    /**
	 * Handles the validation and upload of the store image file.
	 *
	 * @param imageFile           the store image file to handle
	 * @param redirectUrl         the redirect URL in case of validation errors
	 * @param redirectAttributes  the redirect attributes to add error messages
	 * @return the uploaded file name if successful, or the redirect URL if validation errors occur
	 * @throws IOException if an error occurs during the file upload
	 */
	private String handleImageUpload(MultipartFile imageFile, RedirectAttributes redirectAttributes) throws IOException {
	    String contentType = imageFile.getContentType();
	    long fileSize = imageFile.getSize();

	    if (!Objects.equals(contentType, "image/jpeg") && !Objects.equals(contentType, "image/png")) {
	    	// if image file type is invalid
	        redirectAttributes.addFlashAttribute("errMsg", "Invalid image file type");
	        return "error";
	    } else if (fileSize > 2 * 1024 * 1024) {
	    	// If the image file size exceed 2MB
	        redirectAttributes.addFlashAttribute("errMsg", "Image file size is too large");
	        return "error";
	    }

	    // Save the file to directory
	    String fileName = fileUploadUtil.uploadFile("/listing", "listingImage", imageFile);
	    return fileName;
	}
}
