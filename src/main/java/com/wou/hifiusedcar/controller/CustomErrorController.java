package com.wou.hifiusedcar.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomErrorController implements ErrorController {
	/**
     * Show error page with corresponding error info
     *
     * @param request the HttpServletRequest object
     * @param model   the Model object
     * @return the error view page
     */
    @GetMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        int errorCode = (int) request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String errorImg = "";
        String errorName;
        String errorMsg;
        String errorDesc;

        switch (errorCode) {
            case 403: {
                errorImg = "403.png";
                errorName = "403 Forbidden";
                errorMsg = "Sorry... You shall not pass!";
                errorDesc = "We are sorry, but you do not have access to this page or resource.";
                break;
            }

            case 404: {
                errorImg = "404.png";
                errorName = "404 Not Found";
                errorMsg = "Oops... Page Not Found";
                errorDesc = "Try click the button below to go back to the homepage.";
                break;
            }

            case 500: {
                errorImg = "500.png";
                errorName = "500 Internal Server Error";
                errorMsg = "Sorry... Your request couldn't be completed";
                errorDesc = "It's due to our server error. We are fixing the problem. Please try again later.";
                break;
            }

            default: {
            	errorImg = "error.png";
                errorName = "Unexpected Error";
                errorMsg = "Something went wrong...";
                errorDesc = "Error Code: " + errorCode;
                break;
            }
        }

        model.addAttribute("errorImg", errorImg);
        model.addAttribute("errorName", errorName);
        model.addAttribute("errorMsg", errorMsg);
        model.addAttribute("errorDesc", errorDesc);
        return "error";
    }
}
