package com.wou.hifiusedcar.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public ModelAndView handleGeneralException(Exception ex) {
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorImg", "error.png");
        mav.addObject("errorName", "An Error Occured");
        mav.addObject("errorMsg", "An unexpected error occurred");
        return mav;
    }
	
	@ExceptionHandler(ListingNotFoundException.class)
    public ModelAndView handleStoreNotFoundException(ListingNotFoundException ex) {
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorImg", "error.png");
        mav.addObject("errorName", "An Error Occured");
        mav.addObject("errorMsg", ex.getMessage());
        return mav;
    }
}
